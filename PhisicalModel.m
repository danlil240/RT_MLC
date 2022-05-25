function J = PhisicalModel(m)
% ctrlLawReady=1;
% while ctrlLawReady==1
%     ctrlLawReadyFile = fopen('C:\RT_MLC\controlLawReady.txt','r');
%     ctrlLawReady=fscanf(ctrlLawReadyFile, '%f');
%     fclose(ctrlLawReadyFile);
%     pause(0.2)
% end
ctrlLawFile = fopen('C:\RT_MLC\controlLaw.txt','w');
fwrite(ctrlLawFile,m,'char');
fclose(ctrlLawFile);
ctrlLawReadyFile = fopen('C:\RT_MLC\controlLawReady.txt','w');
fwrite(ctrlLawReadyFile,'1','char');
fclose(ctrlLawReadyFile);
costReady=0;
while costReady==0
    costReadyFile = fopen('C:\RT_MLC\costReady.txt','r');
    costReady=fscanf(costReadyFile, '%f');
    fclose(costReadyFile);
    pause(0.2)
end
jFile = fopen('C:\RT_MLC\cost.txt','r');
J=fscanf(jFile, '%f',[1 1]);
fclose(jFile);
costReadyFile = fopen('C:\RT_MLC\costReady.txt','w');
fwrite(costReadyFile,'0','char');
fclose(costReadyFile);
end