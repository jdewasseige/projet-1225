function K = getEqConstantsRef(T)
% Cette fonction renvoit un 'structure array' contenant les 
% constantes d'equilibre des reactions du reformer primaire 
% qui est a la temperature 'T'.

R = 8.3144621 ;

% Calcul des enthalpies et entropies standards a la temperature T
dH_and_dS = getDeltaH_and_S(T);
dH = dH_and_dS(1);
dS = dH_and_dS(2);

% reaction1
dH.r1 = dH.co + 3*dH.h2 - dH.h2o - dH.ch4 ;
dS.r1 = dS.co + 3*dS.h2 - dS.h2o - dS.ch4 ;
dG_r1 = dH.r1 - T*dS.r1 ;

% reaction2
dH.r2 = dH.co2 + dH.h2 - dH.h2o - dH.co ;
dS.r2 = dS.co2 + dS.h2 - dS.h2o - dS.co ;
dG_r2 = dH.r2 - T*dS.r2 ;

K.r1 = exp(-dG_r1/(R*T)) ;
K.r2 = exp(-dG_r2/(R*T)) ;

end
