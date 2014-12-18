function environnement()
%ENVIRONNEMENT - Outil permettant l'analyse des donnees 
%                environnementales pour la tache 3 du projet

n = 6;

co2 = zeros(1,n);
h2o_in = zeros(1,n);
h2o_out = zeros(1,n);
ch4 = zeros(1,n);

p_tot = 26;
m_nh3 = 100;
T_four = 1300; 

T = linspace(700,1100,n);

fprintf('\nRejet des gaz a effet de serre en tonnes/jour \n');

for i = 1:n
    fprintf('T = %d [K] \t',T(i));
    
    m = main(m_nh3,T(i),p_tot,'t',0,1);

    h2o_in(i) = m.h2o_in;
    h2o_out(i) = (m.h2o_four + m.h2o_sep);
    co2(i) =  (m.co2_sep + m.co2_four) ;
    ch4(i) = m.ch4_four;

    fprintf('CO2 : %.2f \t', co2(i)) ;
    fprintf('H2O : %.2f \n', h2o_out(i)) ;

end

figure('name','Analyse Environnementale','position',[20 500 630 500])

subplot(2,2,1); 
plot(T, co2)
hold on;
title('CO2/Temp')
ylabel('CO2 rejection')
xlabel('Temperature')
hold off;

subplot(2,2,3);
plot(T,h2o_out,'b',T,h2o_in,'g');
hold on;
title('H2O/Temp')
ylabel('H2O rejection')
xlabel('Temperature')
hold off;

subplot(2,2,2);
plot(T, ch4);
hold on;
title('CH4 utilise dans le four')
ylabel('CH4')
xlabel('Temperature')
hold off;

end 