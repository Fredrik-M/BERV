
import os
import numpy as np
import matplotlib.pyplot as plt


def load(directory, problem, N, M):
    # vanilla
    path = os.path.join(directory, problem + '_qi_vanilla')
    qi_vanilla = np.loadtxt(path)
    fit_vanilla = np.zeros((N, M, 2))
    for i in range(20): 
        path = os.path.join(directory, problem + '_fit_' + str(i) + '_vanilla')
        fit_vanilla[i,:,:] = np.loadtxt(path)

    # extended
    path = os.path.join(directory, problem + '_qi_extended')
    qi_extended = np.loadtxt(path)
    fit_extended = np.zeros((N, M, 2))
    for i in range(20): 
        path = os.path.join(directory, problem + '_fit_' + str(i) + '_extended')
        fit_extended[i,:,:] = np.loadtxt(path)

    return (qi_vanilla, fit_vanilla, qi_extended, fit_extended)


def write_stats(path, qi, fit, header):
    median_qi = np.median(qi, 0)
    igd_range = (np.min(qi[:,0]), np.max(qi[:,0]))
    hv_range = (np.min(qi[:,1]), np.max(qi[:,1]))

    avg_median_fit = np.mean(np.median(fit[:,:,0], 1))
    avg_avg_cv = np.mean(np.mean(fit[:,:,1], 1))
    avg_best_fit_cv = np.mean(np.min(fit, 1), 0)

    avg_best_sol_cv = 0
    for ss in fit:
        (index, best) = (-1, np.inf)
        for i, (f, cv) in enumerate(ss):
            if f < best:
                (index, best) = (i, f)

        avg_best_sol_cv += ss[index,1]

    avg_best_sol_cv /= fit.shape[0]
        
    f = open(path, 'w')
    f.write(header + '\n')
    f.write('IGD best: ' + str(igd_range[0]) + '\n')
    f.write('IGD median: ' + str(median_qi[0]) + '\n')
    f.write('IGD worst: ' + str(igd_range[1]) + '\n\n')
    f.write('HV best: ' + str(hv_range[1]) + '\n')
    f.write('HV median: ' + str(median_qi[1]) + '\n')
    f.write('HV worst: ' + str(hv_range[0]) + '\n\n')
    f.write('Avg median fitness: ' + str(avg_median_fit) + '\n')
    f.write('Avg constraint violation: ' + str(avg_avg_cv) + '\n')
    f.write('Avg best fitness: ' + str(avg_best_fit_cv[0]) + '\n')
    f.write('Avg best constraint violation: ' + str(avg_best_fit_cv[1]) + '\n')
    f.write('Avg constraint violation of best solution: ' + str(avg_best_sol_cv))

    f.close()


if __name__ == '__main__':

    PATH_ = os.path.join(os.getcwd(), 'src', 'data_IC')
    path_ = 'data_IC'
    N = 462

    # CDTLZ2
    (qi_van, fit_van, qi_ext, fit_ext) = load(PATH_, 'ICDTLZ2', 20, N)
    path = os.path.join(path_, 'ICDTLZ2_vanilla.txt')
    write_stats(path, qi_van, fit_van, 'ICDTLZ2, vanilla, 20 executions of 1000 generations\n')
    path = os.path.join(path_, 'ICDTLZ2_extended.txt')
    write_stats(path, qi_ext, fit_ext, 'ICDTLZ2, extended, 20 executions of 1000 generations\n')

    # CDTLZ3
    (qi_van, fit_van, qi_ext, fit_ext) = load(PATH_, 'ICDTLZ3', 20, N)
    path = os.path.join(path_, 'ICDTLZ3_vanilla.txt')
    write_stats(path, qi_van, fit_van, 'ICDTLZ3, vanilla, 20 executions of 1000 generations\n')
    path = os.path.join(path_, 'ICDTLZ3_extended.txt')
    write_stats(path, qi_ext, fit_ext, 'ICDTLZ3, extended, 20 executions of 1000 generations\n')

    # CDTLZ4
    (qi_van, fit_van, qi_ext, fit_ext) = load(PATH_, 'ICDTLZ4', 20, N)
    path = os.path.join(path_, 'ICDTLZ4_vanilla.txt')
    write_stats(path, qi_van, fit_van, 'ICDTLZ4, vanilla, 20 executions of 1000 generations\n')
    path = os.path.join(path_, 'ICDTLZ4_extended.txt')
    write_stats(path, qi_ext, fit_ext, 'ICDTLZ4, extended, 20 executions of 1000 generations\n')




