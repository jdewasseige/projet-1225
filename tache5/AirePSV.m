function out = AirePSV(DH, F, Pdesign, T)
k = 1.33;

Q = 43200 * (45.72 * pi)^0.82;
W = (Q * 0.001 * 3600 * F) / DH; %transformation en kg/Hr
C = 0.03948 * sqrt(k * ( 2 /(k+1) )^( (k+1)/(k-1) ));
P = (Pdesign * 1.21 + 1.01325) * 100; %transformation en kPa

Aire = W / (0.975 * P * C) * sqrt(T/17);
Airesqinch = Aire / (25.4^2);
out = [Aire, Airesqinch];
end