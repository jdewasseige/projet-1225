function out = purgeP(m_NH3, T, p1, p2, n)

x=linspace(p1,p2,n);
y=zeros(n,1);

for i=1:n
    y(i)=purge(m_NH3,T,x(i));
end

plot(x,y);
hold on;
str = sprintf('Fraction du recyclage � purger en fonction de la pression, � une temp�rature de %d K', T);
<<<<<<< HEAD
title(str)
ylabel('Fraction X du recyclage � purger')
=======
title(str) 
ylabel('X')
>>>>>>> 33d26b9f5941987a5fac11701e9c1e9e1af7b2b4
ylim([0 1])
xlim([p1 p2])
xlabel('Pression (bar)')
end
