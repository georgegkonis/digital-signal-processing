close all;clear;clc;

N = 31;
fc = 0.48;

hc = fir1(N-1,fc,'low');

stem(hc);

freqz(hc,1,512);

NumFFT = 4096;
Freqs = linspace(-pi,pi,NumFFT);

figure
plot(Freqs, abs(fftshift(fft(hc,NumFFT))));
title('Filter frequency response')
grid on

figure
plot(Freqs, 20*log10(abs(fftshift(fft(hc,NumFFT)))));
title('Filter frequency response (dB)')
grid on

figure
plot(Freqs, angle(fft(hc,NumFFT)));
title('Filter frequency response (dB)')
grid on

%%
h_low = firls(N-1,[0,0.2, 0.3, 1] , [1 1 0 0]);
h_high = firls(N-1,[0,0.2, 0.3, 1] , [0 0 1 1]);

figure
plot(Freqs, 20*log(abs(fftshift(fft(h_low,NumFFT)))));
title('Filter frequency response (dB)')
grid on

hold on
plot(Freqs, 20*log10(abs(fftshift(fft(h_high,NumFFT)))));
title('Filter frequency response (dB)')
grid on
