function d = cents_distance(f_ho,f_ref)
%CENTS_DISTANCE Cents distance calculation: d = cents_distance(f_ho,f_ref) 
%   Function for calculating distance between f_ho and the nearest frequency 
%   in equal tempered scale with reference frequency f_ref. Distance is in
%   cents

d = (100*(12*log2(f_ho/f_ref)-round(12*log2(f_ho/f_ref))));

end