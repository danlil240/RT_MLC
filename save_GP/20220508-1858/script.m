% C:\RT_MLC\SAVE_GP\20220508-1858\SCRIPT parameters scropt for MLC
% Type mlc=MLC('C:\RT_MLC\save_GP\20220508-1858\script') to create corresponding MLC object
parameters.size = 200;
parameters.sensors = 2;
parameters.sensor_spec = 0;
parameters.sensor_list = 0;
parameters.controls = 1;
parameters.sensor_prob = 0.2;
parameters.leaf_prob = 0.3;
parameters.range = 10;
parameters.precision = 6;
parameters.opsetrange = [1 3];
parameters.formal = 0;
parameters.end_character = '';
parameters.maxdepth = 8;
parameters.maxdepthfirst = 4;
parameters.mindepth = 2;
parameters.mutmaxdepth = 15;
parameters.mutmindepth = 2;
parameters.mutsubtreemindepth = 2;
parameters.generation_method = 'mixed_ramped_gauss';
parameters.gaussigma = 3;
parameters.ramp = [2 3 4];
parameters.maxtries = 10;
parameters.mutation_types = [1 2 3 4];
parameters.elitism = 10;
parameters.probrep = 0.1;
parameters.probmut = 0.3;
parameters.probcro = 0.6;
parameters.selectionmethod = 'tournament';
parameters.tournamentsize = 7;
parameters.lookforduplicates = 1;
parameters.simplify = 1;
parameters.evaluation_method = 'standalone_function';
parameters.evaluation_function = 'evaluator_fun_RT';
parameters.indfile = 'ind.dat';
parameters.Jfile = 'J.dat';
parameters.exchangedir = 'C:\RT_MLC\evaluator0';
parameters.evaluate_all = 1;
parameters.ev_again_best = 1;
parameters.ev_again_nb = 5;
parameters.ev_again_times = 5;
parameters.artificialnoise = 0;
parameters.execute_before_evaluation = '';
parameters.badvalue = 1e+06;
parameters.badvalues_elim = 'none';
parameters.preevaluation = 0;
parameters.preev_function = '';
parameters.save = 1;
parameters.saveincomplete = 1;
parameters.verbose = 3;
parameters.fgen = 250;
parameters.show_best = 1;
parameters.problem_variables = 1;
parameters.savedir = 'C:\RT_MLC\save_GP\20220508-1858';
