function tubes = getTubesNumber(n_CH4,n_H2O,T)
% Cette fonction calcule le nombre de tubes necessaires 
% pour amener le methane et l'eau dans le reformeur primaire.
%
% input  - n_CH4 : nombres de mol de methane
%          n_H2O : nombres de mol d'eau
%          T     : temperature du reformeur primaire
% output - tubes : nombre de tubes

R = 8.3144621 ;

p_tubes = 31e5 ; % pression a l'entree
r_tubes = 5e-2 ; % rayon des tubes
v_tubes = 2 ;    % vitesse superficielle

tubes = (((n_CH4+n_H2O)/(24*3600))*R*T)/...
    (pi*r_tubes^2*v_tubes*p_tubes) ;

end

