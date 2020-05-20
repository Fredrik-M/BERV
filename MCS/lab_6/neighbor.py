#!/usr/bin/python
import numpy as np
from geometry import *


# returns a list of indices for all neighbors
# includes itself as a neighbor so it will be included in average
def get_neighbors(particles, r, x0, y0):
    
    neighbors = []

    for j,(x1,y1) in enumerate(particles):
            dist = torus_distance(x0, y0, x1, y1)

            if dist < r:
                    neighbors.append(j)

    return neighbors


# Returns a list row indices of rows in S that satisfy pred
# S     :: N-by-3 ndarray
# pred  :: (S[i,0], S[i,1], S[i,2], (a0,a1,...,an)) => bool
def get_subset(S, pred, *argv):

    indices = []
    for i, (x,y,theta) in enumerate(S):
        if pred(x, y, theta, argv):
            indices.append(i)

    return indices


# Returns a list of pairs (index, distance) for at most the n nearest neighbors, sorted ascending on distance
def get_nearest(S, x0, y0, n=1):
    
    coords = S[:,:2]
    id_pairs = [];
    if n == 0:
        n = np.size(coords, 0) - 1

    if n > 1:
        for i, (x,y) in enumerate(coords):
            if (x,y) == (x0,y0):
                continue
            
            dist = torus_distance(x0, y0, x, y)
            id_pairs.append(i,dist)
            
        id_pairs.sort(key=lambda p: p[1])

    else:
        (i,min_dist) = (-1, 100)
        for j, (x,y) in enumerate(coords):
            if (x,y) == (x0,y0):
                continue
            
            dist = torus_distance(x0, y0, x, y)
            if dist < min_dist:
                (i,min_dist) = (j,dist)
                
        id_pairs.append((i,min_dist))

    n = min(n, len(id_pairs))

    return id_pairs[:n]
            

# Returns a vector from (x0,y0) to the center of mass (average coordinates) of particles in S
def get_attr_vector(S, x0, y0, eta, noisy=False):

    coords = S[:,:2]
    avec = np.zeros(2)
    for (x,y) in coords:
        avec += torus_diff_vec(x0, y0, x, y)

    avec = np.true_divide(avec, np.size(coords, 0))
    
    if noisy:
        noise_vector = eta * angle_2_vector(rand_angle())
        avec += noise_vector      
        
    return avec


# Returns a vetctor that is the sum of a normalized vector pointing away from the center of mass of particles in S,
#   and the vector pointing away from the nearest neighbor
def get_rep_vector(S, x0, y0, eta, noisy=False):

    avec = get_attr_vector(S, x0, y0, False)
    (i, dist) = get_nearest(S, x0, y0)[0]
    nvec = torus_diff_vec(x0, y0, S[i,0], S[i,1])
    rvec = -1 * (normalize(avec) + nvec)

    if noisy:
        noise_vector = eta * angle_2_vector(rand_angle())
        rvec += noise_vector 

    return rvec


# Returns the average of the velocity vectors of parrticles in S
def get_align_vector(S, x0, y0, eta, noisy=False):

    angles = S[:,2]
    avg_vel = np.zeros(2)
    for theta in angles:
        avg_vel += angle_2_vector(theta)

    avg_vel = np.true_divide(avg_vel, np.size(angles))

    if noisy:
        noise_vector = eta * angle_2_vector(rand_angle())
        avg_vel += noise_vector

    return avg_vel


# Predicate (x,y) in zone bounded by radii r1, r2 centered at (x0,y0)
def in_zone(x, y, theta, args):
    
    (x0,y0,(r1,r2)) = args
    dist = torus_distance(x0, y0, x, y)

    return min(r1, r2) < dist and dist <= max(r1, r2)

# Predicate (x,y) in rectangular region defined by (ul,br)
def in_region(x, y, theta, args):

    (ul,br) = args
    (x0,y0) = ul
    (x1,y1) = br

    return x0 < x and x < x1 and y1 < y and y < y0
    
    




