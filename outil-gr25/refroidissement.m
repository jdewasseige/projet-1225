function l_H2O = refroidissement(m_NH3)
%REFROIDISSEMENT - Outil permettant de calculer la quantite d'eau 
% necessaire pour refroidir le reacteur responsable
% de la production d'ammoniac a partir de H2 et de N2.
%
% in    - m_NH3 = masse d'ammoniac en tonnes par jour
% out   - l_H2O = litres d'eau par seconde

T_reac = 500+273.15 ; % temperature du reacteur
T_eau  = 90+273.15  ; % temperature de l'eau a la sortie

% Coefficients pour les equations de Shomate
cp = getCoefficients(T_reac) ;
cp.h2o_liq = [-203.6060 1523.290 -3196.413 2474.455 ...
    3.855326 -256.5478 -488.7163 -285.8304] ; %298-500

% Calcul des enthalpies
t_eau = T_eau/1000 ;
calcH_eau  = [t_eau t_eau^2/2 t_eau^3/3 t_eau^4/4 -1/t_eau 1 0 -1] ;
delta_H_h2o = cp.h2o_liq*calcH_eau' * 1000 ;

dH_and_dS = getDeltaH_and_S(T_reac) ;
dH = dH_and_dS(1) ;
dH_reac = dH.nh3 - 1.5*dH.h2 - 0.5*dH.n2 ;

M = getMolarMasses ;

n_nh3 = m_NH3*1e6/M.nh3 ;
n_h2o = -n_nh3*dH_reac/delta_H_h2o ;

l_H2O = ceil(n_h2o*M.h2o/(1e3*3600*24)) ;

end

