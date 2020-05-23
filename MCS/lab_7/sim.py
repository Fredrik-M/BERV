import numpy as np

from painter_play import *


# Evolve C over n_gen generations with n_sim simulations per chromosome per generation.
# C :: set of chromosomes (c x g ndarray)
# R :: set of environments (m x n x k ndarray)
# selection_func :: (C, fitness, params) => C'
#   function to select the next generation
def sim(C, R, n_gen, n_sim, selection_func, *params):

    print('Running simulation...')
    
    gens = np.zeros((C.shape[0], C.shape[1], 1 + n_gen), dtype=int)
    gens[:,:,0] = C
    scores = np.zeros((1 + n_gen, C.shape[0]))
    n_r = R.shape[2]

    print('  Generation:', end=' ')
    for i in range(n_gen):
        print(i+1, end=' ')
        for j,c in enumerate(gens[:,:,i]):
            score = 0
            for k in range(n_sim):
                (s, _, _, _) = painter_play(c, R[:,:,k % n_r])
                score += s
            
            scores[i,j] = score / n_sim

        gens[:,:,i+1] = selection_func(gens[:,:,i], scores[i,:], params)

    # simulate last generation
    for j,c in enumerate(gens[:,:,i]):
        score = 0
        for k in range(n_sim):
            (s, _, _, _) = painter_play(c, R[:,:,k % n_r])
            score += s

        scores[-1,j] = score / n_sim
        
    print('done')

    return (gens, scores)


# Selection function with single point crossover and random mutation
# params :: (max nr. of mutations, mutation rate)
def sel_1(C, fit, params):

    (n_mut, mrate) = params
    n = C.shape[0]
    generator = np.random.default_rng()
    D = np.zeros_like(C)

    i = 0
    p = fit / fit.sum()
    while i < n:
        cs = generator.choice(C, 2, replace=False, p=p)
        spc(cs[0,:], cs[1,:])
        mutate(cs[0,:], n_mut, mrate)
        mutate(cs[1,:], n_mut, mrate)
        D[i:i+2,:] = cs
        i += 2

    return D


# Single point crossover. Operates directly on c1 and c2
def spc(c1, c2):
    
    i = np.random.randint(c1.size)
    c1[i:], c2[i:] = c2[i:], c1[i:]


# Mutates at most n genes in c, each with probability p. Operates directly on c.
def mutate(c, n, p):

    for i in range(n):
        if np.random.uniform() <= p:
            j = np.random.randint(c.size)
            c[j] = np.random.randint(0, 4)
