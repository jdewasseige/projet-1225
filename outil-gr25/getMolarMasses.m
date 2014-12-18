function M = getMolarMasses()
%GETMOLARMASSES - Cette fonction renvoit un 'structure array' contenant
% les masses molaires des composes utilises dans le 
% processus. 

M.h2  = 2.01588 ;
M.h2o = 18.0153 ;
M.co  = 28.0101 ;
M.o2  = 31.9988 ;
M.co2 = 44.0095 ;
M.ch4 = 16.0425 ;
M.ar  = 39.9480 ;
M.n2  = 28.0134 ;
M.nh3 = 17.0305 ;

M.air = .21*M.o2 + .78*M.n2 + .01*M.ar ;
end

