function out = main(T, m_nh3)
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
% Pression dans le reformeur primaire
p_tot = 26e5 ;

moles = solveG(m_nh3,T,p_tot) ;
n_ch4 = moles(1);
n_h2o = moles(2);
ksi1  = moles(3);
ksi2  = moles(4);
% masses
m = getMassesDetails(m_nh3,T,p_tot) ;

fprintf('\nIn REF1 - Quantite de CH4 en tonnes par jour : %.2f \n', m.ch4_in) ;
fprintf('In REF1 - Quantite de H20 en tonnes par jour : %.2f \n', m.h2o_in) ;
fprintf('In REF2 - Quantite de O2 en tonnes par jour : %.2f \n', m.o2_ref2) ;
fprintf('In REF2 - Quantite de N2 en tonnes par jour : %.2f \n', m.n2_ref2) ;
fprintf('In REF2 - Quantite de Ar en tonnes par jour : %.2f \n', m.ar_ref2) ;

printMassesDetails(m);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Nombre de tubes 

tubes = getTubesNumber(n_ch4,n_h2o,T) ;

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

    
