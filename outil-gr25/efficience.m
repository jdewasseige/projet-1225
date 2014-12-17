function purge3D

n=5
t=linspace(600,800,n);
p=linspace(150,400,n);
s=zeros(n,n);
for i=1:n
for j=1:n
results=(purge(1500,t(i),p(j),0.05));
eff=results(2);
e(i,j)=eff;
end
end
plot(t,p,e)

hold on;
title('Rendement du réacteur en fonction de la température et de la pression');
xlim([600 800])
xlabel('Température (K)')
ylim([150 400])
ylabel('Pression (bar)')
zlim([0 1])
zlabel('Rendement')
end
