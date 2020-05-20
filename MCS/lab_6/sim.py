import cv2, io, os
import numpy as np
import math as m
import matplotlib.pyplot as plt

from cv2 import VideoWriter, VideoWriter_fourcc
from geometry import *
from neighbor import *


# Run simulation with intrinsic (default) or extrinsic noise
# Returns N-by-3-by-steps+1 state matrix
# r_attr, r_align, r_rep :: (r1, r2) define the attraction, alignment and repulsion zones
def simulate(N, eta, r_attr, r_align, r_rep, steps, mode='intrinsic'):
    
    print('Running simulation...', end=' ')
    
    delta_t = 1 / steps
    # state matrix N-by-3-by-steps [[x,y,theta], ...]
    S = np.zeros((N, 3, steps + 1))
    # generate random initial state
    S[:,0:2,0] = np.random.uniform(0, 1, (N, 2))
    S[:,2,0] = np.random.uniform(-m.pi, m.pi, N)

    # set extrinsic noise parameter
    if mode == 'extrinsic':
        noisy = True
    else:
        if mode != 'intrinsic':
            print('[unrecognized mode \'' + mode + '\', defaulting to intrinsic] ...', end=' ')
        noisy = False

    # set up ordered list of radii pairs and map each to corresponding get_vector function
    R = sorted([r_attr, r_align, r_rep], key=lambda p: max(p), reverse=True)
    vector_funcs = { r_attr : get_attr_vector, r_align : get_align_vector, r_rep : get_rep_vector }

    V = np.zeros((len(R)+1,2))
    for i in range(0, steps):
        s = S[:,:,i]
        for j, (x_j, y_j, theta_j) in enumerate(s):
            # get all particles that can influence the current particle
            indices = get_subset(s, in_zone, x_j, y_j, (0,max(R[0])))
            neighborhood = s[indices,:]
            # include own velocity vector
            V[0,:] = angle_2_vector(theta_j)
            # get direction vectors for each behaviour and zone
            for k, rp in enumerate(R):
                if rp == (0,0):
                    break
                indices = get_subset(neighborhood, in_zone, x_j, y_j, rp)
                particles = neighborhood[indices,:]
                if np.size(particles) > 0:
                    V[k+1,:] = vector_funcs[rp](particles, x_j, y_j, eta, noisy)

            # next state for particle j
            new_angle = vector_2_angle(np.sum(V, 0))
            if not noisy:
                # intrinsic noise
                new_angle += eta * rand_angle()

            S[j,2,i+1] = new_angle
            new_pos = [x_j,y_j] + delta_t * angle_2_vector(new_angle)
            S[j,0:2,i+1] = np.mod(new_pos, 1)
            
    print('done')
    
    return S


def plot_vectors(ax, S):
    
    for i, (x, y, theta) in enumerate(S):
        # plot point
        ax.scatter(x, y, marker = ".", color='black')

        # plot tail
        v = angle_2_vector(theta)
        x1 = x - (0.025 * v[0])
        y1 = y - (0.025 * v[1])
        ax.plot([x, x1], [y, y1], color='black')

    ax.set_xticks([])
    ax.set_yticks([])
    ax.set_xlim(0, 1)
    ax.set_ylim(0, 1)

    return


# Create animation from state matrix S and save as path/name.mp4
def animate(S, path, name):
    
    print('Creating animation...', end=' ')
    if not os.path.exists(path):
        os.mkdir(path)

    buf = io.BytesIO()
    (fig, ax) = plt.subplots()

    plot_vectors(ax, S[:,:,0])
    fig.savefig(buf, format='png')
    bytearr = np.frombuffer(buf.getvalue(), dtype=np.uint8)
    img = cv2.imdecode(bytearr, cv2.IMREAD_ANYCOLOR)
    height, width, layers = img.shape

    fname = os.path.join(path, name + ".mp4")
    out = cv2.VideoWriter(fname, cv2.VideoWriter_fourcc(*'mp4v'), 15, (width, height))
    out.write(img)

    for i in range(1, np.shape(S)[2]):
        ax.clear()
        buf.seek(0)
        ax.cla()
        plot_vectors(ax, S[:,:,i])
        fig.savefig(buf, format='png')
        bytearr = np.frombuffer(buf.getvalue(), dtype=np.uint8)
        img = cv2.imdecode(bytearr, cv2.IMREAD_ANYCOLOR)
        out.write(img)

    out.release()
    fig.clf()
    print('done, saved ' + fname)
    
    return


# Save state matrix as path/name.npy
def save(S, path, name):
    
    if not os.path.exists(path):
        os.mkdir(path)

    fname = os.path.join(path, name + ".npy")
    np.save(fname, S)
    print('Saved ' + fname)
    
    return


