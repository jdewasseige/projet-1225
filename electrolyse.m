function out = electrolyse()
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

ph = [0 1 2 3 5] ;

result = zeros(5, 2);

for i =1:5
    result(i,:) = calcH2SO4(ph(i)) ;
    fprintf('Pour un pH = %d, il faut %.3f ml de H2SO4(5M). \n', ph(i), result(i,1)*200);
end


end 

function out = calcH2SO4(ph)

K = 0.0126 ;

syms x ksi positive real

eq1= K == (x + ksi)*ksi/(x - ksi) ;
eq2= ph == -log10(x + ksi) ;

[x,ksi] = solve(eq1,eq2,x,ksi) ;

n_H2SO4 = double(x) ;
n_H3O = double(ksi) ;

out = [n_H2SO4 n_H3O] ;

end


