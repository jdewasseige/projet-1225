function out = solveG(m_NH3,T,p_tot)

R = 8.3144621 ;
p_st = 1e5 ;

% Constantes d'equilibres des reactions du reformeur primaire
K = getEqConstantsRef(T) ;

syms ksi1 ksi2 n_CH4 n_H2O positive

% Equilibre des pressions - reaction 1 du reformage primaire.
eq1= K.r1 == (p_tot^2 *(ksi1 - ksi2)*(3*ksi1 + ksi2)^3)...
    /(p_st^2 *(n_CH4 + n_H2O + 2*ksi1)^2 *(n_CH4 - ksi1)* ...
    (n_H2O - ksi1 - ksi2)) ;

% Equilibre des pressions - reaction 2 (WGS) du reformage primaire.
eq2= K.r2 == (ksi2*(3*ksi1 + ksi2)) ...
    /((ksi1 - ksi2)*(n_H2O - ksi1 - ksi2)) ;

% Donnee a l'entree du reformage secondaire.
eq3= n_CH4 - ksi1 == (7/442)*m_NH3*1e6 ;

% Donnee a la sortie du reformage secondaire.
eq4= 4*ksi1 == (9/221)*m_NH3*1e6 ;

% Resoudre le systeme de 4 equations a 4 inconnues. 
[n_CH4,n_H2O,ksi1,ksi2] = ... 
    solve(eq1, eq2, eq3, eq4, n_CH4, n_H2O, ksi1, ksi2);


% On renvoit des megamoles.
out = double(vpa([n_CH4,n_H2O,ksi1,ksi2])) ;

end
