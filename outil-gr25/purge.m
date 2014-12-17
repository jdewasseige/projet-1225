function x = purge(m_NH3, T, p)

%On obtient les différents flux molaires journaliers..
n_NH3_out_th = m_NH3*10^6/17.0305;
n_N2_in = n_NH3_out_th/2;
n_H2_in = 3*n_N2_in;
n_Ar_in = (1/2652)*m_NH3*10^6;
n_in = n_N2_in+n_H2_in+n_Ar_in;

M = getMolarMasses();

%On cherche K (à température T)
R=8.3145;
H_and_S=getDeltaH_and_S(T);
dH=H_and_S(1);
dS=H_and_S(2);
dH=dH.nh3-dH.n2/2-3*dH.h2/2;
dS=dS.nh3-dS.n2/2-3*dS.h2/2;
dG=dH-T*dS+R*T*log(p); %ATTENTION on utilise la loi des gaz parfaits pour la contribution de la pression (très approximative)
K= exp(-dG/(R*T));

%On cherche xi (uniquement pour le circuit "in"!!!) grâce à K
syms xi_s positive;
xi=solve(((2*xi_s)^2) * ((n_in-2*xi_s)^2) / (27*p^2*(n_N2_in-xi_s)^4) - K , xi_s); %Ce système a plusieurs solutions!
xi=double(xi(1)) %On prend la solution qui a du sens

%On peut obtenir les deux valeurs suivantes grâce à nos bilans du départ
n_NH3_out = 2*xi;
n_purge=n_in-2*xi-n_NH3_out;
A_purge=n_Ar_in/n_purge ;

%On utilise K pour la réaction totale et on obtient la masse totale dans le
%circuit de recyclage.
syms n_N2_out_s positive;
n_N2_out=solve((((n_NH3_out)^2) * ((4*n_N2_out_s+n_NH3_out+n_Ar_in-(A_purge*n_NH3_out)/(1-A_purge))^2) / (27*p^2*(n_N2_out_s)^4))-K, n_N2_out_s);
n_N2_out=double(n_N2_out)
n_out=sqrt(K*(p^2)*27*n_N2_out^4/(n_NH3_out^2));
n_rec=n_out-n_NH3_out;
x=abs(n_purge/n_rec);%La fraction recherchée

m_rec=((n_rec-(A_purge*n_rec))/4)*(M.n2+3*M.h2) + A_purge*n_rec*M.ar;
m_purge=m_rec*x;

end
