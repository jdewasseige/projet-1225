function dataElectrolyse()

% donnes mesurees en laboratoire
data_0_2 = load('data_0_2.txt');
data_0_4 = load('data_0_4.txt');
data_0_5 = load('data_0_5.txt');
data_0_6 = load('data_0_6.txt');
data_0_8 = load('data_0_8.txt');
data_1_0 = load('data_1_0.txt');
data_2_0 = load('data_2_0.txt');

plot(data_0_2(:,1),data_0_2(:,2),'y');
hold on;
plot(data_0_4(:,1),data_0_4(:,2),'m');
plot(data_0_5(:,1),data_0_5(:,2),'c');
plot(data_0_6(:,1),data_0_6(:,2),'r');
plot(data_0_8(:,1),data_0_8(:,2),'g');
plot(data_1_0(:,1),data_1_0(:,2),'b');
plot(data_2_0(:,1),data_2_0(:,2),'k');
xlabel('Temps [s]');
ylabel('Volume de H2 [ml]');
legend('0.2 A', '0.4 A', '0.5 A', '0.6 A', '0.8 A', '1.0 A', '2.0 A');
hold off;

end