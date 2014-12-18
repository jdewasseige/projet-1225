function efficiencePlot
%EFFICIENCEPLOT - Cette fonction realise un graphique 3D qui permet
%                 de determiner les conditions optimales de pression et
%                 de temperature dans le reacteur de synthese.

n=5;

t=linspace(600,800,n);
p=linspace(150,400,n);
x=0.05;

s=zeros(n,n);

for i=1:n
    fprintf('%d \t',n-i);
    for j=1:n
        s(i,j)=equilibriumSimulation(1500,t(i),p(j),x);
    end
end

fprintf('\n');

figure
surf(p,t,s);

hold on;
title('Rendement du reacteur de synthese en fonction de la pression et de la temperature, avec une purge de 5% du recyclage');
xlabel('Pression [bar]') ;
ylabel('Temperature [K]');
zlabel('Rendement');
hold off;

end
