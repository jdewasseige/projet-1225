function plot_simulation 

n=10
t=linspace(600,800,n);
p=linspace(150,400,n);
s=zeros(n,n);
for i=1:n
for j=1:n
s(i,j)=(simulation(1500,t(i),p(j),0.05));
end
end
plot(t,p,s)

hold on;
title('Rendement du réacteur en fonction de la température et de la pression, avec une purge de 5% du recyclage');
xlim([600 800])
xlabel('Température (K)')
ylim([150 400])
ylabel('Pression (bar)')
zlim([0 1])
zlabel('Rendement')
end
