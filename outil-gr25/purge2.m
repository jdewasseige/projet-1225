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

syms n_rec_s n_purge_s xi_s x_N2_s;

<<<<<<< HEAD
eq1=n_purge_s == n_in-4*xi_s;
eq2= n_rec_s-n_purge_s == n_in*n_rec_s/n_purge_s;
eq3= n_in-n_purge_s+(n_in+n_rec_s-n_purge_s)*(1-n_purge_s/n_rec_s) == 0;
eq4= ((2*xi_s)^2)*(n_in+n_rec_s-n_purge_s-2*xi_s)^2/(27*p^2*(n_N2_in+x_N2_s*(n_rec_s-n_purge_s)-xi_s)^4) == K;

[n_rec n_purge xi x_N2_out] = solve(eq1, eq2, eq3, eq4, n_rec_s, n_purge_s, xi_s, x_N2_s);
=======
eq1 = n_purge_s==n_in-4*xi_s;
eq2 = n_rec_s-n_purge_s==n_in*n_rec_s/n_purge_s;
eq3 = (x_N2_s*n_purge_s*(n_rec_s-n_purge_s)/n_rec_s) == (n_N2_in-xi_s)*(1-n_purge_s/n_rec_s);
eq4 = ((2*xi_s)^2)*(n_in+n_rec_s-n_purge_s-2*xi_s)^2/(27*p^2*(n_N2_in+x_N2_s*(n_rec_s-n_purge_s)-xi_s)^4) == K;
>>>>>>> origin/master

[n_rec n_purge xi x_N2_out] = solve(eq1, eq2, eq3, eq4, n_rec_s, n_purge_s, xi_s, x_N2_s)

x=n_purge/n_rec;%La fraction recherch�e

eff=2*xi/n_NH3_out_th;

end
