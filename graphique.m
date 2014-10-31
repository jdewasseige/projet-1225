function f = graphique();

% on considere H2SO4, un acide fort
X = [1e-5,1e-3,1e-2,1e-1,1e-0];
Y = -log10(X);
x = linspace(0,1,1000); % les concentrations molaires de H2SO4
y = -log10(x); % le pH en fonction des concentrations de H2SO4

figure();
plot(x,y,'b',X,Y,'b.','Markersize',15);

title('Évolution du pH en fonction de la concentration molaire [mol/l] de H_{2}SO_{4}');
xlabel('Concentration molaire de H_{2}SO_{4} [mol/l]');
ylabel('pH [/]');

disp('Nous observons 5 points sur le graphique de la figure 1, correspondant aux résultats suivants :');
disp('Le pH est donné par : pH = -log[H2SO4]');
disp('Lorsque [H2SO4] = 10^-5 mol/l, le pH vaut 5.');
disp('Lorsque [H2SO4] = 10^-3 mol/l, le pH vaut 3.');
disp('Lorsque [H2SO4] = 10^-2 mol/l, le pH vaut 2.');
disp('Lorsque [H2SO4] = 0.1 mol/l, le pH vaut 1.');
disp('Lorsque [H2SO4] = 1 mol/l, le pH vaut 0.');

% on considere HSO4-, un acide faible
V = [(1e-5)^2/0.0126,(1e-3)^2/0.0126,(1e-2)^2/0.0126,(1e-1)^2/0.0126,(1e-0)^2/0.0126];
W = -log10(sqrt(0.0126*V));
v = linspace(0,(1e-0)^2/0.0126,1000);
w = -log10(sqrt(0.0126*v));

figure();
plot(v,w,'b',V,W,'b.','Markersize',15);

title('Évolution du pH en fonction de la concentration molaire [mol/l] de HSO^{-}_{4}');
xlabel('Concentration molaire de HSO^{-}_{4} [mol/l]');
ylabel('pH [/]');

disp('Nous observons 5 points sur le graphique de la figure 2 correspondant aux résultats suivants :');
disp('Le pH est donné par : pH = -log(sqrt(0.0126*[HSO4-])');
disp('Lorsque [HSO4-] = 7.9365e-09 mol/l, le pH vaut 5.');
disp('Lorsque [HSO4-] = 7.9365e-05 mol/l, le pH vaut 3.');
disp('Lorsque [HSO4-] = 0.0079 mol/l, le pH vaut 2.');
disp('Lorsque [HSO4-] = 0.7937 mol/l, le pH vaut 1.');
disp('Lorsque [HSO4-] = 79.3651 mol/l, le pH vaut 0.');

end