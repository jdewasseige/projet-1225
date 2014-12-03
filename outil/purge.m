function out = purge(T, m_NH3, T_reac, p_reac)

%On obtient les différents flux molaires.
n_N2_in   = (1/34)*m_NH3*1000;
n_H2_in   = 3*n_N2_in;
n_Ar_in   = (1/2652)*m_NH3*1000;
n_in      = n_N2_in+n_H2_in+n_Ar_in;
n_NH3_out = m_NH3/17;

%On cherche K (à 750K)
R=8.3145;
H_and_S=getDeltaH_and_S(T_reac);
dH=H_and_S(1);
dS=H_and_S(2);
dH=2*dH.nh3-dH.n2-3*dH.h2;
dS=2*dS.nh3-dS.n2-3*dS.h2;
dG=dH-T*dS+R*T_reac*log(p_reac); %ATTENTION on utilise la loi des gaz parfaits pour la contribution de la pression (très approximative)
K= exp(-dG/(R*T_reac));

%On cherche xsi (uniquement pour le circuit "in"!!!) grâce à K
syms xsi_s;
xsi=solve(((2*xsi_s)^2)*((n_in-2*xsi_s)^2)/(27*(n_N2_in-xsi_s)^4)-K/p_reac, xsi_s); %Ce système a plusieurs solutions!
xsi=double(xsi(3)); %On prend la solution qui a du sens

%On peut obtenir les deux valeurs suivantes grâce à nos bilans du départ
n_purge=n_in-2*xsi-n_NH3_out;
A_purge=n_Ar_in/n_purge;

%On utilise K pour la réaction totale et on obtient la masse totale dans le
%circuit de recyclage.
syms n_N2_out_s;
n_N2_out=solve(((((n_NH3_out)^2)*((4*n_N2_out_s+n_Ar_in-A_purge*n_NH3_out)/(1-A_purge))^2)/(27*(n_N2_out_s)^4))-K/p_reac, n_N2_out_s);
n_N2_out=double(n_N2_out(1));
n_out=(4*n_N2_out+n_Ar_in-A_purge*n_NH3_out)/(1-A_purge);
n_rec=n_out-n_NH3_out;
x=abs(n_purge/n_rec) %La fraction recherchée

m_rec=((n_rec-(A_purge*n_rec))/4)*(28+6)+A_purge*n_rec*40
m_purge=m_rec*x

end


