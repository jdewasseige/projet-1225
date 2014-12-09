function analyseParametrique

n = 10; 

T = linspace(900,1100,n);

in_ch4_proc  = zeros(1,n);
in_ch4_four  = zeros(1,n);
in_o2_four = zeros(1,n);

in_h2o  = zeros(1,n);
in_air  = zeros(1,n);
out_nh3 = zeros(1,n);
out_ar  = zeros(1,n);

out_h2o_proc = zeros(1,n);
out_h2o_four = zeros(1,n);

out_co2_proc = zeros(1,n);
out_co2_four = zeros(1,n);

for i=1:n
    fprintf('T = %.0f K \n',T(i));
    m = main(10,T(i),0,1);
    
    in_ch4_proc(i)  = m.ch4_in ;
    in_ch4_four(i)  = m.ch4_four ;
    
    in_o2_four(i) = m.o2_four;

    in_h2o(i)  = m.h2o_in ;
    in_air(i)  = m.o2_ref2 + m.n2_ref2 + m.ar_ref2;
    out_nh3(i) = m.nh3;
    out_ar(i)  = m.ar_syn;
    
    out_h2o_proc(i) = m.h2o_sep;
    out_h2o_four(i)  = m.h2o_four ;
    out_co2_proc(i) = m.co2_sep ;
    out_co2_four(i)  = m.co2_four;

end 

subplot(2,1,1);
plot(T,in_ch4_proc,T,in_h2o,T,in_air,T,out_nh3,T,out_ar,T,out_h2o_proc,T,out_co2_proc);

hold on;
title('Analyse parametrique pour 10 tonnes d''ammoniac')
ylabel('Masses (tonnes)')
xlabel('Temperature (K)')
legend('in ch4','in h2o','in air','out nh3','out ar','out h2o','out co2');
hold off;

subplot(2,1,2);
plot(T,in_ch4_four,T,in_o2_four,T,out_h2o_four,T,out_co2_four);

hold on;
title('Analyse parametrique du four pour 10 tonnes d''ammoniac')
ylabel('Masses (tonnes)')
xlabel('Temperature (K)')
legend('in ch4','in o2','out h2o','out co2');
hold off;


end
