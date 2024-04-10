function[x1,x2,x3,y]=CSTR2(x1,x2,x3,u,Ts)

x1ini = x1;
x2ini = x2;
x3ini = x3;

k11 = Ts*[1-4*x1-0.5*x2^2];
k21 = Ts*[3*x1-x2-1.5*x2^2+u];
k31 = Ts*[x2^2-x3];

x1 = x1ini + k11/2;
x2 = x2ini + k21/2;
x3 = x3ini + k31/2;
k12 = Ts*[1-4*x1-0.5*x2^2];
k22 = Ts*[3*x1-x2-1.5*x2^2+u];
k32 = Ts*[x2^2-x3];

x1 = x1ini + k12/2;
x2 = x2ini + k22/2;
x3 = x3ini + k32/2;
k13 = Ts*[1-4*x1-0.5*x2^2];
k23 = Ts*[3*x1-x2-1.5*x2^2+u];
k33 = Ts*[x2^2-x3];

x1 = x1ini + k13/2;
x2 = x2ini + k23/2;
x3 = x3ini + k33/2;
k14 = Ts*[1-4*x1-0.5*x2^2];
k24 = Ts*[3*x1-x2-1.5*x2^2+u];
k34 = Ts*[x2^2-x3];

x1 = x1ini + k11/6 + k12/3 + k13/3 + k14/6;
x2 = x2ini + k21/6 + k22/3 + k23/3 + k24/6;
x3 = x3ini + k31/6 + k32/3 + k33/3 + k34/6;

y = x3;
