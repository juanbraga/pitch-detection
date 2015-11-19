function [ midi_notation freq fbounds ] = tempered_scale( fref )
%TEMPERED_SCALE Equal-tempered scale: freq = tempered_scale(fref)  
%   Function for creating equal tempered scale from reference frequency 
%   (fref) equivalent to A4 note in piano. Output vector freq contains 97 
%   frequencies corresponding from C0 to C8.

midi_notation = 21:1:108;
freq=(2.^((midi_notation-69)/12))*fref;

fbounds=freq(1)-(freq(2)-freq(1))/2;

for i=1:(length(freq)-1)
    fbounds(i+1)=(freq(i+1)-freq(i))/2+freq(i);
end

fbounds(end+1)=(freq(end)-freq(end-1))/2+freq(end);

end

