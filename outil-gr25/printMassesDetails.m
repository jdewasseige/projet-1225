function printMassesDetails(x,var)

if var=='t'
    fprintf('\n \t DETAILS (en tonnes par jour) \t \n');
else 
    fprintf('\n \t DETAILS (en moles par secondes) \t \n');
end


fprintf('Reformer 1 \n');
fprintf('IN  - ch4 : %.2f \n', x.ch4_in) ;
fprintf('IN  - h2o : %.2f \n\n', x.h2o_in) ;

fprintf('Reformer 2 \n');
fprintf('(In) - ch4 : %.2f \n', x.ch4_ref2) ;
fprintf('(In) - h2o : %.2f \n', x.h2o_ref2) ;
fprintf('(In) - co  : %.2f \n', x.co_ref2) ;
fprintf('(In) - co2 : %.2f \n', x.co2_ref2) ;
fprintf('(In) - h2  : %.2f \n', x.h2_ref2) ;
fprintf(' IN  - o2  : %.2f \n', x.o2_ref2) ;
fprintf(' IN  - n2  : %.2f \n', x.n2_ref2) ;
fprintf(' IN  - ar  : %.2f \n\n', x.ar_ref2) ;

fprintf('WGS \n');
fprintf('(In) - co  : %.2f \n', x.co_wgs) ;
fprintf('(In) - co2 : %.2f \n', x.co2_wgs) ;
fprintf('(In) - n2  : %.2f \n', x.n2_wgs) ;
fprintf('(In) - h2  : %.2f \n', x.h2_wgs) ;
fprintf('(In) - ar  : %.2f \n', x.ar_wgs) ;
fprintf('(In) - h2o : %.2f \n\n', x.h2o_wgs) ;

fprintf('Separation \n');
fprintf('OUT  - co2 : %.2f \n', x.co2_sep) ;
fprintf('(In) - n2  : %.2f \n', x.n2_sep) ;
fprintf('(In) - h2  : %.2f \n', x.h2_sep) ;
fprintf('(In) - ar  : %.2f \n', x.ar_sep) ;
fprintf('OUT  - h2o : %.2f \n\n', x.h2o_sep) ;

fprintf('Ammoniac synthesis \n');
fprintf('(In) - n2  : %.2f \n', x.n2_syn) ;
fprintf('(In) - h2  : %.2f \n', x.h2_syn) ;
fprintf('(In) - ar  : %.2f \n', x.ar_syn) ;
fprintf('OUT  - nh3 : %.2f \n', x.nh3) ;

end
