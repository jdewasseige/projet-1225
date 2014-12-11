function printMassesDetails(m)

fprintf('\n \t DETAILS (en tonnes par jour) \t \n');

fprintf('Reformer 1 \n');
fprintf('IN  - ch4 : %.2f \n', m.ch4_in) ;
fprintf('IN  - h2o : %.2f \n\n', m.h2o_in) ;

fprintf('Reformer 2 \n');
fprintf('(In) - ch4 : %.2f \n', m.ch4_ref2) ;
fprintf('(In) - h2o : %.2f \n', m.h2o_ref2) ;
fprintf('(In) - co  : %.2f \n', m.co_ref2) ;
fprintf('(In) - co2 : %.2f \n', m.co2_ref2) ;
fprintf('(In) - h2  : %.2f \n', m.h2_ref2) ;
fprintf(' IN  - o2  : %.2f \n', m.o2_ref2) ;
fprintf(' IN  - n2  : %.2f \n', m.n2_ref2) ;
fprintf(' IN  - ar  : %.2f \n\n', m.ar_ref2) ;

fprintf('WGS \n');
fprintf('(In) - co  : %.2f \n', m.co_wgs) ;
fprintf('(In) - co2 : %.2f \n', m.co2_wgs) ;
fprintf('(In) - n2  : %.2f \n', m.n2_wgs) ;
fprintf('(In) - h2  : %.2f \n', m.h2_wgs) ;
fprintf('(In) - ar  : %.2f \n', m.ar_wgs) ;
fprintf('(In) - h2o : %.2f \n\n', m.h2o_wgs) ;

fprintf('Separation \n');
fprintf('OUT  - co2 : %.2f \n', m.co2_sep) ;
fprintf('(In) - n2  : %.2f \n', m.n2_sep) ;
fprintf('(In) - h2  : %.2f \n', m.h2_sep) ;
fprintf('(In) - ar  : %.2f \n', m.ar_sep) ;
fprintf('OUT  - h2o : %.2f \n\n', m.h2o_sep) ;

fprintf('Ammoniac synthesis \n');
fprintf('(In) - n2  : %.2f \n', m.n2_syn) ;
fprintf('(In) - h2  : %.2f \n', m.h2_syn) ;
fprintf('(In) - ar  : %.2f \n', m.ar_syn) ;
fprintf('OUT  - nh3 : %.2f \n', m.nh3) ;

end
