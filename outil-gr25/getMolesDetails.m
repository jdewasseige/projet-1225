function n = getMolesDetails(m_nh3,T,p_tot)
%GETMOLESDETAILS - Cette fonction a la meme utilite que la fonction
%                  getMassesDetails mais renvoit des moles/s 
%                  plutot que de tonnes/jour.
M = getMolarMasses ;

ton_to_gram   = 1e6;
day_to_second = 24*60*60;
tonDay_to_gramSecond = ton_to_gram/day_to_second;

moles = solveG(m_nh3,T,p_tot) ;
moles = moles/day_to_second;
n_ch4 = moles(1) ;
n_h2o = moles(2) ;
ksi1  = moles(3) ;
ksi2  = moles(4) ;

m_nh3 = m_nh3*tonDay_to_gramSecond;

n.ch4_in = n_ch4;
n.h2o_in = n_h2o;

n.o2_ref2 = (7*m_nh3/884);
n.n2_ref2 = (1*m_nh3/34);
n.ar_ref2 = (1*m_nh3/2652);

n.ch4_ref2 = (n_ch4-ksi1);
n.h2o_ref2 = (n_h2o-ksi1-ksi2);
n.co_ref2  = (ksi1-ksi2);
n.co2_ref2 = ksi2;
n.h2_ref2  = (3*ksi1+ksi2);

n.co_wgs  = (7*m_nh3/442)+ n.co_ref2 ;
n.co2_wgs = n.co2_ref2 ;
n.n2_wgs  = n.n2_ref2 ;
n.h2_wgs  = (7*m_nh3/221)+ n.h2_ref2;
n.ar_wgs  = n.ar_ref2 ;
n.h2o_wgs = n_h2o-ksi1-ksi2;

n.co2_sep = n.co_wgs + n.co2_wgs ;
n.n2_sep  = n.n2_wgs ;
n.h2_sep  = 3*m_nh3/34;
n.ar_sep  = n.ar_wgs ;
n.h2o_sep = n.h2o_wgs - n.co_wgs ; 

n.n2_syn = n.n2_sep ;
n.h2_syn = n.h2_sep ;
n.ar_syn = n.ar_sep ;
n.nh3    = m_nh3/M.nh3;

end
