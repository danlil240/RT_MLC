gen=length(mlc.population);
bestInd=mlc.population(gen).individuals{1};
form=readmylisp_to_formal_MLC(bestInd);
syms S0 S1
symForm=vpa(str2sym(form),4);
disp('best individual:')
disp(symForm)