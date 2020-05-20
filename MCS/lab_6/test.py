import numpy as np
import matplotlib.pyplot as plt
import os

from matplotlib import rc
from measure import *
from sim import *


if __name__ == '__main__':

    path = os.path.join(os.getcwd(), 'sim')
    
    N = 70   
    steps = 150
    eta = 0.2
    
    r = 0.15
    r_attr = (2/3*r,r)
    r_align = (1/3*r,2/3*r)
    r_rep = (0,1/3*r) 

    S = simulate(N, eta, r_attr, r_align, r_rep, steps)
##    c = np.zeros(steps+1)
##    for i in range(steps+1):
##        c[i] = (clustering(S[:,:,i], r))
##        
##    t = 1/steps * np.arange(0, steps+1, 1)
##
##    fig1, ax1 = plt.subplots()
##    ax1.plot(t, c)

    animate(S, path, 'ex_attr_align_rep_70.2.15')

##    R = np.random.uniform(0, 1, (N, 3, 100))
##    pr = np.zeros(100)
##    cr = np.zeros(100)
##
##    for i in range(0, 100):
##        pr[i] = proximity(R[:,:,i])
##        cr[i] = clustering(R[:,:,i])
##
##    print('R mean proximity: ', np.mean(pr))
##    print('R mean clustering: ', np.mean(cr))
    
##    cr = np.zeros(10)
##    rho = np.linspace(0.05, 0.3, 6)
##    for r in rho:
##        print('\nr = ', r)
##        for i in range(0, 10):
##            cr[i] = (clustering(R[:,:,i], r))
##
##        print('min: ', min(cr))
##        print('max: ', max(cr))
##        print('mean: ', np.mean(cr))
##
##    print('')
##
##    for r in rho:
##        for i in range(steps+1):
##            c[i] = clustering(S[:,:,i], r)
##            
##        print('S mean, r = ', r, ' :', np.mean(c))

    
##    plt.show()


    

     

