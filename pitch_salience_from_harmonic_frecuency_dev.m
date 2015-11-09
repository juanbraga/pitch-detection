% pruebas de pitch salience function from harmoic 
% frecuency deviations
clear all
close all

addpath ./functions/
addpath ./dataset/
addpath ./dataset/adler_thestudyoforchestration

wavname = 'allegromolto_dvoraksymph9_firstmovement.wav';
%wavname = 'BWV_1013_Allemande_fragmento1.wav';

[x,fs,nbits]=wavread(wavname);
t=0:1/fs:(length(x)-1)/fs;  
x=x(:,1);

M=csvread('aubioPitchDetector_SpectralComb.csv');
M2=csvread('aubioPitchDetector_SpectralComb2.csv');

%%help 
figure('Name', 'SoundWave'), plot(t, x, 'r'), grid on,
title('SoundWave'), xlabel('seg'), ylabel('amplitude');
% axis tight, hold on,
axis([0 max(t) -1 1]);

window_length = 4*2048;
n_step = 4*256;
nfft = 2*window_length;
n_overlap = window_length/2 ;
%%
[S,F,T]=spectrogram(x,hanning(window_length),n_overlap,nfft,fs,'yaxis');
logS=10*log10(abs(S));

figure('Name','Espectrograma'), imagesc(T,F,logS), axis xy,
title('Espectrograma'), xlabel('Tiempo(s)'), ylabel('Frecuencia(Hz)'),
% hold on, plot(M(:,1),M(:,2),'k*'), plot(M2(:,1),M2(:,2),'w*'), hold off

%%

npeaks=40;
for i=1:size(S,2);
    [aux_amp, aux_frecs]=findpeaks(abs(S(:,i)),'sortstr', 'descend');
    amp_peaks(:,i)=aux_amp(1:npeaks);
    freq_peaks(:,i)=aux_frecs(1:npeaks);
end

figure('Name','Espectrograma'), imagesc(T,F,logS), axis xy,
title('Espectrograma'), xlabel('Tiempo(s)'), ylabel('Frecuencia(Hz)'),
hold on, plot(T,freq_peaks,'k.'), hold off

%%
% i=100; j=2; alpha=20; beta=10e-5; h=2;
% freq_candidates = sort(F(freq_peaks(:,i)));
% y_gaussian_distance=gaussian_distance(F(freq_peaks(j,i)), alpha, beta, h, freq_candidates);
% figure, plot(freq_candidates,y_gaussian_distance,'*-r'), grid on;

%%
alpha=20; beta=10e-5;
salience=zeros(length(T));
harmonics = 10;
fref=440;
theoretical_dev = cents_distance([1:1:harmonics]*sqrt(1+beta^2)*fref,fref); 

for i=1:length(T)
   freq_candidates = sort(F(freq_peaks(:,i))); 
   for j=1:npeaks 
       f_candidate = F(freq_peaks(j,i));
       for h=1:harmonics
           d_gaussian = gaussian_distance(f_candidate, ...
               alpha, beta, h, freq_candidates);
           d_cents = cents_distance(freq_candidates, fref);
%            d_h(h) = cents_distance(f_candidate*h*sqrt(1+beta^2), fref);
%            figure, plot(d_h,'*r'), hold on, plot(theoretical_dev,'*k'), hold off
%            pause, close all; 
           d_h_fp(h) = d_gaussian'*d_cents;
       end
       aux_peaks(j,i)=theoretical_dev*d_h_fp';    
   end
   [dummy, ind]=sort(aux_peaks(:,i));
   freq_estimated(:,i)=freq_candidates(ind(1:3));
end
%%
figure('Name','Espectrograma'), imagesc(T,F,logS), axis xy,
title('Espectrograma'), xlabel('Tiempo(s)'), ylabel('Frecuencia(Hz)'),
hold on, plot(T,freq_estimated), hold off