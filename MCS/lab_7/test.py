import os
import numpy as np

from painter_play import *
from auxil import *
from sim import *

if __name__ == '__main__':

    path = os.path.join(os.getcwd(), 'data')

    gens_e = np.load(os.path.join(path, 'gens_spc_200.50_1.01__2.npy'))
    scores_e = np.load(os.path.join(path, 'scores_spc_200.50_1.01__2.npy'))

    gens_f = np.load(os.path.join(path, 'gens_spc_200.50_1.01_10f.100.npy'))
    scores_f = np.load(os.path.join(path, 'scores_spc_200.50_1.01_10f.100.npy'))

    (i, r) = get_best(scores_e)
    best_gen = gens_e[:,:,i]
    c_e = gens_e[r[0][0],:,i]

    (i, r) = get_best(scores_f)
    best_gen = gens_f[:,:,i]
    c_f = gens_f[r[0][0],:,i]

    m = 20
    n = 40
    
    R_e = make_env(m, n, 1, 0)
    R_f = make_env(m, n, 1, 100)

    (_, x_e, y_e, env_e) = painter_play(c_e, R_e[:,:,0])
    (_, x_f, y_f, env_f) = painter_play(c_f, R_f[:,:,0])
    
    (fig, ax) = plot_painter(x_e, y_e, env_e)
    (fig, ax) = plot_painter(x_f, y_f, env_f)
    
    plt.show()
