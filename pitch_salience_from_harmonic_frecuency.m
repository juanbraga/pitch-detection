% pruebas de pitch salience function from harmoic 
% frecuency deviations
clear all
close all

addpath ./functions/
addpath ../../traditional_dataset/allemande/fragments
addpath ../../traditional_dataset/density/fragments

% wavname = 'allemande_first_fragment_nicolet_mono.wav'
% wavname = 'density_first_fragment_zoon_mono.wav'
wavname = 'density_fourth_fragment_beauregard_mono.wav'

[x,fs]=audioread(wavname);
t=0:1/fs:(length(x)-1)/fs;  
% x=x(:,1);

%% 
figure('Name', 'SoundWave'), plot(t, x, 'r'), grid on,
title('SoundWave'), xlabel('seg'), ylabel('amplitude');
% axis tight, hold on,
axis([0 max(t) -1 1]);

window_length = 2048;
hop = window_length/2;
nfft = 2*window_length;
n_overlap = window_length - hop ;

[S,F,T]=spectrogram(x,hanning(window_length),n_overlap,nfft,fs,'yaxis');
logS=10*log10(abs(S));

% figure('Name','Espectrograma'), imagesc(T,F,logS), axis xy,
% title('Espectrograma'), xlabel('Tiempo(s)'), ylabel('Frecuencia(Hz)');

%%

npeaks=40;
for i=1:size(S,2);
    [aux_amp, aux_frecs]=findpeaks(abs(S(:,i)),'sortstr', 'descend');
    amp_peaks(:,i)=aux_amp(1:npeaks);
    freq_peaks(:,i)=F(aux_frecs(1:npeaks));
end

% figure('Name','Espectrograma'), imagesc(T,F,logS), axis xy,
% title('Espectrograma'), xlabel('Tiempo(s)'), ylabel('Frecuencia(Hz)'),
% hold on, plot(T,freq_peaks,'k.'), hold off

[fref,confidence]=ref_freq_estimation(freq_peaks, amp_peaks)

%%
alpha=20; beta=10e-5;
salience=zeros(length(T));
harmonics = 8;
theoretical_dev = cents_distance([1:1:harmonics]*sqrt(1+beta^2)*fref,fref); 
% figure, plot(theoretical_dev, 'o'), grid on;

for i=1:length(T)
   freq_candidates = sort(freq_peaks(:,i)); 
%    figure, plot(freq_candidates), hold on, plot(freq_peaks(:,i)), hold off;
%    pause;
%    close figure(10);
   for j=1:npeaks 
       f_candidate = freq_peaks(j,i);
       for h=1:harmonics
           d_gaussian = gaussian_distance(f_candidate, ...
               alpha, beta, h, freq_candidates);
           d_cents = cents_distance(freq_candidates, fref);
%            d_h(h) = cents_distance(f_candidate*h*sqrt(1+beta^2), fref);
%            figure, plot(d_h,'*r'), hold on, plot(theoretical_dev,'*k'), hold off
%            pause, close all; 
           d_h_fp(h) = d_gaussian'*d_cents;
       end
%        figure(11), plot(d_h_fp, 'ro'), grid on;
%        pause; 
       aux_peaks(j,i)=amp_peaks(j,i)*theoretical_dev*d_h_fp';
       aux_freqs(j,i)=f_candidate;
   end
   [dummy, ind]=sort(aux_peaks(:,i), 1, 'descend');
   freq_estimated(:,i)=aux_freqs(ind(1),i);
end

%%

[midi, freq440, fbounds] = tempered_scale(440);
[midi, freq, fbounds] = tempered_scale(fref);

% figure('Name','Espectrograma'), imagesc(T,F,logS), axis xy,
% title('Espectrograma'), xlabel('Tiempo(s)'), ylabel('Frecuencia(Hz)'),
% hold on, plot(T,freq_estimated), hold off

black = abs(1-gray);

figure('Name','Espectrograma'), imagesc(T,F,logS()), colormap(black), axis xy,
title('Espectrograma'), xlabel('Tiempo(s)'), ylabel('Frecuencia(Hz)'), 
axis([0 T(end) fbounds(1) fbounds(end)]), hold on, 
plot(T,freq_estimated, '-r'), 
% for i=1:length(freq) 
%     hline = refline(0,freq(i));    
%     set(hline,'Color','b')
%     hline = refline(0,freq440(i));    
%     set(hline,'Color','k')
% end
hold off
