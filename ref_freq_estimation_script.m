% Script for reference frequency estimation

clear all, close all;

addpath ./functions/
addpath ./dataset/
addpath ./dataset/adler_thestudyoforchestration

%% Audio load

% wavname = 'allegromolto_dvoraksymph9_firstmovement.wav';
% wavname = 'BWV_1013_Allemande_fragmento1.wav';
wavname = 'density_fragmento_inicio.wav';
% wavname = 'Debussy_Syrinx_fragmento1.wav';

[x,fs]=audioread(wavname);
t=0:1/fs:(length(x)-1)/fs;  
x=x(:,1);

% Temporal Plot
% figure('Name', 'SoundWave'), plot(t, x, 'r'), grid on,
% title('SoundWave'), xlabel('seg'), ylabel('amplitude');
% % axis tight, hold on,
% axis([0 max(t) -1 1]);

%% Spectral analysis

window_length = 4*2048;
hop = window_length/2;
% nfft = 44100;
nfft = 2*window_length;
n_overlap = window_length-hop;

[S,F,T,P]=spectrogram(x,hanning(window_length),n_overlap,nfft,fs,'yaxis');
logP=10*log10(P);

figure('Name','Espectrograma'), imagesc(T,F,logP), axis xy,
title('Espectrograma'), xlabel('Tiempo(s)'), ylabel('Frecuencia(Hz)');


%% Spectral peaks estimation

npeaks=40;
for i=1:size(S,2);
    [aux_amp, aux_frecs]=findpeaks(P(:,i),'sortstr', 'descend');
    amp_peaks(:,i)=aux_amp(1:npeaks);
    freq_peaks(:,i)=F(aux_frecs(1:npeaks));
end

figure('Name','Espectrograma'), imagesc(T,F,logP), axis xy,
title('Espectrograma'), xlabel('Tiempo(s)'), ylabel('Frecuencia(Hz)'),
hold on, plot(T,freq_peaks,'k.'), hold off

%% Circular cents distance calculation 
%(100cents, fref=440Hz) 

circular_cents_distance_peaks=circular_cents_distance(freq_peaks,440);
phi_peaks=cents2phi(circular_cents_distance_peaks);
% figure, polar(phi_peaks,ones(1,length(phi_peaks)),'*');
[real, img]=complex_weighted_mean(phi_peaks, amp_peaks);
[delta_cents, confidence]=complex2cents(real, img)
fref=440*2^(delta_cents/1200)


