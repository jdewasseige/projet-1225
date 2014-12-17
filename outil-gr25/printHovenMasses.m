function printHovenMasses(m,var)

M = getMolarMasses();

tonnesDay_to_gramSecond = 1e6/(24*60*60);

if var=='t'
    fprintf('\nFour (en tonnes par jour) \n');
    x = m;
else 
    fprintf('\nFour (en moles par secondes) \n');
    x.ch4_four = m.ch4_four/M.ch4 * tonnesDay_to_gramSecond;
	x.o2_four = m.o2_four/M.o2 * tonnesDay_to_gramSecond;
	x.co2_four = m.co2_four/M.co2 * tonnesDay_to_gramSecond;
    x.h2o_four = m.h2o_four/M.h2o * tonnesDay_to_gramSecond;
end
    
fprintf('IN  - ch4 : %.2f \n', x.ch4_four) ;
fprintf('IN  - o2  : %.2f \n', x.o2_four) ;
fprintf('OUT - co2 : %.2f \n', x.co2_four) ;
fprintf('OUT - h2o : %.2f \n', x.h2o_four) ;

end