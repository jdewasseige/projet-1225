function x = purge(T, m_NH3)

%On obtient les différents flux massiques et on les convertit en molaires.
m=main(T, m_NH3);
m_N2_in=m(4);
m_H2_in=m_N2_in/4;
m_Ar_in=m(5);
n_N2_in=m_N2_in/28;
n_H2_in=m_H2_in/2;
n_Ar_in=m_Ar_in/40;
n_in=n_N2_in+n_H2_in+n_Ar_in;
n_NH3_out=m_NH3/17;

%On cherche K
R=8.3145;
H_and_S=getDeltaH_and_S(750);
dH=H_and_S(1);
dS=H_and_S(2);
dH=2*dH.nh3-dH.n2-3*dH.h2;
dS=2*dS.nh3-dS.n2-3*dS.h2;
dG=dH-T*dS;
K= exp(-dG/(R*750));

%On cherche xsi (uniquement pour le circuit "in"!!!) grâce à K
xsi_s=sym('xsi_s');
xsi=solve(((2*xsi_s)^2)*((n_in-2*xsi_s)^2)/(27*(n_N2_in-xsi_s)^4)-K);

%On peut obtenir les deux valeurs suivantes grâce à nos bilans du départ
n_purge=n_in-2*xsi-n_NH3_out;
A_purge=n_Ar_in/n_purge;

%On utilise K pour la réaction totale et on obtient la masse totale dans le
%circuit de recyclage.
n_N2_out_s=sym('n_N2_out_s');
n_N2_out=solve(((((n_NH3_out)^2)*((4*n_N2_out_s+n_Ar_in-A_purge*n_NH3_out)/(1-A_purge))^2)/(27*(n_N2_out_s)^4))-K);
n_out=(4*n_N2_out+n_Ar_in-A_purge*n_NH3_out)/(1-A_purge);
n_rec=n_out-n_NH3_out;
x=n_purge/n_rec; %La fraction recherchée

end


