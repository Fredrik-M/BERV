
import java.io.IOException;
import java.util.HashMap;

import jmetal.core.Algorithm;
import jmetal.core.Operator;
import jmetal.core.Problem;
import jmetal.core.Solution;
import jmetal.core.SolutionSet;
import jmetal.operators.crossover.CrossoverFactory;
import jmetal.operators.mutation.MutationFactory;
import jmetal.operators.selection.SelectionFactory;
import jmetal.util.JMException;
import jmetal.util.Stats;

import jmetal.metaheuristics.nsgaIII.NSGAIII;

import jmetal.problems.CDTLZ.*;
import jmetal.qualityIndicator.*;

public class test_nsga {
	public static void main(String args[]) throws JMException, ClassNotFoundException, IOException {
		Problem problem;
		Algorithm algorithm;
		QualityIndicator qi;
		double igd;
		double [][]lambda;

		int m = 5;
		problem = new CDTLZ4("Real", m + 9, m);

		String pf = "PF_CDTLZ4_nsga";

		algorithm = new NSGAIII(problem);
		setup(algorithm, problem);
		
		System.out.println("\nRunning NSGAIII...");
		SolutionSet population = algorithm.execute();

		System.out.println("Final population:");
		Stats.print(population);
		population.printObjectivesToFile("nsga");

		lambda = (double[][])algorithm.getReferencePoints();
		writeSphericalPF(lambda, pf);
		qi = new QualityIndicator(problem, pf);
		igd = qi.getIGD(population);
		System.out.printf("  IGD: %f\n", igd);
	}

	static void setup(Algorithm alg, Problem p) throws JMException {
		alg.setInputParameter("normalize", true);
		alg.setInputParameter("div1", 6);
		alg.setInputParameter("div2", 3);
		alg.setInputParameter("maxGenerations", 600);
        
        HashMap parameters = new HashMap();
		parameters.put("probability", 1.0);
		parameters.put("distributionIndex", 30.0);
		Operator crossover = CrossoverFactory.getCrossoverOperator("SBXCrossover", parameters);

		parameters = new HashMap();
		parameters.put("probability", 1.0 / p.getNumberOfVariables());
		parameters.put("distributionIndex", 20.0);
		Operator mutation = MutationFactory.getMutationOperator("PolynomialMutation", parameters);

		parameters = null;
		Operator selection = SelectionFactory.getSelectionOperator("RandomSelection", parameters);

		alg.addOperator("crossover", crossover);
		alg.addOperator("mutation", mutation);
		alg.addOperator("selection", selection);
	}

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
