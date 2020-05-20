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
plt.rc('axes', titlesize=MEDIUM)
plt.rc('axes', labelsize=MEDIUM)
plt.rc('xtick', labelsize=SMALLER)
plt.rc('ytick', labelsize=SMALLER)
plt.rc('legend', fontsize=SMALL)


if __name__ == '__main__':

    path = os.path.join(os.getcwd(), 'sim')
    
    N = 40   
    steps = 100
    r = 0.12

    n_sim = 10
    etas = np.linspace(0, 1, 21)

    # Intrinsic noise
    p_intr = np.zeros((np.size(etas), n_sim, steps+1))
    for i, e in enumerate(etas):
        for j in range(n_sim):
            s = simulate(N, e, (0,0), (0,r), (0,0), steps)
            for k in range(0, steps+1):
                p_intr[i,j,k] = polarisation(s[:,:,k])

    # mean over time and simulations
    pm_intr = np.mean(p_intr, 2, keepdims=True)
    pmm_intr = np.mean(pm_intr, 1)

    # Extrinsic noise
    p_extr = np.zeros((np.size(etas), n_sim, steps+1))
    for i, e in enumerate(etas):
        for j in range(n_sim):
            s = simulate(N, e, (0,0), (0,r), (0,0), steps, 'extrinsic')
            for k in range(0, steps+1):
                p_extr[i,j,k] = polarisation(s[:,:,k])

    # mean over time and simulations
    pm_extr = np.mean(p_extr, 2, keepdims=True)
    pmm_extr = np.mean(pm_extr, 1)

    # Plot mean polarisation
    fig1 = plt.figure()
    bax = fig1.add_subplot(1, 1, 1)
    bax.spines['top'].set_color('none')
    bax.spines['bottom'].set_color('none')
    bax.spines['left'].set_color('none')
    bax.spines['right'].set_color('none')
    bax.tick_params(labelcolor='w', top=False, bottom=False, left=False, right=False)
    bax.set_ylabel(r'$\bar{\psi}(t;\eta)$')

    ax = fig1.subplots(2, 1, sharex=True)
    ax[0].scatter(etas, pmm_intr)
    ax[1].scatter(etas, pmm_extr)
    
    ax[1].set_xlabel(r'$\eta$')
    ax[0].set_ylabel(r'   $a$', rotation='horizontal')
    ax[1].set_ylabel(r'   $b$', rotation='horizontal')
    ax[0].yaxis.set_label_position('right')
    ax[1].yaxis.set_label_position('right')
    ax[0].set_title('Mean polarisation')
    

    # mean over simulations for eta = 0.2
    t = 1/steps * np.arange(0, steps+1, 1)
    psm_intr = np.mean(p_intr[4,:,:], 0)
    psm_extr = np.mean(p_extr[4,:,:], 0)

    # Plot polatisation vs t for eta = 0.2
    fig2 = plt.figure()
    bax = fig2.add_subplot(1, 1, 1)
    bax.spines['top'].set_color('none')
    bax.spines['bottom'].set_color('none')
    bax.spines['left'].set_color('none')
    bax.spines['right'].set_color('none')
    bax.tick_params(labelcolor='w', top=False, bottom=False, left=False, right=False)
    bax.set_ylabel(r'$\psi(t)$')

    ax = fig2.subplots(2, 1, sharex=True)
    ax[0].plot(t, psm_intr)
    ax[1].plot(t, psm_extr)
    
    ax[1].set_xlabel(r'$t$')
    ax[0].set_ylabel(r'   $a$', rotation='horizontal')
    ax[1].set_ylabel(r'   $b$', rotation='horizontal')
    ax[0].yaxis.set_label_position('right')
    ax[1].yaxis.set_label_position('right')
    ax[0].set_title('Polarisation, $\eta = 0.2$')
    
    plt.show()

    

     

