function x = purge(T, m_NH3)
m=main(T, m_NH3);
m_N2=m(4);
m_H2=m_N2/4;
m_Ar=m(5);
m_purge=m_N2+m_H2+m_Ar-m_NH3;
a_recycl=m_Ar/m_purge;

R=8.3145;
H_and_S=getDeltaH_and_S(750);
dH=H_and_S(1);
dS=H_and_S(2);
dH=2*dH.nh3-dH.n2-3*dH.h2;
dS=2*dS.nh3-dS.n2-3*dS.h2;
dG=dH-T*dS;
K= exp(-dG/(R*750));

n_NH3=m_NH3*10^6/17;
%Valeurs post réaction
n_N2_pr=Math.pow((4*(n_NH3)^2)/K, 1.0/4);
n_H2_pr=n_N2_pr*3;
m_N2_pr=n_N2_pr*28;
m_H2_pr=m_H2_pr*2;
m_Ar_pr=a_recycl*(-m_N2-m_H2)/(a_recycl-1);
m_recycl=m_N2_pr+m_H2_pr+m_Ar_pr;
x=m_Ar/(a_recycl*m_recycl);
end


