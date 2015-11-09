function [ real, img ] = complex_weighted_mean( phi, weights )
%COMPLEX_WEIGHTED_MEAN Computes complex weighted mean: [real, img] = complex_weighted_mean(phi, weights)
%   Function that calculates de complex weighted mean of unity complex
%   vectors with angle phi. Returns real and imaginary parts of complex
%   mean

real=sum(cos(phi).*weights)/sum(weights);
img=sum(sin(phi).*weights)/sum(weights);

end

