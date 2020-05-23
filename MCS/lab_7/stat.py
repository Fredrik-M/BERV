import os
import numpy as np

from matplotlib.ticker import MaxNLocator
from painter_play import *
from auxil import *
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


def stats(gens, scores, R_test):
    (i, r) = get_best(scores)
    n_gens = gens.shape[2]
    best_gen = gens[:,:,i]
    best_c = gens[r[0][0],:,i]
    print('  Best generation:', i)
    print('  Best score:', r[0][1], '(chromosome', r[0][0], ')')

    # plot mean fitness and diversity
    mean_fit = np.mean(scores, 1)
    div = np.zeros(n_gens)
    for j in range(n_gens):
        C = gens[:,:,j]
        div[j] = diversity(C)

    (fig, ax, wax) = make_wrapped_subplots(2, 1, sharex='all')
    ax[0].plot(np.arange(n_gens), mean_fit)
    ax[1].plot(np.arange(n_gens), div)
    wax.set_xlabel('generation')
    ax[0].set_ylabel(r'$\bar{f}(C_n)$')
    ax[1].set_ylabel(r'$d(C_n)$')

    # evaluate chromosomes at and above 95th percentile from best gen on R_test
    p90i = get_percentile(scores[i,:], 90)
    C = best_gen[p90i,:]
    (_, s) = sim(C, R_test, 1, 50, lambda C, f, p: C)
    smean = np.mean(s, 1).sum() / 2
    print('  Mean evaluation score, >=95th percentile chromosomes (100 sims): ', smean)
    

if __name__ == '__main__':

    path = os.path.join(os.getcwd(), 'data')

    m = 20
    n = 40

    gens_e = np.load(os.path.join(path, 'gens_spc_200.50_1.01__2.npy'))
    scores_e = np.load(os.path.join(path, 'scores_spc_200.50_1.01__2.npy'))
                       
    gens_f = np.load(os.path.join(path, 'gens_spc_200.50_1.01_10f.100.npy'))
    scores_f = np.load(os.path.join(path, 'scores_spc_200.50_1.01_10f.100.npy'))
    
    R_e = make_env(m, n, 1, 0)
    R_f = make_env(m, n, 50, 100)     

    # empty room
    stats(gens_e, scores_e, R_f)
    # furnished rooms
    stats(gens_f, scores_f, R_e)

    # box plots
    (i_e, _) = get_best(scores_e)
    (i_f, _) = get_best(scores_f)
    
    (fig, ax, wax) = make_wrapped_subplots(2, 1, sharex='all')
    ax[0].boxplot(scores_e[i_e,:], vert=False)
    ax[1].boxplot(scores_f[i_f,:], vert=False)
    ax[0].set_ylabel('empty')
    ax[1].set_ylabel('furnished')
    wax.set_xlabel('fitness')
    ax[0].yaxis.set_tick_params(labelcolor='w', left=False, right=False)
    ax[1].yaxis.set_tick_params(labelcolor='w', left=False, right=False)
    
    plt.show()

    
