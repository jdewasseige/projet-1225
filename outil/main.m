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
% Constantes d'equilibres des reactions du reformeur primaire
K = getEqConstantsRef(T) ;

% Pression dans le reformeur primaire
p_tot = 26e5 ;

% resolution des equations pour trouver le 
% nombre de moles de CH4 et de H2O 
moles = solveG(m_NH3,p_tot,K.r1,K.r2) ;
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


fprintf('\nIn REF1 - Quantite de CH4 en tonnes par jour : %.2f \n', m_CH4) ;
fprintf('In REF1 - Quantite de H20 en tonnes par jour : %.2f \n', m_H2O) ;

fprintf('In REF2 - Quantite de O2 en tonnes par jour : %.2f \n', m_O2) ;
fprintf('In REF2 - Quantite de N2 en tonnes par jour : %.2f \n', m_N2) ;
fprintf('In REF2 - Quantite de Ar en tonnes par jour : %.2f \n', m_Ar) ;

%printMassesDetails(m_NH3,n_CH4,n_H2O,ksi1,ksi2);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Nombre de tubes 

tubes = getTubesNumber(n_CH4,n_H2O,T) ;

fprintf('\nNombre de tubes : %d \n \n', ceil(double(tubes))) ;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Bilan energetique

T_four = 1300 ; 

oven_masses = getHovenMasses(ksi1,ksi2,T,T_four);
m_CH4_four = oven_masses(1) ;
m_O2_four  = oven_masses(2) ;
%m_CO2_four  = oven_masses(3) ;

fprintf('In Four - Quantite de CH4 en tonnes par jour : %.2f \n', m_CH4_four) ;
fprintf('In Four - Quantite de O2  en tonnes par jour : %.2f \n', m_O2_four) ;
%fprintf('Out Four - Quantite de CO2 (FOUR) en tonnes par jour : %.2f \n', m_CO2_four) ;


%out = oven_masses(3);

end

    
