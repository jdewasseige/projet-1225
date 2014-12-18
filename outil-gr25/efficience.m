function purge3D

n=10;

t=linspace(600,800,n);
p=linspace(150,400,n);

s=zeros(n,n);

for i=1:n
    for j=1:n
        results=purge2(1500,t(i),p(j));
        eff=results(2);
        s(i,j)=eff;
    end
end

figure
contourf(p,t,s);

hold on;
title('Rendement du reacteur de synthese en fonction de la pression et de la temperature');
xlabel('Pression [bar]') ;
ylabel('Temperature [K]');
zlabel('Rendement');
hold off;

end
