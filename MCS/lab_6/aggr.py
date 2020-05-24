import numpy as np
import matplotlib.pyplot as plt
import os

from matplotlib import rc
from measure import *
from sim import *


SMALLER = 12
SMALL = 16
MEDIUM = 20
BIG = 22

plt.rc('font', size=MEDIUM)
plt.rc('axes', titlesize=SMALL)
plt.rc('axes', labelsize=MEDIUM)
plt.rc('xtick', labelsize=SMALLER)
plt.rc('ytick', labelsize=SMALLER)
plt.rc('legend', fontsize=SMALL)


if __name__ == '__main__':

    path = os.path.join(os.getcwd(), 'sim')
    
    N = 40   
    steps = 100
    
    r = 0.12
    r_attr = (r/2,r)
    r_align = (0,r/2)
    r_rep = (0,0)

    n_sim = 10
    etas = np.linspace(0, 1, 21)


    # Attraction, alignment
    p = np.zeros((np.size(etas), n_sim, steps+1))
    c = np.zeros((np.size(etas), n_sim, steps+1))
    for i, e in enumerate(etas):
        for j in range(n_sim):
            s = simulate(N, e, r_attr, r_align, r_rep, steps)
            for k in range(0, steps+1):
                p[i,j,k] = proximity(s[:,:,k])
                c[i,j,k] = clustering(s[:,:,k])

    # mean over time and simulations
    pm = np.mean(p, 2, keepdims=True)
    pmm = np.mean(pm, 1)

    cm = np.mean(c, 2, keepdims=True)
    cmm = np.mean(cm, 1)


    # Plot mean proximity and clustering
    fig, ax = plt.subplots(2, 1, sharex=True)
    ax[0].scatter(etas, pmm)
    ax[1].scatter(etas, cmm)
    
    ax[1].set_xlabel(r'$\eta$')
    ax[0].set_ylabel(r'$\bar{p}(t;\eta)$')
    ax[1].set_ylabel(r'$\bar{c}(t;\eta)$')
    ax[0].set_title('Mean proximity and clustering')


    # mean over simulations for eta = 0.2
    t = 1/steps * np.arange(0, steps+1, 1)
    psm = np.mean(p[4,:,:], 0)
    csm = np.mean(c[4,:,:], 0)

    # Plot proximity and clustering vs t for eta = 0.2
    fig, ax = plt.subplots(2, 1, sharex=True)
    ax[0].plot(t, psm)
    ax[1].plot(t, csm)
    
    ax[1].set_xlabel(r'$t$')
    ax[0].set_ylabel(r'$p(t)$')
    ax[1].set_ylabel(r'$c(t)$')
    ax[0].set_title('Proximity and clustering, $\eta = 0.2$')

    plt.show()

    

     

