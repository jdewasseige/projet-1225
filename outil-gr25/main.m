function masses = main(m_nh3,T,p_ref1,var,print,out)
%MAIN - Outil de gestion du plant de formation d'ammoniac
% a partir de methane.
% 
% in - m_NH3 : masse d'ammoniac en tonnes par jour
%    - T     : temperature en KELVIN reacteur
%    - p_ref1: pression en BAR dans le reformeur primaire
%    - var   : 't' (resp. 'm') pour tonnes/jour (resp. moles/s)
%    - print : mettre a 0 pour ne pas afficher les masses detaillees
%              (ils sont affiches par defaut)
%    - out   : mettre a 1 pour renvoyer les masses detaillees
% 
% out- m_CH4 : masse de methane en tonnes par jour
%    - m_H2O : masse d'eau en tonnes par jour
%    - m_O2  : masse d'oxygene en tonnes par jour
%    - m_N2  : masse de nitrogen en tonnes par jour
%    - m_Ar  : masse d'argon en tonnes par jour
%    - nombre de tubes

if nargin < 5
    print = 1 ;
    out   = 0 ;
end

myAssert((T >= 700 && T <=1200),0, strcat('La temperature fournie', ...
    ' est en dehors de l''intervalle couvert par coefficients de Shomate.'));
% if ~(T >= 700 && T <=1200)
%     error('hellooo');
% end
% assert((T >= 700 && T <=1200),'hello');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Details des flux massiques de l'ensemble du procede 

p_ref1 = p_ref1*1e5 ; % conversion [bar] en [Pa]

if var=='t' 
    m = getMassesDetails(m_nh3,T,p_ref1) ;
else
    m = getMolesDetails(m_nh3,T,p_ref1) ;
end

if print
    fprintf('\nQuantite de NH3 : %d [t]| Temperature REF1 : %d [K]| Pression REF1 : %d [bar]\n',...
    m_nh3,T,p_ref1/1e5);
    printMassesDetails(m,var);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Bilan energetique

T_four = 1300 ; 

moles = solveG(m_nh3,T,p_ref1); % equilibre dans le reformeur primaire
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
    printHovenMasses(m,var);
end

if out 
    masses = m;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Nombre de tubes 

tubes = getTubesNumber(n_ch4,n_h2o,T) ;

if print
    fprintf('\nNombre de tubes : %d \n\n', ceil(double(tubes))) ;
end

end

    
