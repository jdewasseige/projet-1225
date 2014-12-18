function cp = getCoefficients(T)
%GETCOEFFICIENTS - Cette fonction renvoit un 'structure array' contenant
% les coefficients qui vont etre utilises dans 
% les equations de Shomate pour determiner les 
% enthalpies et entropies de reactions.
% input  -  T  : temperature en KELVIN 
% output -  cp : structure contenant  les valeurs des coefficients
%                pour chaque compose utilise dans le processus

if T < 1000
    cp.h2 = [33.066178 -11.363417 11.432816 -2.772874 ...
        -0.158558 -9.980797 172.707974 0] ;
else
    cp.h2 = [18.563083 12.257357 -2.859786 0.268238 ...
        1.977990 -1.147438 156.288133 0] ;
end
cp.h2o = [30.09200 6.832514 6.793435 -2.534480 ...
    0.082139 -250.8810 223.3967 -241.8264] ;  %500-1700
cp.co  = [25.56759 6.096130 4.054656 -2.671301 ...
    0.131021 -118.0089 227.3665 -110.5271] ;  %298-1300
cp.o2  = [30.03235 8.772972 -3.988133 0.788313 ...
    -0.741599 -11.32468 236.1663 0] ;         %700-2000
cp.co2 = [24.99735 55.18696 -33.69137 7.948387 ...
    -0.136638 -403.6075 228.2431 -393.5224] ; %298-1200
cp.ch4 = [-0.703029 108.4773 -42.52157 5.862788 ...
    0.678565 -76.84376 158.7163 -74.87310] ;  %298-1300
cp.n2  = [19.50583 19.88705 -8.598535 1.369784 ...
    0.527601 -4.935202 212.3900 0] ;          %500-2000
cp.nh3 = [19.99563 49.77119 -15.37599 1.921168 ...
    0.189174 -53.30667 203.8591 -45.89806] ;  %298-1400

end

