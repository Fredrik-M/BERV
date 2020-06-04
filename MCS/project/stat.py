
import os
import numpy as np
import matplotlib.pyplot as plt


def read_fit(path):
    
    f = open(path, 'r')
    print(f.readline())


if __name__ == "__main__":

    PATH_ = os.path.join(os.getcwd(), "src", "data")
    read_fit(os.path.join(PATH_, 'CDTLZ2_fit_0_vanilla'))
    read_fit(os.path.join(PATH_, 'CDTLZ2_qi_vanilla'))



