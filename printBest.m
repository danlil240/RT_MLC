function printBest(mlc)
gen=length(mlc.population);
for i =1:gen
bestInd=mlc.population(i).individuals{1};
form=readmylisp_to_formal_MLC(bestInd);
syms S0 S1
base=2500*S0+4*S1;
symForm=vpa(str2sym(form)+base,4);
disp(strcat("best individual generation ",string(i),':'))
disp(symForm)
end
end