function out = outil(T, m_NH3)
%Outil de gestion du plant de formation d'ammoniac a partir de methane.

%in - T     = temperature reacteur
%   - m_NH3 = masse en tonnes d'ammoniac

%out- m_CH4 = masse en tonnes de methane
%   - m_H2O = masse en tonnes d'eau
%   - m_O2  = masse en tonnes d'oxygene
%   - m_N2  = masse en tonnes de nitrogen
%   - m_Ar  = masse en tonnes d'argon

%capacites calorifiques
cp_h2o_l = 75.349
cp_h2o_g = [30.13 10.46e-3 0]
cp_n2    = [27.62 4.19e-3 0]
cp_h2    = [29.30 -0.84e-3 2.09e-6]
cp_nh3   = [31.81 15.48e-3 5.86e-6]
cp_co    = [27.62 5.02e-3 0]
cp_o2    = [25.73 12.97e-3 -3.77e-6]
cp_co2   = [32.22 22.18e-3 -3.35e-6]
cp_ch4   = [14.23 75.3e-3 -18e-6]
%enthalpies et entropies standards
dH_st_h2o = -241.826e3
dS_st_h2o = 188.834
dH_st_n2  = 0
dS_st_n2  = 191.609
dH_st_h2  = 0
dS_st_h2  = 130.68
dH_st_nh3 = -45.898e3
dS_st_nh3 = 192.774
dH_st_co  = -110.527e3
dS_st_co  = 197.653
dH_st_co2 = -393.522e3
dS_st_co2 = 213.795
dH_st_ch4 = -74.873e3
dS_st_ch4 = 186.251
dH_st_o2  = 0
dS_st_o2  = 205.147

%reformage primaire
dH_co = dH_st_co + integral(@(t) cp_co*[t.^0;t.^1;t.^2], 298, T)
dS_co = dS_st_co + integral(@(t) cp_co*[t.^-1; t.^0 ; t.^1], 298, T);

dH_h2 = dH_st_h2 + integral(@(t) cp_h2*[t.^0;t.^1;t.^2], 298, T)
dS_h2 = dS_st_h2 + integral(@(t) cp_h2*[t.^-1 ; t.^0 ; t.^1], 298, T);

dH_h2o = dH_st_h2o + integral(@(t) cp_h2o_g*[t.^0;t.^1;t.^2], 298, T)
dS_h2o = dS_st_h2o + integral(@(t) cp_h2o_g*[t.^-1 ; t.^0 ; t.^1], 298, T);

dH_ch4 = dH_st_ch4 + integral(@(t) cp_ch4*[t.^0;t.^1;t.^2], 298, T)
dS_ch4 = dS_st_ch4 + integral(@(t) cp_ch4*[t.^-1 ; t.^0 ; t.^1], 298, T);

dH_r1 = dH_co + 3*dH_h2 - dH_h2o - dH_ch4;
dS_r1 = dS_co + 3*dS_h2 - dS_h2o - dS_ch4;
dG_r1 = dH_r1 - T*dS_r1

%water gas shift - reformage primaire
dH_co2 = dH_st_co2 + integral(@(t) cp_co2*[t.^0;t.^1;t.^2], 298, T)
dS_co2 = dS_st_co2 + integral(@(t) cp_co2*[t.^-1; t.^0 ; t.^1], 298, T);

dH_h2 = dH_st_h2 + integral(@(t) cp_h2*[t.^0;t.^1;t.^2], 298, T)
dS_h2 = dS_st_h2 + integral(@(t) cp_h2*[t.^-1 ; t.^0 ; t.^1], 298, T);

dH_h2o = dH_st_h2o + integral(@(t) cp_h2o_g*[t.^0;t.^1;t.^2], 298, T)
dS_h2o = dS_st_h2o + integral(@(t) cp_h2o_g*[t.^-1 ; t.^0 ; t.^1], 298, T);

dH_co = dH_st_co + integral(@(t) cp_co*[t.^0;t.^1;t.^2], 298, T)
dS_co = dS_st_co + integral(@(t) cp_co*[t.^-1 ; t.^0 ; t.^1], 298, T);

dH_r2 = dH_co2 + dH_h2 - dH_h2o - dH_co;
dS_r2 = dS_co2 + dS_h2 - dS_h2o - dS_co;
dG_r2 = dH_r2 - T*dS_r2


%constantes d'eq K
R = 8,3144621
p_tot = 28e5
p_st = 1e5

K_r1 = exp(-dG_r1/(R*T))
K_r2 = exp(-dG_r2/(R*T))

syms eps1 eps2 n_CH4 n_H2O
%equilibre des pressions reaction 1 reformage primaire
eq1= K_r1 == (p_tot^2 *(eps1 - eps2)*(3*eps1 + eps2).^3)...
              /(p_st^2 *(n_CH4 + n_H2O + 2*eps1)^2 *(n_CH4 - eps1)*(n_H2O - eps1 - eps2))
%equilibre des pressions reaction 2 (WGS) reformage primaire
eq2= K_r2 == (eps2*(3*eps1 + eps2))/((eps1 - eps2)*(n_H2O - eps1 - eps2))
%donnee a l'entree du reformage secondaire
eq3= n_CH4 - eps1 == (7/442)*m_NH3
%donnee a la sortie du reformage secondaire
eq4= 3*eps1 + eps2 == (7/221)*m_NH3

%resoudre le systeme de 4 equations a 4 inconnues 
[n_CH4,n_H2O,eps1,eps2] = solve([eq1 eq2 eq3 eq4])


%out- m_CH4 = masse en tonnes de methane
%   - m_H2O = masse en tonnes d'eau
%   - m_O2  = masse en tonnes d'oxygene
%   - m_N2  = masse en tonnes de nitrogen
%   - m_Ar  = masse en tonnes d'argon

m_CH4= 16*n_CH4
m_H2O= 18*n_H2O
m_O2 = 32*((7/884)* m_NH3) 
m_N2 = 28*((1/34)* m_NH3)
m_Ar = 40*((1/2652)* m_NH3)

out = [m_CH4 m_H2O m_O2 m_N2 m_Ar]

end