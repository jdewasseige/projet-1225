function m = getMassesDetails(m_nh3,T,p_tot)
%GETMASSESDETAILS - Cette fonction renvoit un structure array
%                   contenant les valeurs des masses du procede.
M = getMolarMasses ;

moles = solveG(m_nh3,T,p_tot) ;
n_ch4 = moles(1) ;
n_h2o = moles(2) ;
ksi1  = moles(3) ;
ksi2  = moles(4) ;

m.ch4_in = n_ch4*M.ch4/1e6 ;
m.h2o_in = n_h2o*M.h2o/1e6 ;

m.o2_ref2 = (7*m_nh3/884)*M.o2 ;
m.n2_ref2 = (1*m_nh3/34)*M.n2 ;
m.ar_ref2 = (1*m_nh3/2652)*M.ar ;

m.ch4_ref2 = (n_ch4-ksi1)*M.ch4/1e6 ;
m.h2o_ref2 = (n_h2o-ksi1-ksi2)*M.h2o/1e6 ;
m.co_ref2  = (ksi1-ksi2)*M.co/1e6 ;
m.co2_ref2 = ksi2*M.co2/1e6 ;
m.h2_ref2  = (3*ksi1+ksi2)*M.h2/1e6 ;

m.co_wgs  = (7*m_nh3/442)*M.co + m.co_ref2 ;
m.co2_wgs = m.co2_ref2 ;
m.n2_wgs  = m.n2_ref2 ;
m.h2_wgs  = (7*m_nh3/221)*M.h2 + m.h2_ref2;
m.ar_wgs  = m.ar_ref2 ;
m.h2o_wgs = (n_h2o-ksi1-ksi2)*M.h2o/1e6 ;

m.co2_sep = m.co_wgs*M.co2/M.co + m.co2_wgs ;
m.n2_sep  = m.n2_wgs ;
m.h2_sep  = (3*m_nh3/34)*M.h2 ;
m.ar_sep  = m.ar_wgs ;
m.h2o_sep = m.h2o_wgs - m.co_wgs*M.h2o/M.co ; 

m.n2_syn = m.n2_sep ;
m.h2_syn = m.h2_sep ;
m.ar_syn = m.ar_sep ;
m.nh3    = m_nh3    ;

end
