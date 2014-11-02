function out = electrolyse();

% Annexe 3 - Preparation du laboratoire d'electrolyse.
% Cette fonction calcule les quantites necessaires de H2SO4(5M)
% pour avoir un certain pH.
% Elle affiche ensuite un graphique representant
% [H3O+](eq)/[H2SO4](initial) en fonction du pH.

pH = [0 1 2 3 5];

result = zeros(5,2);
X = zeros(1,5);
Y = zeros(1,5);

for i=1:5
    result(i,:) = calcH2SO4(pH(i));
    fprintf('Pour un pH = %d, il faut %.3f ml de H2SO4(5M). \n', pH(i), result(i,1)*200);
    Y(i) = [result(i,2)/result(i,1)];
    X(i) = -log10(result(i,2));
end

x = linspace(0,14,100);
var = zeros(100,2);

for i= 0:100:14
    var(i,:) = calcH2SO4(x(i)) ;
end
    
for i =1:100
    y(i) = var(i,2)/var(i,1) ;
end

plot(x,y,'b',X,Y,'b.','Markersize',15);

title('Évolution du pH en fonction de [H_{3}O^{+}]_{équilibre}/[H_{2}SO_{4}]_{initial}');
xlabel('[H_{3}O^{+}]_{équilibre}/[H_{2}SO_{4}]_{initial}');
ylabel('pH');

end 

function out = calcH2SO4(pH);

% Resolution du systeme d'equations a deux inconnues
% pour determiner la quantite initiale de H2SO4 ainsi
% que la quantite a l'equilibre de H3O+.

Ka = 0.0126;

syms x ksi positive real

eq1 = Ka == (x + ksi)/(x - ksi)*ksi;
eq2 = pH == -log10(x + ksi);

[x,ksi] = solve(eq1,eq2,x,ksi);

n_H2SO4 = double(x);
n_H3O = double(x + ksi);

out = [n_H2SO4 n_H3O];

end

function out = calcpH(a);

% Resolution du systeme de trois equations a trois inconnues
% pour determiner le pH à partir de a = [H3O+]/[H2SO4].

Ka = 0.0126;

syms x ksi pH positive real

eq1 = Ka == (x + ksi)/(x - ksi)*ksi;
eq2 = pH == -log10(x + ksi);
eq3 = a == (x + ksi)/x;

[x,ksi,pH] = solve(eq1,eq2,eq3,x,ksi,pH);

out = pH;

end