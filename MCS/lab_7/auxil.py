import io, os
import numpy as np
import matplotlib.pyplot as plt
from matplotlib.colors import ListedColormap


cmap = ListedColormap(np.array([[1,1,1,1],[0.25,0.25,0.25,1],[0.2,0.9,0.2,0.8]]))

def plot_painter(xpos, ypos, env, cmap=cmap):
    
    (m,n) = env.shape
    (fig, ax) = plt.subplots()
    
    ax.imshow(env[1:m-1,1:n-1], cmap=cmap)
    ax.plot(ypos-1, xpos-1, linestyle=':', color='gray')
    ax.plot(ypos[0]-1, xpos[0]-1, marker='o', color='black', fillstyle='none')
    ax.plot(ypos[-1]-1, xpos[-1]-1, marker='x', color='black')

    ax.set_xticks(np.arange(n-1)-0.5)
    ax.set_yticks(np.arange(m-1)-0.5)
    ax.tick_params(which='both', left=False, bottom=False, labelleft=False, labelbottom=False)
    ax.grid(color=[0.8,0.8,0.8])

    return (fig,ax)


def make_wrapped_subplots(i, j, **sp_kwargs):
    fig = plt.figure()
    wax = fig.add_subplot(1, 1, 1)
    wax.spines['top'].set_color('none')
    wax.spines['bottom'].set_color('none')
    wax.spines['left'].set_color('none')
    wax.spines['right'].set_color('none')
    wax.tick_params(labelcolor='w', top=False, bottom=False, left=False, right=False)

    ax = fig.subplots(i, j, **sp_kwargs)

    return (fig, ax, wax)


# Save ndarray as path/name.npy
def save(a, path, name):
    
    if not os.path.exists(path):
        os.mkdir(path)

    fname = os.path.join(path, name + ".npy")
    np.save(fname, a)
    print('Saved ' + fname)
    
    return


# Returns a set of k envirnments with walls, m x n internal squares and f randomly placed furniture squares.
def make_env(m, n, k, f):
    
  env = np.zeros((m+2,n+2,k))
  for r in range(k):
      while env[:,:,r].sum() < f:
        i, j = np.random.randint(1, m), np.random.randint(1, n)
        env[i,j,r] = 1
  
      # walls
      env[0,:,r] = 1
      env[-1,:,r] = 1
      env[:,0,r] = 1
      env[:,-1,r] = 1

  return env


# i :: the index of the generation with highest average fitness.
# ranked :: sorted list of tuples (j,s), where j is chromsome index and s is score
def get_best(scores):
    
    mean_fit = np.mean(scores, 1)
    best_mean_fit = max(mean_fit)
    i = np.nonzero(mean_fit == best_mean_fit)[0][0]            
    ranked = sorted(zip(np.arange(scores.shape[1]), scores[i,:]), key=lambda p: p[1], reverse=True)

    return (i, ranked)


# Returns the indices of the chromosomes with score >= to the q:th percentile
def get_percentile(scores, q):

    if scores.ndim == 2:
        p = np.percentile(scores, q, axis=1)
    else:
        p = np.percentile(scores, q)

    return np.nonzero(scores >= p)[0]


# A measure of genetic diversity in a set C of chromosomes
def diversity(C):

    (n,g) = C.shape
    s = 0
    for c in C:
        D = np.sum(C != c, 1)
        s += D.sum() / (g * (n-1))

    return s / n
    

