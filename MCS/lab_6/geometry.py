#!/usr/bin/python
import numpy as np 
from math import atan2, pi, sin, cos, sqrt


def vector_2_angle(v):
    
	x = v[0]
	y = v[1]
	return atan2(y,x)


# generate random angle theta between -pi - pi
def rand_angle():
    
	theta = np.random.uniform(-pi,pi)
	return theta


# returns angle unit vector
def angle_2_vector(theta):
    
	x = cos(theta)
	y = sin(theta)
	
	# transform to unit vector
	v1 = np.array([x,y])
	v2 = np.array([0,0])
	uv = unit_vector(v1,v2)

	return uv

# Unit vector
def unit_vector(v1, v2):
    
	vector = v1 - v2
	dist = euclidean_distance(v1[0], v1[1], v2[0],v2[1])
	uv = vector / dist
	
	return uv


def normalize(v):

    v = v**2
    return sqrt(np.sum(v))


# Euclidean distance between (x,y) coordinates
def euclidean_distance(x1, y1, x2, y2):
    
	return sqrt((x1 - x2)**2 + (y1 - y2)**2)


# Euclidean distance between (x,y) coordinates on 1 x 1 torus
def torus_distance(x1, y1, x2, y2):
    
	x_diff = min(abs(x1 - x2), 1 - abs(x1 - x2))
	y_diff = min(abs(y1 - y2), 1 - abs(y1 - y2))
	return sqrt(x_diff**2 + y_diff**2)


# Returns a vector with direction from (x0,y0) to (x1,y1) on the 1 x 1 torus and magnitude torus_distance(x0, y0, x1, y1)
def torus_diff_vec(x0, y0, x1, y1):

    x_diff = min(abs(x1 - x0), 1 - abs(x1 - x0))
    y_diff = min(abs(y1 - y0), 1 - abs(y1 - y0))
    
    t_dist = sqrt(x_diff**2 + y_diff**2)
    e_dist = euclidean_distance(x0, y0, x1, y1)

    if e_dist <= t_dist:
        return np.array([x1, y1]) - np.array([x0, y0])

    x = np.sign(x0 - x1) * x_diff
    y = np.sign(y0 - y1) * y_diff

    return np.array([x, y])
