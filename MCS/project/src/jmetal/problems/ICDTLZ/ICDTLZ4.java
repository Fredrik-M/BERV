package jmetal.problems.ICDTLZ;

import jmetal.core.Problem;
import jmetal.core.Solution;
import jmetal.core.Variable;
import jmetal.encodings.solutionType.BinaryRealSolutionType;
import jmetal.encodings.solutionType.RealSolutionType;
import jmetal.util.JMException;


public class ICDTLZ4 extends Problem {

    private double[] hpCoefficients_;

	public ICDTLZ4(String solutionType) throws ClassNotFoundException {
		this(solutionType, 12, 5);
	}

	public ICDTLZ4(String solutionType, Integer numberOfVariables, Integer numberOfObjectives) {
		numberOfVariables_ = numberOfVariables;
		numberOfObjectives_ = numberOfObjectives + 1;
		numberOfConstraints_ = 7;
		problemName_ = "ICDTLZ4";

		if(numberOfVariables < 12) {
			System.out.println("Error: number of variables must be >= 12");
			System.exit(-1);
		}

		lowerLimit_ = new double[numberOfVariables_];
        upperLimit_ = new double[numberOfVariables_];
        hpCoefficients_ = new double[numberOfVariables];
		for (int var = 0; var < numberOfVariables_; var++) {
			lowerLimit_[var] = 0.0;
            upperLimit_[var] = 1.0;

            int sign = Math.random() <= 0.5 ? -1 : 1; 
            hpCoefficients_[var] = sign * Math.random();
		}

		if (solutionType.compareTo("BinaryReal") == 0)
			solutionType_ = new BinaryRealSolutionType(this);
		else if (solutionType.compareTo("Real") == 0)
			solutionType_ = new RealSolutionType(this);
		else {
			System.out.println("Error: solution type " + solutionType
					+ " invalid");
			System.exit(-1);
        }
	} // CDTLZ4


	public void evaluate(Solution solution) throws JMException {
        int n = numberOfObjectives_ - 1;
		Variable[] gen = solution.getDecisionVariables();

		double[] x = new double[numberOfVariables_];
		double[] f = new double[n];
		double alpha = 100.0;
		int k = numberOfVariables_ - n + 1;

		for (int i = 0; i < numberOfVariables_; i++)
			x[i] = gen[i].getValue();

		double g = 0.0;
		for (int i = numberOfVariables_ - k; i < numberOfVariables_; i++)
			g += (x[i] - 0.5) * (x[i] - 0.5);

		for (int i = 0; i < n; i++)
			f[i] = 1.0 + g;

		for (int i = 0; i < n; i++) {
			for (int j = 0; j < n - (i + 1); j++)
				f[i] *= java.lang.Math.cos(java.lang.Math.pow(x[j], alpha)
						* (java.lang.Math.PI / 2.0));
			if (i != 0) {
				int aux = n - (i + 1);
				f[i] *= java.lang.Math.sin(java.lang.Math.pow(x[aux], alpha)
						* (java.lang.Math.PI / 2.0));
			} // if
		} // for

		for (int i = 0; i < n; i++)
            solution.setObjective(i, f[i]);
            
        evaluateConstraints(solution);
        double cv = solution.getOverallConstraintViolation();
        solution.setObjective(n, cv);
    } // evaluate
    

    public void evaluateConstraints(Solution solution) throws JMException {
        Variable[] gen = solution.getDecisionVariables();
        
        double bv = 0;
        double cv1 = 0;
        double cv2 = 0;
        double cv3 = 0;
        double gcv1 = 0;
        double gcv2 = 0;
        double gcv3 = 0;

        double x0 = gen[0].getValue();
        double x1 = gen[1].getValue();
        double x2 = gen[2].getValue();
        // (x0, x1, x2) on surface y = x0^2 - x1^2
        gcv1 = Math.abs(x2 - (Math.pow(x0, 2) - Math.pow(x1, 2)));
        double x3 = gen[3].getValue();
        // (x0, x3) on unit circle
        gcv2 = Math.abs(1 - (Math.pow(x0, 2) + Math.pow(x3, 2)));

        double x4 = gen[4].getValue();
        // x4 in [-1, 1]
        cv1 = 1 - Math.abs(x4) > 0 ? 0 : Math.abs(x4) - 1;
        double x5 = gen[5].getValue();
        // x5 == 0.5
        cv2 = Math.abs(x5 - 0.5);
        // x6 > x5
        double x6 = gen[6].getValue();
        cv3 = x6 - x5 > 0 ? 0 : x5 - x6;

        // (x6, ..., xn-3) on hyperplane
        double sum = 0;
        for(int i = 6; i < numberOfVariables_ - 3; i++) {
            double x = gen[i].getValue();
            sum += hpCoefficients_[i] * x;
        }
        gcv3 = Math.abs(0.5 - sum);

        // general bounds abs(x) in [1E-6, 1E6] U {0}
        for(int i = 0; i < numberOfVariables_; i++) {
            double x = Math.abs(gen[i].getValue());
            if(x != 0) {
                bv += x < 1E-6 ? 1E-6 - x : 0;
                bv += x > 1E6 ? x - 1E6: 0;                
            }
        }

        double total = bv + cv1 + cv2 + cv3 + gcv1 + gcv2 + gcv3;
        solution.setOverallConstraintViolation(total); 
    }

}