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

if __name__ == '__main__':

    path = os.path.join(os.getcwd(), 'data')

    m = 20
    n = 40
    k = 10
    f = 100

    n_gen = 200
    n_sim = 50
    
    sel_func = sel_1
    n_mut = 1
    mrate = 0.01
    
    R = make_env(m, n, k, f)
    C = np.random.randint(0, 4, (50,54))       

    (gens, scores) = sim(C, R, n_gen, n_sim, sel_func, n_mut, mrate)
    save(gens, path, 'gens_spc_200.50_1.01_10f.100')
    save(scores, path, 'scores_spc_200.50_1.01_10f.100')

    mean_fit = np.mean(scores, 1)

    (fig, ax) = plt.subplots()
    ax.plot(np.arange(1+n_gen), mean_fit)
    ax.xaxis.set_major_locator(MaxNLocator(integer=True))
    ax.set_xlabel('generation')
    ax.set_ylabel('average fitness')
    
    plt.show()
