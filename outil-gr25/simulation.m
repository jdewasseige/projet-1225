function simulation(m_NH3_th,T,p,x)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Ce programme realise une simulation de la deniere etape de notre
% installation. On y utilise la loi des gaz parfaits et on estime
% l'avancement de la reaction pour trouver les flux a l'equilibre.
% Prend comme parametres: - m_NH3_th la masse de NH3 [tonnes/jour] prevue
%                         - T la temperature dans le reacteur
%                         - p la pression dans le reacteur
%                         - x la faction du recyclage a purger
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

n_NH3_th = m_NH3_th*10^6/17.0305;
n_N2_in = n_NH3_th/2;
n_H2_in = 3*n_N2_in;
n_Ar_in = (1/2652)*m_NH3_th*10^6;
n_in = n_N2_in+n_H2_in+n_Ar_in;

%On cherche K (a temperature T)
R=8.3145;
H_and_S=getDeltaH_and_S(T);
dH=H_and_S(1);
dS=H_and_S(2);
dH=dH.nh3-dH.n2/2-3*dH.h2/2;
dS=dS.nh3-dS.n2/2-3*dS.h2/2;
dG=dH-T*dS+R*T*log(p); %ATTENTION on utilise la loi des gaz parfaits pour la contribution de la pression (tres approximative)
K= exp(-dG/(R*T));

%Etat initial: rien ne vient du circuit de recyclage
n_in_and_rec=n_in;
n_N2_in_and_rec=n_N2_in;
n_Ar_in_and_rec=n_Ar_in;
n_NH3=0;
n_rec=0;
iter=0;

itermax=50;

tol=1;
if(x>=0.1)
tol=1/10;%Pour une grosse purge, la convergence est plus rapide et imprecise
end

if(x>=0.5)
tol=1/100;
end

bn_Ar_in_and_rec=tol+1;

syms xi_s;

fprintf('\n Demarrage de la simulation - maximum de %d iterations et tolerance de %d mol/s \n \n', itermax, tol);

%On regarde la variation de la quantité d'Ar et sort de la boucle quand
%elle est stable.
while (iter<=itermax && abs(bn_Ar_in_and_rec-n_Ar_in_and_rec)>tol*(60*60*24) )
fprintf('Itération %d \n',iter);
bn_Ar_in_and_rec = n_Ar_in_and_rec;%bn_Ar_in_and_rec est le nombre de moles d'Ar trouve a l'iteration precedente

%On cherche xi grâce à l'expression de K
xi=solve(((2*xi_s)^2) * ((n_in_and_rec-2*xi_s)^2) / (27*p^2*(n_N2_in_and_rec-xi_s)^4) - K , xi_s); %Ce systeme a plusieurs solutions!
xi=double(xi(2)); %On prend la solution qui a du sens

n_NH3=2*xi;
n_N2_in_and_rec=n_N2_in+(n_N2_in_and_rec-xi)*(1-x);
n_Ar_in_and_rec=n_Ar_in+n_Ar_in_and_rec*(1-x);
n_rec=(n_in_and_rec-4*xi)*(1-x);
n_in_and_rec=n_in+n_rec;

iter=iter+1;
end

if(iter==itermax)
fprintf('\n La simulation ne converge pas... Merci de choisir une fraction plus grande de purge \n') ;
fprintf('Arret effectué avec les flux suivants: \n \n') ;
fprintf(' Le flux sortant de NH3 : %f mol/s \n', n_NH3/(60*60*24));
fprintf(' Le flux d Ar dans le reacteur : %f mol/sec \n', n_Ar_in_and_rec/(60*60*24))
fprintf(' Le flux total dans le recyclage : %f mol/sec \n', n_in_and_rec/(60*60*24));
fprintf(' Le flux total dans la purge : %f mol/sec \n \n', n_in_and_rec*x/(60*60*24));


else
fprintf('\n La simulation converge! \n \n');
if(T>800)
fprintf('Attention! Le modele donne des resultats errones a une telle temperature (> 800 K)! \n \n');
end
fprintf(' A l equilibre, le flux sortant de NH3 est de %f mol/s \n', n_NH3/(60*60*24));
fac_err=n_NH3/n_NH3_th;
fprintf('Cela represente une difference de facteur %f compare a la prediction pour une reaction complete et une installation parfaite \n \n', fac_err);
fprintf(' Le flux d Ar dans le reacteur est de %f mol/sec \n', n_Ar_in_and_rec/(60*60*24))
fprintf(' Le flux total dans le recyclage est de %f mol/sec \n', n_in_and_rec/(60*60*24));
fprintf(' Le flux total dans la purge est de %f mol/sec \n \n', n_in_and_rec*x/(60*60*24));

end

end
