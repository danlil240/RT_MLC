function [T,Y] = PhisicalModel(m)

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

xDataFile = fopen('x_data.txt','r');
a = textscan(xDataFile,'%f','Delimiter',{'\t',','}, 'CollectOutput',1);
Y=zeros(length(a{1}),4);
Y(:,1)=a{1};
fclose(xDataFile);
dxDataFile = fopen('dx_data.txt','r');
a = textscan(dxDataFile,'%f','Delimiter',{'\t',','}, 'CollectOutput',1);
Y(:,2)=a{1};
fclose(dxDataFile);
jDataFile = fopen('j_data.txt','r');
a = textscan(jDataFile,'%f','Delimiter',{'\t',','}, 'CollectOutput',1);
Y(:,3)=a{1};
fclose(jDataFile);
uDataFile = fopen('u_data.txt','r');
a = textscan(uDataFile,'%f','Delimiter',{'\t',','}, 'CollectOutput',1);
Y(:,4)=a{1};
fclose(uDataFile);
T=linspace(0,0.5,size(Y,1));
costReadyFile = fopen('C:\RT_MLC\costReady.txt','w');
fwrite(costReadyFile,'0','char');
fclose(costReadyFile);
end