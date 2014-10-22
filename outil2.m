function out = outil2(T, m_NH3)
%Outil de gestion du plant de formation d'ammoniac a partir de methane.
%
%in - T     = temperature reacteur
%   - m_NH3 = masse en tonnes d'ammoniac
%
%out- m_CH4 = masse en tonnes de methane
%   - m_H2O = masse en tonnes d'eau
%   - m_O2  = masse en tonnes d'oxygene
%   - m_N2  = masse en tonnes de nitrogen
%   - m_Ar  = masse en tonnes d'argon
if T < 1000
    cp_h2 = [33.066178 -11.363417 11.432816 -2.772874 ...
        -0.158558 -9.980797 172.707974 0] ;
else
    cp_h2 = [18.563083 12.257357 -2.859786 0.268238 ...
        1.977990 -1.147438 156.288133 0] ;
end
%capacites calorifiques
cp_h2o = [30.09200 6.832514 6.793435 -2.534480 ...
    0.082139 -250.8810 223.3967 -241.8264] ;
cp_n2  = [19.50583 19.88705 -8.598535 1.369784 ...
    0.527601 -4.935202 212.3900 0] ;
cp_nh3 = [19.99563 49.77119 -15.37599	1.921168 ...
    0.189174 -53.30667 203.8591 -45.89806] ;
cp_co  = [25.56759 6.096130 4.054656 -2.671301 ...
    0.131021 -118.0089 227.3665 -110.5271] ;
cp_o2  = [30.03235 8.772972 -3.988133 0.788313 ...
    -0.741599 -11.32468 236.1663 0] ;
cp_co2 = [24.99735 55.18696 -33.69137 7.948387 ...
    -0.136638 -403.6075 228.2431 -393.5224] ;
cp_ch4 = [-0.703029 108.4773 -42.52157 5.862788 ...
    0.678565 -76.84376 158.7163 -74.87310] ;

t = T/1000
%reformage primaire + water gas shift 
calcH = [t t^2/2 t^3/3 t^4/4 -1/t 1 0 0]
calcS = [log(t) t t^2/2 t^3/3 -1/(2*t^2) 0 1 0]

dH_co = cp_co*calcH' * 1000 ; % passage de kJ a J
dS_co = cp_co*calcS' ;
dH_h2 = cp_h2*calcH' * 1000 ;
dS_h2 = cp_h2*calcS' ;
dH_ch4 = cp_ch4*calcH' * 1000  ;
dS_ch4= cp_ch4*calcS' ;
dH_co2= cp_co2*calcH' * 1000  ;
dS_co2 = cp_co2*calcS' ;
dH_h2o = cp_h2o*calcH' * 1000  ;
dS_h2o = cp_h2o*calcS' ;

%reaction1
dH_r1 = dH_co + 3*dH_h2 - dH_h2o - dH_ch4;
dS_r1 = dS_co + 3*dS_h2 - dS_h2o - dS_ch4;
dG_r1 = dH_r1 - T*dS_r1
%reaction2
dH_r2 = dH_co2 + dH_h2 - dH_h2o - dH_co;
dS_r2 = dS_co2 + dS_h2 - dS_h2o - dS_co;
dG_r2 = dH_r2 - T*dS_r2

%constantes d'eq K
R = 8,3144621
p_tot = 28e5
p_st = 1e5

K_r1 = exp(-dG_r1/(R*T))
K_r2 = exp(-dG_r2/(R*T))

syms ksi1 ksi2 n_CH4 n_H2O positive
%equilibre des pressions reaction 1 reformage primaire
eq1= K_r1 == (p_tot^2 *(ksi1 - ksi2)*(3*ksi1 + ksi2)^3)...
    /(p_st^2 *(n_CH4 + n_H2O + 2*ksi1)^2 *(n_CH4 - ksi1)*(n_H2O - ksi1 - ksi2))
%equilibre des pressions reaction 2 (WGS) reformage primaire
eq2= K_r2 == (ksi2*(3*ksi1 + ksi2))/((ksi1 - ksi2)*(n_H2O - ksi1 - ksi2))
%donnee a l'entree du reformage secondaire
eq3= n_CH4 - ksi1 == (7/442)*m_NH3
%donnee a la sortie du reformage secondaire
eq4= 3*ksi1 + ksi2 == (9/221)*m_NH3

%resoudre le systeme de 4 equations a 4 inconnues 
[n_CH4,n_H2O,ksi1,ksi2] = solve(eq1, eq2, eq3, eq4, n_CH4, n_H2O, ksi1, ksi2)


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

