function environnement()
% Outil permettant l'analyse des données environnementales pour la tâche 3
% du projet

n = 6;

x = zeros(1,n); 
y = zeros(1,n);
h2o = zeros(1,n);

p_tot = 26e5 ;
m_nh3 = 10;
T_four = 1300; 

T = linspace(700,1100,n);

fprintf('\nRejet des gazs a effet de serre en tonnes/jour \n');

for i = 1:n
    fprintf('T = %d [K] \t',T(i));
    
    moles = solveG(m_nh3,T(i),p_tot) ;
    ksi1  = moles(3);
    ksi2  = moles(4);
    
    m = getMassesDetails(m_nh3,T(i),p_tot) ;
  
    result = getHovenMasses(ksi1,ksi2,T(i),T_four);

    h2o(i) = (result(4) + m.h2o_sep);
    y(i) =  (m.co2_sep + result(3)) ;
    x(i) = T(i);

    fprintf('CO2 : %.2f \t', m.co2_sep + result(3)) ;
    fprintf('H2O : %.2f \n', result(4) + m.h2o_sep) ;

end

figure('name','Analyse Environnementale','position',[20 500 630 500])

subplot(2,1,1); 
plot(x, y)
hold on;
title('CO2/Temp')
ylabel('CO2 rejection/ NH3 production')
xlabel('Temperature')
hold off;

subplot(2,1,2);
plot(x, h2o);
hold on;
title('H2O/Temp')
ylabel('H2O rejection/ NH3 production')
xlabel('Temperature')
hold off;

subplot(2,1,2);
plot(x, h2o);
hold on;
title('CH4/Temp')
ylabel('CH4 rejection/ NH3 production')
xlabel('Temperature')
hold off;

end 