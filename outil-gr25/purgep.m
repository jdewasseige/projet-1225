function out = purgeP(m_NH3, T, p1, p2, n)

x=linspace(p1,p2,n);
y=zeros(n,1);

for i=1:n
    y(i)=purge(m_NH3,T,x(i));
end

plot(x,y);
hold on;
str = sprintf('Fraction du recyclage à purger en fonction de la pression, à une température de %d K', T);
title(str) 
ylabel('X')
ylim([0 1])
xlim([p1 p2])
xlabel('Pression (bar)')
end
