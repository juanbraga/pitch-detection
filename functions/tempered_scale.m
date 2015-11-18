function [ midi_notation freq flow fhigh ] = tempered_scale( fref )
%TEMPERED_SCALE Equal-tempered scale: freq = tempered_scale(fref)  
%   Function for creating equal tempered scale from reference frequency 
%   (fref) equivalent to A4 note in piano. Output vector freq contains 97 
%   frequencies corresponding from C0 to C8.

midi_notation = 21:1:108;
freq=(2^((midi_notation-69)/12))*fref);



end

