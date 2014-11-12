function out = getHovenMasses(n_r1,n_r2,dH_r1,dH_r2)
% Cette fonction calcule les masses en tonnes de methane
% et d'oxygene necessaire pour apporter suffisament de chaleur
% dans le reformeur primaire afin que la reaction endothermique
% du craquage du methane puisse se produire.
%
% input  - n_r1  : nombre de moles de la premiere reaction qui va reagir 
%          n_r2  : nombre de moles de la deuxieme reaction qui va reagir 
%          dH_r1 : variation d'enthalpie de la reaction 1
%          dH_r2 : variation d'enthalpie de la reaction 2
% output - out   : masses en TONNES de methane et d'oxygene

T = 1300 ; 
rendement_four = 0.75 ;
M = getMolarMasses();

values = getDeltaH_and_S(T);
dH = values(1);
dS = values(2);

dH.four = dH.co2 + 2*dH.h2o - 2*dH.o2 - dH.ch4 ;

n_ch4_four = -(n_r1*dH_r1 + n_r2*dH_r2)/(dH.four*rendement_four) ;

m_ch4_four = (n_ch4_four * M.ch4)/1e6 ;
m_o2_four  = (2*n_ch4_four * M.o2)/1e6 ;

out = [m_ch4_four, m_o2_four] ;

end

