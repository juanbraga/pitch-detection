function [ freq ] = tempered_scale( fref )
%TEMPERED_SCALE Equal-tempered scale: freq = tempered_scale(fref)  
%   Function for creating equal tempered scale from reference frequency 
%   (fref) equivalent to A4 note in piano. Output vector freq contains 97 
%   frequencies corresponding from C0 to C8.

freq(58)=fref;
for i=1:57
    freq(58-i)=freq(58-(i-1))/2^(1/12);
end

for i=1:39
    freq(58+i)=freq(58+(i-1))*2^(1/12);
end

end

