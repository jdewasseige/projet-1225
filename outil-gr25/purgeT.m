function out = purgeT(m_NH3, p, T1, T2, n)

x=linspace(T1,T2,n);
y=zeros(n,1);

for i=1:n
    y(i)=purge(m_NH3,x(i),p);
end

plot(x,y);
hold on;
str = sprintf('Fraction du recyclage à purger en fonction de la température, à une pression de %d bar', p);
title(str)
ylabel('X')
ylim([0 1])
xlim([T1 T2])
xlabel('Temperature (K)')
end
