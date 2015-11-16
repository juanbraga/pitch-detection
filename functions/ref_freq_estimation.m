function [fref, confidence] = ref_freq_estimation(freq_peaks, amp_peaks)
%REF_FREQ_ESTIMATION Summary of this function goes here
%   Detailed explanation goes here

circular_cents_distance_peaks=circular_cents_distance(freq_peaks,440);
phi_peaks=cents2phi(circular_cents_distance_peaks);
% figure, polar(phi_peaks,ones(1,length(phi_peaks)),'*');
[real, img]=complex_weighted_mean(phi_peaks, amp_peaks);
[delta_cents, confidence]=complex2cents(real, img);
fref=440*2^(delta_cents/1200);


end

