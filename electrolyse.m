function out = electrolyse()
% Annexe 3 - Preparation du laboratoire d'electrolyse.
% Cette fonction calcule les quantites necessaires de H2SO4(5M)
% pour avoir un certain pH.
% Elle affiche ensuite un graphique representant
% [H3O+](eq)/[H2SO4](initial) en fonction du pH.


ph = [0 1 2 3 5] ;

result = zeros(5, 2);

for i =1:5
    result(i,:) = calcH2SO4(ph(i)) ;
    fprintf('Pour un pH = %d, il faut %.3f ml de H2SO4(5M). \n', ph(i), result(i,1)*200);
end

end 

function out = calcH2SO4(ph)
% Resolution du systeme d'equations a deux inconnues
% pour determiner la quantite initiale de H2SO4 ainsi
% que la quantite a l'equilibre de H3O+.


Ka = 0.0126 ;

syms x ksi positive real

eq1= Ka == (x + ksi)*ksi/(x - ksi) ;
eq2= ph == -log10(x + ksi) ;

[x,ksi] = solve(eq1,eq2,x,ksi) ;

n_H2SO4 = double(x) ;
n_H3O = double(ksi) ;

out = [n_H2SO4 n_H3O] ;

end