function environnement()
% Outil permettant l'analyse des données environnementales pour la tâche 3
% du projet

x = zeros(1,9); 
y = zeros(1,9);
h2o = zeros(1,9);


p_tot = 26e5 ;
m_nh3 = 1500;
T_four = 1300; 


T = 700;

for i = 1:9
    
    moles = solveG(m_nh3,T,p_tot) ;
    ksi1  = moles(3);
    ksi2  = moles(4);
    
    m = getMassesDetails(m_nh3,T,p_tot) ;
  
    result = getHovenMasses(ksi1,ksi2,T,T_four);

    h2o(i) = (result(4) + m.h2o_sep)/1500;
    y(i) =  (m.co2_sep + result(3))/1500 ;
    x(i) = T;

    fprintf('Rejet de C02 en tonnes par jour : %.2f pour : %.2f degrés K \n', m.co2_sep + result(3), x(i)) ;
    fprintf('Rejet de H2O en tonnes par jour : %.2f pour : %.2f degrés K \n', result(4) + m.h2o_sep, x(i)) ;

    T = T + 50;
end

figure();

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

end 