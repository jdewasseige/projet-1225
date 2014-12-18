function out = getDeltaH_and_S(T)
%GETDELTAH_AND_S - Cette fonction renvoit les valeurs des enthalpies 
% et entropies adaptes a la temperature T via les equations de Shomate
% des composes invoques dans le processus.
%
% input  - T   : temperature en KELVIN
% output - out : vecteur contenant deux 'structure array' de dH et dS

cp = getCoefficients(T);

t = T/1000;

calcH = [t t^2/2 t^3/3 t^4/4 -1/t 1 0 0] ; % en kilo Joules
calcS = [log(t) t t^2/2 t^3/3 -1/(2*t^2) 0 1 0] ;

dH.h2 = cp.h2*calcH' * 1000 ;
dS.h2 = cp.h2*calcS' ;
dH.h2o= cp.h2o*calcH' * 1000 ;
dS.h2o= cp.h2o*calcS' ;
dH.co = cp.co*calcH' * 1000 ;
dS.co = cp.co*calcS' ;
dH.o2 = cp.o2*calcH'  *1000 ;
dS.o2 = cp.o2*calcS' ;
dH.co2= cp.co2*calcH' * 1000 ;
dS.co2= cp.co2*calcS' ;
dH.ch4= cp.ch4*calcH' * 1000 ;
dS.ch4= cp.ch4*calcS' ;
dH.n2 = cp.n2*calcH' * 1000 ;
dS.n2 = cp.n2*calcS' ;
dH.nh3= cp.nh3*calcH' * 1000 ;
dS.nh3= cp.nh3*calcS' ;

out = [dH dS];

end

