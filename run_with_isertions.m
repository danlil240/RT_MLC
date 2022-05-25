costReadyFile = fopen('C:\RT_MLC\costReady.txt','w');
fwrite(costReadyFile,'0','char');
fclose(costReadyFile);
ctrlLawReadyFile = fopen('C:\RT_MLC\controlLawReady.txt','w');
fwrite(ctrlLawReadyFile,'0','char');
fclose(ctrlLawReadyFile);
mlc=MLC('parameters_evaluator_RT')
mlc.insert_individual('(+ (* 3400 S0) (* 7.3 S1))')
mlc.insert_individual('(+ (* 3400 S0) (* 7.4 S1))')
mlc.insert_individual('(+ (* 3402 S0) (* 7.8 S1))')
mlc.insert_individual('(+ (* 3500 S0) (* 9 S1))')
mlc.insert_individual('(+ (* 3401 S0) (* 7.3 S1))')
mlc.insert_individual('(+ (* 3600 S0) (* 9 S1))')
mlc.generate_population
mlc.go(5,1)