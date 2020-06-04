
import java.io.*;
import java.util.HashMap;

import jmetal.core.Algorithm;
import jmetal.core.Operator;
import jmetal.core.Problem;
import jmetal.core.Solution;
import jmetal.core.SolutionSet;
import jmetal.operators.crossover.CrossoverFactory;
import jmetal.operators.mutation.MutationFactory;
import jmetal.util.JMException;
import jmetal.util.Stats;

import jmetal.metaheuristics.thetadea.ThetaDEA;
import jmetal.metaheuristics.thetadea.ThetaDEA_ext;

import jmetal.problems.CDTLZ.*;
import jmetal.qualityIndicator.*;

public class test {
	public static void main(String args[]) throws JMException, ClassNotFoundException, IOException {
		Problem problem;
		Algorithm algorithm;
		QualityIndicator qi;
		double igd;
		double hv;
		double [][]lambda;

		int m = 5;
		problem = new CDTLZ3("Real", m + 9, m);

		String pf = "PF_CDTLZ3";

		algorithm = new ThetaDEA(problem);
		setup(algorithm, problem);
		
		// Run vanilla
		System.out.println("\nRunning vanilla algorithm...");
		SolutionSet population = algorithm.execute();

		System.out.println("Final population:");
		Stats.print(population);
		population.printObjectivesToFile("vanilla");

		lambda = (double[][])algorithm.getReferencePoints();
		writeSphericalPF(lambda, pf);
		qi = new QualityIndicator(problem, pf);
		igd = qi.getIGD(population);
		hv = qi.getHypervolume(population);
		System.out.printf("  IGD: %f\n", igd);
		System.out.printf("  HV: %f\n", hv);

		// Run extended
		algorithm = new ThetaDEA_ext(problem);
		setup(algorithm, problem);

		System.out.println("\nRunning extended algorithm...");
		population = algorithm.execute();

		System.out.println("Final population:");
		Stats.print(population);
		population.printObjectivesToFile("extended");

		qi = new QualityIndicator(problem, pf);
		igd = qi.getIGD(population);
		hv = qi.getHypervolume(population);
		System.out.printf("  IGD: %f\n", igd);
		System.out.printf("  HV: %f\n", hv);
	}


	static void setup(Algorithm alg, Problem p) throws JMException {
		alg.setInputParameter("normalize", true);
		alg.setInputParameter("theta", 5.0);
		alg.setInputParameter("div1", 6);
		alg.setInputParameter("div2", 0);
		alg.setInputParameter("maxGenerations", 1000);
		
		HashMap parameters = new HashMap();
		parameters.put("probability", 1.0);
		parameters.put("distributionIndex", 20.0);
		Operator crossover = CrossoverFactory.getCrossoverOperator("SBXCrossover", parameters);

		parameters = new HashMap();
		parameters.put("probability", 1.0 / p.getNumberOfVariables());
		parameters.put("distributionIndex", 20.0);
		Operator mutation = MutationFactory.getMutationOperator("PolynomialMutation", parameters);

		alg.addOperator("crossover", crossover);
		alg.addOperator("mutation", mutation);
	}


/* 	static double[][] sphericalPF(double [][]lambda) {
		int n = lambda.length;
		int m = lambda[0].length;
		double[][] u = new double[n][m];
		
		double sum;
		double scale;

		for(int i = 0; i < n; i++) {
			sum = 0;
			scale = 0;

			for(int j = 0; j < m; j++) {
				sum += Math.pow(lambda[i][j], 2);
			}
			scale = 1 / Math.sqrt(sum);

			for(int j = 0; j < m; j++) {
				u[i][j] = scale * lambda[i][j];
			}
		}

		return u;
	} */

	static void writeSphericalPF(double [][]lambda, String fname) {
		SolutionSet set = new SolutionSet();
		
		int m = lambda[0].length;
		double sum;
		double scale;

		for(double[] v : lambda) {
			sum = 0;
			scale = 0;

			for(int i = 0; i < m; i++) {
				sum += Math.pow(v[i], 2);
			}
			scale = 1 / Math.sqrt(sum);
			
			Solution s = new Solution(m);
			for(int i = 0; i < m; i++) {
				s.setObjective(i, scale * v[i]);
			}
			
			set.add(s);
		}
		
		set.printObjectivesToFile(fname);
	}


} //
