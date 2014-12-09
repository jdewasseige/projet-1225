function out = main(m_nh3,T,print)
% Outil de gestion du plant de formation d'ammoniac
% a partir de methane.
% 
% in - T     : temperature en KELVIN reacteur
%    - m_NH3 : masse d'ammoniac en tonnes par jour
%    - print : mettre a 0 pour ne pas afficher les resultats
%              (ils sont affiches par defaut)
% 
% out- m_CH4 = masse de methane en tonnes par jour
%    - m_H2O = masse d'eau en tonnes par jour
%    - m_O2  = masse d'oxygene en tonnes par jour
%    - m_N2  = masse de nitrogen en tonnes par jour
%    - m_Ar  = masse d'argon en tonnes par jour
%    - nombre de tubes

if nargin < 3
    print = 1
end

myAssert((T >= 700 && T <=1200),0, strcat('La temperature fournie', ...
    ' est en dehors de l''intervalle couvert par coefficients de Shomate.'));
% if ~(T >= 700 && T <=1200)
%     error('hellooo');
% end
% assert((T >= 700 && T <=1200),'hello');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Details des flux massiques de l'ensemble du procede 

p_tot = 26e5 ; % pression dans le reformeur primaire 

m = getMassesDetails(m_nh3,T,p_tot) ;

if print
    printMassesDetails(m);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Bilan energetique

T_four = 1300 ; 

moles = solveG(m_nh3,T,p_tot); % equilibre dans le reformeur primaire
n_ch4 = moles(1);
n_h2o = moles(2);
ksi1  = moles(3);
ksi2  = moles(4); 

oven_masses = getHovenMasses(ksi1,ksi2,T,T_four);
m.ch4_four = oven_masses(1) ;
m.o2_four  = oven_masses(2) ;
m.co2_four  = oven_masses(3) ;
m.h2o_four  = oven_masses(4) ;

if print 
    fprintf('\nFour (en tonnes par jour) \n');
    fprintf('IN  - CH4 : %.2f \n', m.ch4_four) ;
    fprintf('IN  - O2  : %.2f \n', m.o2_four) ;
    fprintf('OUT - CO2 : %.2f \n', m.co2_four) ;
end

out = m;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Nombre de tubes 

tubes = getTubesNumber(n_ch4,n_h2o,T) ;

if print
    fprintf('\nNombre de tubes : %d \n\n', ceil(double(tubes))) ;
end

end

    
