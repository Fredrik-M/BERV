package jmetal.util;

import jmetal.core.SolutionSet;
import jmetal.util.comparators.FitnessComparator;

public class Stats {
    public static double avgFitness(SolutionSet set) {
		double fsum = 0;
		for (int i = 0; i < set.size(); ++i) {
			fsum += set.get(i).getFitness();
		}

		return fsum / set.size();
	}

	public static double avgCV(SolutionSet set) {
		double sum = 0;

		for (int i = 0; i < set.size(); i++) {
			sum += set.get(i).getOverallConstraintViolation();
		}

		return sum / set.size();
	}

	public static double[] minMaxCV(SolutionSet set) {
		double[] minMax = new double[2];
		minMax[0] = set.get(0).getOverallConstraintViolation();
		minMax[1] = set.get(0).getOverallConstraintViolation();
		double cv;

		for (int i = 1; i < set.size(); i++) {
			cv = set.get(i).getOverallConstraintViolation();
			minMax[0] = cv < minMax[0] ? cv : minMax[0];
			minMax[1] = cv > minMax[1] ? cv : minMax[1];
		}

		return minMax;
    }
    
    public static void print(SolutionSet set) {
        FitnessComparator ctor = new FitnessComparator(true);

        double fmean = avgFitness(set);
		double best = set.best(ctor).getFitness();
        double worst = set.worst(ctor).getFitness();
        double acv = avgCV(set);
		double[] cvMinMax = minMaxCV(set);
		double cv_best = set.best(ctor).getOverallConstraintViolation();
		double cv_worst = set.worst(ctor).getOverallConstraintViolation();

		System.out.printf("  Avg fitness: %.3f\n  Best: %.3f (constraint violation: %.3f)\n  Worst: %.3f (constraint violation: %.3f)\n  Avg constraint violation: %.3f\n  Min: %.3f\n  Max: %.3f\n", 
			fmean, best, cv_best, worst, cv_worst, acv, cvMinMax[0], cvMinMax[1]);

    }
}