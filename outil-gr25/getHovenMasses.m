function out = getHovenMasses(n_r1,n_r2,T_ref,T_four)
% Cette fonction calcule les masses en tonnes de methane
% et d'oxygene necessaire pour apporter suffisament de chaleur
% dans le reformeur primaire afin que la reaction endothermique
% du craquage du methane puisse se produire.
%
% input  - n_r1  : nombre de moles de la premiere reaction qui va reagir 
%          n_r2  : nombre de moles de la deuxieme reaction qui va reagir 
%          T_ref : temperature en KELVIN du reformeur primaire
%          T_four: temperature en KELVIN du four
% output - out   : masses en TONNES de methane, d'oxygene et de CO2

rendement_four = 0.75 ;
M = getMolarMasses();

dH_and_dS_ref = getDeltaH_and_S(T_ref) ;
dH_ref = dH_and_dS_ref(1) ;
dH_r1 = dH_ref.co + 3*dH_ref.h2 - dH_ref.h2o - dH_ref.ch4 ;
dH_r2 = dH_ref.co2 + dH_ref.h2 - dH_ref.h2o - dH_ref.co ;

dH_and_dS_four = getDeltaH_and_S(T_four) ;
dH_four = dH_and_dS_four(1) ;
dH_r_four = dH_four.co2 + 2*dH_four.h2o - 2*dH_four.o2 - dH_four.ch4 ;

n_ch4_four = -(n_r1*dH_r1 + n_r2*dH_r2)/(dH_r_four*rendement_four) ;

m_ch4_four = (n_ch4_four * M.ch4)/1e6 ;
m_o2_four  = (2*n_ch4_four * M.o2)/1e6 ;
m_co2_four = (n_ch4_four * M.co2)/1e6 ; 
m_h2o_four = (2*n_ch4_four * M.h2o)/1e6 ;


out = [m_ch4_four, m_o2_four, m_co2_four, m_h2o_four] ;

end

