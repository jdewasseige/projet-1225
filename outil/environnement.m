function environnement()
% Outil permettant l'analyse des données environnementales pour la tâche 3
% du projet

x = zeros(1,11); 
y = zeros(1,11);


t = 700;

for i = 1:11
    
    if t == 1200 
        t = 1200 - 1;
    end
    
    result = main(t, 1500);

    x(i) = result(1)/1500;
    y(i) = t;

    fprintf('Rejet de C02 (FOUR) en tonnes par jour : %.2f pour : %.2f degrés K \n', result(1), y(i)) ;

    t = t + 50;
end

plot(y, x)

hold on;

title('CO2/Temp')
ylabel('CO2 rejection/ NH3 production')
xlabel('Temperature')

hold off;

end 