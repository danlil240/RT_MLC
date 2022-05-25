clear S0 S1
global NInd S0 S1
strInd=char(mlc.population.individuals(656))
Ind=readmylisp_to_formal_MLC(strInd)
syms S0 S1
eval(['NInd=' Ind])
% y=sym2poly(NInd)