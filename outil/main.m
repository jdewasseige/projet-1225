function out = main(T, m_NH3)
% Outil de gestion du plant de formation d'ammoniac
% a partir de methane.
% 
% in - T     = temperature en KELVIN reacteur
%    - m_NH3 = masse d'ammoniac en tonnes par jour
% 
% out- m_CH4 = masse de methane en tonnes par jour
%    - m_H2O = masse d'eau en tonnes par jour
%    - m_O2  = masse d'oxygene en tonnes par jour
%    - m_N2  = masse de nitrogen en tonnes par jour
%    - m_Ar  = masse d'argon en tonnes par jour
%    - nombre de tubes

myAssert((T >= 700 && T <=1200),0, strcat('La temperature fournie', ...
    ' est en dehors de l''intervalle couvert par coefficients de Shomate.'));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Calcul des enthalpies et entropies standards a la temperature T
values = getDeltaH_and_S(T);
dH = values(1);
dS = values(2);

% reaction1
dH.r1 = dH.co + 3*dH.h2 - dH.h2o - dH.ch4 ;
dS.r1 = dS.co + 3*dS.h2 - dS.h2o - dS.ch4 ;
dG_r1 = dH.r1 - T*dS.r1 ;
% reaction2
dH.r2 = dH.co2 + dH.h2 - dH.h2o - dH.co ;
dS.r2 = dS.co2 + dS.h2 - dS.h2o - dS.co ;
dG_r2 = dH.r2 - T*dS.r2 ;

% constantes d'eq K
R = 8.3144621 ;
p_tot = 26e5 ;
p_st = 1e5 ;

K_r1 = exp(-dG_r1/(R*T)) ;
K_r2 = exp(-dG_r2/(R*T)) ;

% resolution des equations pour trouver le 
% nombre de moles de CH4 et de H2O 
moles = solveG(m_NH3,p_tot,K_r1,K_r2) ;
n_CH4 = moles(1) ;
n_H2O = moles(2) ;
ksi1  = moles(3) ;
ksi2  = moles(4) ;

% Masses molaires
M = getMolarMasses();

% masses
m_CH4= M.ch4*n_CH4/1e6 ;
m_H2O= M.h2o*n_H2O/1e6 ;
m_O2 = M.o2*((7/884)* m_NH3) ; 
m_N2 = M.n2*((1/34)* m_NH3) ;
m_Ar = M.ar*((1/2652)* m_NH3) ;


fprintf('\n In REF1 - Quantite de CH4 en tonnes par jour : %.2f \n', m_CH4) ;
fprintf('In REF1 - Quantite de H20 en tonnes par jour : %.2f \n', m_H2O) ;

fprintf('In REF2 - Quantite de O2 (REF 2) en tonnes par jour : %.2f \n', m_O2) ;
fprintf('In REF2 - Quantite de N2 (REF 2) en tonnes par jour : %.2f \n', m_N2) ;
fprintf('In REF2 - Quantite de Ar (REF 2) en tonnes par jour : %.2f \n', m_Ar) ;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Nombre de tubes 

tubes = getTubesNumber(n_CH4,n_H2O,T) ;

fprintf('\nNombre de tubes : %d \n \n', ceil(double(tubes))) ;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Bilan energetique

oven_masses = getHovenMasses(ksi1,ksi2,dH.r1,dH.r2);
m_CH4_four = oven_masses(1) ;
m_O2_four  = oven_masses(2) ;

fprintf('Quantite de CH4 (FOUR) en tonnes par jour : %.2f \n', m_CH4_four) ;
fprintf('Quantite de O2 (FOUR) en tonnes par jour : %.2f \n', m_O2_four) ;

%out = oven_masses(3);

end

