clc
clear all;
close all;
A_undir = ones(4)-eye(4);
D_undir = diag(sum(A_undir,1)); 
L_undir = D_undir - A_undir;
[V,D,W] = eig(L_undir);
eig_dir = round(diag(D),4); 
lambda_1 = eig_dir(1);     
lambda_2 = eig_dir(2);     
lambda_3 = eig_dir(3);   
lambda_4 = eig_dir(4);
w1 = W(:,1);   
tau = 1/lambda_2;
t_initial = 0;
t_final = 10;
x_initial = [1 2 3 4]'; 
c_dir = w1'*x_initial; 
evalue = eig(L_undir);
[t,x] = ode45(@(t,x) CTC(t,x,L_undir),[t_initial t_final],x_initial); 
figure(1)
plot(graph(A_undir)) 
title('Undirected Graph Representation')
figure(2)
plot(t,x)
legend('Node 1','Node 2','Node 3','Node 4') 
title('Discrete-time consensus for Undirected Graph')
xlabel({'t','(in seconds)'})
ylabel('x')
figure(3) 
plot(evalue,0,'r*','LineWidth',1)
title('Eigenvalues of the Laplacian Matrix For Undirected Graph')
xlabel('real')
ylabel('imag')
axis equal; 
grid on 

function  xdot = CTC(t,x,L)     
xdot=-L*x;  
end
