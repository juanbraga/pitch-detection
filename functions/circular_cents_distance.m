function d = circular_cents_distance(f_ho,f_ref)
%CIRCULAR_CENTS_DISTANCE Cents distance calculation: d = cents_distance(f_ho,f_ref) 
%   Function for calculating distance between f_ho and the nearest frequency 
%   in equal tempered scale with reference frequency f_ref. Distance is in
%   cents between 0 and 100 (floor used in calculation) that's why it's 
%   called Circular Cents Distance. 

d = (100*(12*log2(f_ho./f_ref)-floor(12*log2(f_ho./f_ref))));

end