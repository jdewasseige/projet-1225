function [x, eff] = purge(m_NH3, T, p)

%On obtient les diff�rents flux molaires journaliers..
n_NH3_out_th = m_NH3*10^6/17.0305;
n_N2_in = n_NH3_out_th/2;
n_H2_in = 3*n_N2_in;
n_Ar_in = (1/2652)*m_NH3*10^6;
n_in = n_N2_in+n_H2_in+n_Ar_in;

M = getMolarMasses();

%On cherche K (� temp�rature T)
R=8.3145;
H_and_S=getDeltaH_and_S(T);
dH=H_and_S(1);
dS=H_and_S(2);
dH=dH.nh3-dH.n2/2-3*dH.h2/2;
dS=dS.nh3-dS.n2/2-3*dS.h2/2;
dG=dH-T*dS+R*T*log(p); %ATTENTION on utilise la loi des gaz parfaits pour la contribution de la pression (tr�s approximative)
K= exp(-dG/(R*T));

%On cherche xi (uniquement pour le circuit "in"!!!) gr�ce � K

syms xi_s;

xi_in=solve(((2*xi_s)^2) * ((n_in-2*xi_s)^2) / (27*p^2*(n_N2_in-xi_s)^4) - K , xi_s); %Ce syst�me a plusieurs solutions!
xi_in=double(xi_in(2)); %On prend la solution qui a du sens


%On peut obtenir les deux valeurs suivantes gr�ce � nos bilans du d�part

n_purge=n_in-4*xi_in
xi_rec=(n_in-n_purge-4*xi_in)/4
n_NH3_out=2*xi_in+2*xi_rec

A_purge=n_Ar_in/n_purge 

%On utilise K pour la r�action totale et on obtient la masse totale dans le
%circuit de recyclage.

syms n_N2_out_rec_s;
n_N2_out_rec=solve((((2*xi_rec)^2) * ((4*n_N2_out_rec_s/(1-A_purge)-2*xi_rec)^2) / (27*p^2*(n_N2_out_rec_s-xi_rec)^4))-K, n_N2_out_rec_s)
n_N2_out=n_N2_out_rec(1)+n_N2_in-xi_in;
n_rec=4*n_N2_out_rec/(1-A_purge);

x=abs(n_purge/n_rec);%La fraction recherch�e

eff=n_NH3_out_th/n_NH3_out;

end
