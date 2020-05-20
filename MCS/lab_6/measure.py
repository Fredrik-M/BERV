import numpy as np

from math import sqrt, pi
from geometry import *
from neighbor import *

def polarisation(S):

    angles = S[:,2]
    n = len(angles)
    s = np.sin(angles)
    c = np.cos(angles)
    
    return 1/n * sqrt(np.sum(s)**2 + np.sum(c)**2)


def proximity(S):

    coords = S[:,:2]
    dist = 0
    for (x,y) in coords:
        (i,d) = get_nearest(S, x, y)[0]
        dist += 0.5*sqrt(2) - d

    return dist / np.size(coords, 0)


def clustering(S, r=0.12):

    coords = S[:,:2]
    N = np.size(S, 0)
    e = N * pi * r**2 - 1
    c = 0

    for (x0,y0) in coords:
        indices = get_subset(S, in_zone, x0, y0, (0,r))
        n = len(indices)
        c += (n - e)**2
        
    return c / N
