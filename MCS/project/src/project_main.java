import java.io.*;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedList;

import jmetal.core.Algorithm;
import jmetal.core.Operator;
import jmetal.core.Problem;
import jmetal.core.Solution;
import jmetal.core.SolutionSet;
import jmetal.operators.crossover.CrossoverFactory;
import jmetal.operators.mutation.MutationFactory;
import jmetal.util.JMException;

import jmetal.metaheuristics.thetadea.ThetaDEA;
import jmetal.metaheuristics.thetadea.ThetaDEA_ext;

import jmetal.problems.CDTLZ.*;
import jmetal.qualityIndicator.*;


public class project_main {

    static final String PATH_ = "data/";

    public static void main(String[] args) throws JMException, IOException, ClassNotFoundException {
        Problem prob;
        int m = 5;
        int N = 20;
        
        // CDTLZ2
        prob = new CDTLZ2("Real", m + 9, m);
        runComparison(prob, N);

        // CDTLZ3
        prob = new CDTLZ3("Real", m + 9, m);
        runComparison(prob, N);

        // CDTLZ4
        prob = new CDTLZ4("Real", m + 9, m);
        runComparison(prob, N);
    }


    static void runComparison(Problem prob, int N) throws JMException, IOException, ClassNotFoundException {
        Algorithm alg;
        LinkedList<SolutionSet> setList;

        // vanilla
        alg = new ThetaDEA(prob);
        setup(alg, prob);
        
        setList = new LinkedList<SolutionSet>();
        System.out.println("Running vanilla algorithm, " + prob.getName() + "...");
        for(int i = 0; i < N; i++) {
            setList.add(alg.execute());
        }

        writeStats(alg, setList, "vanilla");

        // extended
        alg = new ThetaDEA_ext(prob);
        setup(alg, prob);

        setList = new LinkedList<SolutionSet>();
        System.out.println("Running extended algorithm, " + prob.getName() + "...");
        for(int i = 0; i < N; i++) {
            setList.add(alg.execute());
        }

        writeStats(alg, setList, "extended");
    }


    static void writeStats(Algorithm alg, Iterable<SolutionSet> setList, String suffix) throws IOException {
        Iterator<SolutionSet> setIt = setList.iterator();
        Iterator<Solution> solIt;
		String path;
		String name = alg.getProblem().getName();

		double [][]lambda = (double[][])alg.getReferencePoints();
		writeSphericalPF(lambda, "PF_tmp");
		QualityIndicator qi = new QualityIndicator(alg.getProblem(), "PF_tmp");

		String path_qi = PATH_ + name + "_qi_" + suffix;
		FileOutputStream fos_qi = new FileOutputStream(path_qi);
		OutputStreamWriter osw_qi = new OutputStreamWriter(fos_qi);
		BufferedWriter bw_qi = new BufferedWriter(osw_qi);

		int i = 0;
		while(setIt.hasNext()) {
            SolutionSet set = setIt.next();
            solIt = set.iterator();

			path = PATH_ + name + "_fit_" + String.valueOf(i) + "_" + suffix;
			FileOutputStream fos = new FileOutputStream(path);
			OutputStreamWriter osw = new OutputStreamWriter(fos);
			BufferedWriter bw = new BufferedWriter(osw);
    
            while(solIt.hasNext()) {
                Solution sol = solIt.next();
				String line = String.valueOf(sol.getFitness()) + " " + String.valueOf(sol.getOverallConstraintViolation());
				bw.write(line);
				bw.newLine();
            }
	
			bw.close();

			double IGD = qi.getIGD(set);
			double HV = qi.getHypervolume(set);
			String line = String.valueOf(IGD) + " " + String.valueOf(HV);
			bw_qi.write(line);
			bw_qi.newLine();

			i++;
		}

		bw_qi.close();
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
    

    static void writeSphericalPF(double [][]lambda, String path) {
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
		
		set.printObjectivesToFile(path);
	}


} //