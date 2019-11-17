clc;
close all;

%-------------------------%
% System parameters

A=[0 1;-1 0];
B=[0;1];
C=[1 0;0 1];
D=[0;0];
tau=1;

%-------------------------%
% Graph properties

Ad=[0 1 1 0 0;1 0 0 0 0;1 0 0 -1 0;0 0 -1 0 1;0 0 0 1 0]; %adjacency matrix
De=[2 0 0 0 0;0 1 0 0 0;0 0 2 0 0;0 0 0 2 0;0 0 0 0 1];   %degree matrix
Dp=[0 0 0 0 0;0 2 0 0 0;0 0 0 0 0;0 0 0 2 0;0 0 0 0 0];   %pinning matrix
L=De-Ad;                                                  %Laplacian matrix
H=L+Dp;    

%-------------------------%
% Initial conditions

x00=[-2;6];
x10=[1;-4];
x20=[-4;-2];
x30=[3;8];
x40=[-5;-5];
x50=[2;-7];

%-------------------------%
%ARE related parameters

lambda=min(eig(H));
beta=1.5; % Graph-related and ARE coupling
c2=1.2; %input-bound coupling
B1=sqrt(2*beta*lambda)*B;
mu=8;
Q=[1 0;0 1];
Q_bar=mu*Q;
[P,l,g]= care(A,B1,Q_bar);
disp(P);
disp(l);
disp(g);
disp(lambda);
Fgain=-B'*P;
Gain=P*(B)*B'*P;

%-------------------------%
% Simulation

open('Consensus_algo');
sim('Consensus_algo',30);
% open('CoDIT_static');
% sim('CoDIT_static',100);

figure
subplot (211)
plot(trajx1.time,trajx1.signals.values);
subplot (212)
plot(trajx2.time,trajx2.signals.values);

figure
subplot (211)
plot(e1.time,e1.signals.values);
subplot (212)
plot(e2.time,e2.signals.values);

figure
plot(coupling.time,coupling.signals.values);
