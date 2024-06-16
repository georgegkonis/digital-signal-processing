close all;clear;clc;

N = 29;
fc = 0.4;
NumFFT = 4096;
Freqs = linspace(-1, 1, NumFFT) * pi;

%% a

% Low-pass filter using fir1
hc = fir1(N-1, fc, 'low');
figure(1);
plot(Freqs/pi, abs(fftshift(fft(hc, NumFFT))));
title('Magnitude Response of Low-pass FIR Filter (fir1)');

% High-pass filter using fir1
hc = fir1(N-1, fc, 'high');
figure(2);
plot(Freqs/pi, abs(fftshift(fft(hc, NumFFT))));
title('Magnitude Response of High-pass FIR Filter (fir1)');

%% b

% Low-pass filter using firls
hc = firls(N-1, [0 0.1 0.35 1], [1 1 0 0], [1 1]);
figure(3);
plot(Freqs/pi, abs(fftshift(fft(hc, NumFFT))));
title('Magnitude Response of Low-pass FIR Filter (firls)');

% High-pass filter using firls
hc = firls(N-1, [0 0.1 0.35 1], [0 0 1 1], [1 1]);
figure(4);
plot(Freqs/pi, abs(fftshift(fft(hc, NumFFT))));
title('Magnitude Response of High-pass FIR Filter (firls)');

%% c

% Low-pass filter using firpm
hc = firpm(N-1, [0 0.1 0.35 1], [1 1 0 0], [1 1]);
figure(5);
plot(Freqs/pi, abs(fftshift(fft(hc, NumFFT))));
title('Magnitude Response of Low-pass FIR Filter (firpm)');

% High-pass filter using firpm
hc = firpm(N-1, [0 0.1 0.35 1], [0 0 1 1], [1 1]);
figure(6);
plot(Freqs/pi, abs(fftshift(fft(hc, NumFFT))));
title('Magnitude Response of High-pass FIR Filter (firpm)');
