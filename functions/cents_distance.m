% distancia en cents
function d = cents_distance(f_ho,f_ref)
d = (100*(12*log2(f_ho/f_ref)-round(12*log2(f_ho/f_ref))));
