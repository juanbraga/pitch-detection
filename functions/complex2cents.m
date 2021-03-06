function [ delta_cents confidence ] = complex2cents( real_mean, img_mean )
%COMPLEX2CENTS Converts real and imaginary parts of complex mean to cents: [delta_cents, confidence] = complex2cents(real_mean, img_mean) 
%   Function for convertion of real and imaginary parts of complex mean to
%   distance in cents (between [0 100]) from a reference frequency (usually)
%   440Hz

% aux_delta_cents=atan(img_mean/real_mean);
% confidence=sqrt(real_mean^2+img_mean^2);

[aux_delta_cents, confidence]=cart2pol(real_mean, img_mean);
ind = find(aux_delta_cents<0);
aux_delta_cents(ind)=aux_delta_cents(ind)+2*pi;
delta_cents=(100*aux_delta_cents)/(2*pi);

end

