function out = electrolyse();

% Groupe 1125
% Annexe 3 - Preparation du laboratoire d'electrolyse.
% Cette fonction calcule les quantites necessaires de NaOH(5M) 
% pour avoir un certain pH (11,12,13).
% Cette fonction calcule les quantites necessaires de H2SO4(5M)
% pour avoir un certain pH (0,1,2,3,5).
% Elle affiche ensuite un graphique representant
% [H3O+](eq)/[H2SO4](initial) en fonction du pH.

% Pour obtenir les r�sultats, les m�thodes de calcul et le graphe demand�s,
% il suffit d'ex�cuter electrolyse().

pH1 = [11 12 13];

result1 = zeros(1,3);

for i=1:3
    result1(i) = 1e-14/10^-pH1(i);
    fprintf('Pour un pH = %d, il faut %.3f ml de NaOH(5M). \n', pH1(i), result1(i)*200);
end

pH2 = [0 1 2 3 5];

result2 = zeros(5,2);

for i=1:5
    result2(i,:) = calcH2SO4(pH2(i));
    fprintf('Pour un pH = %d, il faut %.3f ml de H2SO4(5M). \n', pH2(i), result2(i,1)*200);
end

x = linspace(0,14,1000); % pH en abscisses

for i=1:length(x)
    y(i) = ((10.^-x(i)) + 0.0252)/((10.^-x(i)) + 0.0126); % [H3O+]/[H2SO4] en fct du pH
end

plot(x,y,'b');

title('�volution de [H_{3}O^{+}]_{�quilibre}/[H_{2}SO_{4}]_{initial} en fonction du pH');
xlabel('pH');
ylabel('[H_{3}O^{+}]_{�quilibre}/[H_{2}SO_{4}]_{initial}');

end 

function out = calcH2SO4(pH);

% Resolution du systeme d'equations a deux inconnues
% pour determiner la quantite initiale de H2SO4 ainsi
% que la quantite a l'equilibre de H3O+.

Ka = 0.0126;

syms x ksi positive real

eq1 = Ka == (x + ksi)/(x - ksi)*ksi; % equation obtenue avec le tableau de reaction
eq2 = pH == -log10(x + ksi); % pH = -log(H3O+)

[x,ksi] = solve(eq1,eq2,x,ksi);

n_H2SO4 = double(x);
n_H3O = double(x + ksi);

out = [n_H2SO4 n_H3O];

end