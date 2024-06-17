clear; clc; close all

%% α)

% Φόρτωση του βίντεο και καταγραφή φωτεινότητας
v = VideoReader('500fps.avi');
i = 0;

while hasFrame(v)
    i = i + 1;
    I = rgb2gray(im2double(readFrame(v)));
    x(i) = I(293, 323);
end

y = x - mean(x);

% Υπολογισμός του FFT και του φάσματος συχνοτήτων
Y = abs(fftshift(fft(y, 512)));
F = linspace(-250, 250, 512);

figure;
plot(F, Y);
title('Μέτρο του DFT');
xlabel('Συχνότητα (Hz)');
ylabel('Μέγεθος');
grid on;
saveas(gcf, 'dft_magnitude.png');

% Εύρεση της θεμελιώδους συχνότητας
[~, idx] = max(Y);
f0 = F(idx);

disp(['Θεμελιώδης Συχνότητα: ', num2str(abs(f0)), ' Hz']);
disp(['Συχνότητα νότας E2: ', num2str(82.41), ' Hz']);

%% β)

% Υπολογισμός των αρμονικών συχνοτήτων
harmonics = f0 * (1:floor((512/2)/(f0/(500/512))));
harmonic_indices = arrayfun(@(h) find(abs(F - h) == min(abs(F - h)), 1), harmonics);
harmonic_frequencies = F(harmonic_indices);
harmonic_magnitudes = Y(harmonic_indices);

for k = 1:length(harmonic_frequencies)
    disp(['Αρμονική ', num2str(k), ': ', num2str(harmonic_frequencies(k)), ' Hz, Μέγεθος: ', num2str(harmonic_magnitudes(k))]);
end

%% γ)

% Φόρτωση του θορυβώδους βίντεο και καταγραφή φωτεινότητας
v_noisy = VideoReader('500fps_noisy.avi');
j = 0;

while hasFrame(v_noisy)
    j = j + 1;
    I_noisy = rgb2gray(im2double(readFrame(v_noisy)));
    x_noisy(j) = I_noisy(293, 323);
end

y_noisy = x_noisy - mean(x_noisy);

% Υπολογισμός του FFT και του φάσματος συχνοτήτων (προ αποθορυβοποίησης)
Y_noisy = abs(fftshift(fft(y_noisy, 512)));
F = linspace(-250, 250, 512);

figure;
plot(F, Y_noisy);
title('Μέτρο του DFT (προ αποθορυβοποίησης)');
xlabel('Συχνότητα (Hz)');
ylabel('Μέγεθος');
grid on;
saveas(gcf, 'dft_magnitude_noisy.png');

% Εύρεση της θεμελιώδους συχνότητας (προ αποθορυβοποίησης)
[~, idx_noisy] = max(Y_noisy);
f0_noisy = F(idx_noisy);

disp(['Θεμελιώδης Συχνότητα (προ αποθορυβοποίησης): ', num2str(abs(f0_noisy)), ' Hz']);

% Εφαρμογή φίλτρου μεσαίας τιμής για αποθορυβοποίηση
y_noisy_filtered = medfilt1(y_noisy, 3);

% Υπολογισμός του FFT και του φάσματος συχνοτήτων (μετά αποθορυβοποίησης)
Y_noisy_filtered = abs(fftshift(fft(y_noisy_filtered, 512)));

% Σχεδίαση του μέτρου του DFT (μετά αποθορυβοποίησης)
figure;
plot(F, Y_noisy_filtered);
title('Μέτρο του DFT (μετά αποθορυβοποίησης)');
xlabel('Συχνότητα (Hz)');
ylabel('Μέγεθος');
grid on;
saveas(gcf, 'dft_magnitude_noisy_filtered.png');

% Εύρεση της θεμελιώδους συχνότητας (μετά αποθορυβοποίησης)
[~, idx_noisy_filtered] = max(Y_noisy_filtered);
f0_noisy_filtered = F(idx_noisy_filtered);

disp(['Θεμελιώδης Συχνότητα (μετά αποθορυβοποίησης): ', num2str(abs(f0_noisy_filtered)), ' Hz']);
disp(['Συχνότητα νότας E2: ', num2str(82.41), ' Hz']);
