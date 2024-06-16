close all; clear; clc;

load chirp
y0 = y;
noise = 0.5 * randn(size(y));
Fs = 8992;
yw = y0 + noise;

NumFFT = 4096;
F = linspace(-Fs/2, Fs/2, NumFFT);

%% a

% FIR high-pass filter using fir1
b = fir1(34, 0.48, 'high', chebwin(35, 30));
yf = filtfilt(b, 1, yw);
r1 = yw - yf;

% Frequency response
figure(2);
freqz(b, 1, 512);
title('Frequency Response - fir1 High-pass');

figure(3);
plot(F, abs(fftshift(fft(b, NumFFT))));
title('Magnitude Spectrum - fir1 Filter');

%% b

% FIR high-pass filter using firls
b = firls(34, [0 0.48 0.5 1], [0 0 1 1]);
yf = filtfilt(b, 1, yw);
r2 = yw - yf;

% Frequency response
figure(5);
freqz(b, 1, 512);
title('Frequency Response - firls High-pass');

figure(6);
plot(F, abs(fftshift(fft(b, NumFFT))));
title('Magnitude Spectrum - firls Filter');

%% c

% FIR high-pass filter using firpm
b = firpm(34, [0 0.48 0.5 1], [0 0 1 1]);
yf = filtfilt(b, 1, yw);
r3 = yw - yf;

% Frequency response
figure(8);
freqz(b, 1, 512);
title('Frequency Response - firpm High-pass');

figure(9);
plot(F, abs(fftshift(fft(b, NumFFT))));
title('Magnitude Spectrum - firpm Filter');

%% d

figure(1);
subplot(121); plot(y0(1:100)); 
title('First 100 samples');
subplot(122); plot(y0(end-100:end)); 
title('Last 100 samples');

figure(4);
subplot(121); plot(yf(1:100)); 
title('First 100 samples - fir1 Filtered');
subplot(122); plot(yf(end-100:end)); 
title('Last 100 samples - fir1 Filtered');

figure(7);
subplot(121); plot(yf(1:100)); 
title('First 100 samples - firls Filtered');
subplot(122); plot(yf(end-100:end)); 
title('Last 100 samples - firls Filtered');

figure(10);
subplot(121); plot(yf(1:100)); 
title('First 100 samples - firpm Filtered');
subplot(122); plot(yf(end-100:end)); 
title('Last 100 samples - firpm Filtered');

%% e

% Compute MSE for each filter
MSE = [mean(r1.^2), mean(r2.^2), mean(r3.^2)];
disp('Mean Squared Errors:');
disp(['fir1: ' num2str(MSE(1))]);
disp(['firls: ' num2str(MSE(2))]);
disp(['firpm: ' num2str(MSE(3))]);
