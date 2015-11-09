function [ phi ] = cents2phi( cents )
%CENTS2PHI Conversion from cents to angle in complex plane: phi = cents2phi(cents)
%   Function for conversion from circular cents (i.e. between [0, 100])
%   to angle in complex plane, for circular statistics computation of 
%   reference frequency

phi=(2*pi/100).*cents;

end

