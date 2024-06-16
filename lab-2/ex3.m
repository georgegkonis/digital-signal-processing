close all; clear; clc;

load Noisy.mat
y0 = yw;
Fs = 44100;

%% a

% sound(y0, Fs);

%% b

NumFFT = 4096;
F = linspace(-Fs/2, Fs/2, NumFFT);
Y0 = fftshift(fft(y0, NumFFT));

figure;
plot(F, abs(Y0));
title('Fourier Transform of Noisy Signal');
xlabel('Frequency (Hz)');
ylabel('Magnitude');

%% c

y_filtered = filtfilt(lp_filter_coef, 1, y0);

figure;
freqz(lp_filter_coef, 1, 512, Fs);
title('Frequency Response of Low Pass Filter');

%% d

% sound(y_filtered, Fs);

%% e

T = 1/Fs;
t = 0:T:(length(y0)-1)*T;

figure;
subplot(2,1,1);
plot(t(1:250), y0(1:250));
title('First 250 Samples of Noisy Signal');
xlabel('Time (seconds)');
ylabel('Amplitude');

subplot(2,1,2);
plot(t(1:250), y_filtered(1:250));
title('First 250 Samples of Filtered Signal');
xlabel('Time (seconds)');
ylabel('Amplitude');
