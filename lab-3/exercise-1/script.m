clear; close all;

%% α)

% Ορισμός της κρουστικής απόκρισης του συστήματος
h = [1 -1];

% Υπολογισμός της απόκρισης συχνότητας
[H, w] = freqz(h, 1);
mr = abs(H);
pr = angle(H);

figure;
subplot(2,1,1);
plot(w/pi, mr);
title('Απόκριση Μέτρου');
xlabel('Κανονικοποιημένη Συχνότητα (\times\pi rad/sample)');
ylabel('Μέτρο');
subplot(2,1,2);
plot(w/pi, pr);
title('Απόκριση Φάσης');
xlabel('Κανονικοποιημένη Συχνότητα (\times\pi rad/sample)');
ylabel('Φάση (ακτίνια)');
saveas(gcf, 'frequency_response.png');

%% β) 

% Ορισμός του σήματος
n = 0:1000;
omega0 = pi/32;
x = cos(omega0 * n);

% Φιλτράρισμα του σήματος x(n) με τη χρήση της συνάρτησης filter
y = filter(h, 1, x);

figure;
plot(n(1:100), x(1:100));
title('Αρχικό Σήμα (πρώτα 100 δείγματα)');
xlabel('n');
ylabel('x[n]');
saveas(gcf, 'original_signal.png')

figure;
plot(n(1:100), y(1:100));
title('Φιλτραρισμένο Σήμα (πρώτα 100 δείγματα)');
xlabel('n');
ylabel('y[n]');
saveas(gcf, 'filtered_signal.png');

%% γ-δ)

I = imread('photo.jpg');

% Υπολογισμός της πρώτης παραγώγου κατά x
Ix = filter(h, 1, I);

figure;
imshow(Ix, []);
title('\partial I(x,y)/\partial x');
saveas(gcf, 'Ix.png');

% Υπολογισμός της πρώτης παραγώγου κατά y
Iy = filter(h, 1, I')';

figure;
imshow(Iy, []);
title('\partial I(x,y)/\partial y');
saveas(gcf, 'Iy.png');

% Υπολογισμός της δεύτερης παραγώγου κατά x
Ixx = filter(h, 1, Ix);

figure;
imshow(Ixx, []);
title('(\partial^2 I(x,y))/(\partial x^2)');
saveas(gcf, 'Ixx.png');

% Υπολογισμός της δεύτερης παραγώγου κατά y
Iyy = filter(h, 1, Iy')';

figure;
imshow(Iyy, []);
title('(\partial^2 I(x,y))/(\partial y^2)');
saveas(gcf, 'Iyy.png');

% Υπολογισμός της παραγώγου κατά x και y
Ixy = filter(h, 1, Iy);

figure;
imshow(Ixy, []);
title('(\partial^2 I(x,y))/(\partial x \partial y)');
saveas(gcf, 'Ixy.png');

% Υπολογισμός της παραγώγου κατά y και x
Iyx = filter(h, 1, Ix')';

figure;
imshow(Iyx, []);
title('(\partial^2 I(x,y))/(\partial y \partial x)');
saveas(gcf, 'Iyx.png');

%% ε)

% Καμπυλότητα
kappa = (Ixx .* Iy.^2 - 2 .* Ixy .* Ix .* Iy + Iyy .* Ix.^2) ./ (Ix.^2 + Iy.^2).^(3/2);

figure;
imshow(kappa, []);
title('Καμπυλότητα');
saveas(gcf, 'curvature.png');

% Διαφορά Διεύθυνσης
theta = atan2(Iy, Ix);

figure;
imshow(theta, []);
title('Διαφορά Διεύθυνσης');
saveas(gcf, 'gradient_direction_difference.png');

% Λαπλασιανή
LoG = Ixx + Iyy;

figure;
imshow(LoG, []);
title('Λαπλασιανή');
saveas(gcf, 'laplacian.png');

% Ευαισθησία σε Κλίση
H = Ixx .* Iyy - Ixy.^2;

figure;
imshow(H, []);
title('Ευαισθησία σε Κλίση');
saveas(gcf, 'hessian_determinant.png');

%% ε)

for N = [2, 10, 20]
    h2d = ones(2 * N + 1, 2 * N + 1) / (2 * N + 1)^2;
    
    % Εφαρμογή του φίλτρου στην εικόνα χρησιμοποιώντας τη συνάρτηση filter2
    I_filtered = filter2(h2d, I, 'same');
    
    figure;
    imshow(I_filtered, []);
    title(['Φιλτραρισμένη Εικόνα με N = ', num2str(N)]);
    saveas(gcf, ['filtered_image_N', num2str(N), '.png']);
end

%% ζ)

I_deg = imread('photo-deg.jpg');

for N = [2, 10, 20]
    h2d = ones(2 * N + 1, 2 * N + 1) / (2 * N + 1)^2;
    I_filtered = filter2(h2d, I_deg, 'same');
    
    figure;
    imshow(I_filtered, []);
    title(['Φιλτραρισμένη Εικόνα με N = ', num2str(N)]);
    saveas(gcf, ['filtered_image_deg_N', num2str(N), '.png']);
end

%% η)

for N = 1:6
    I_filtered = medfilt2(I_deg, [N N]);
    
    figure;
    imshow(I_filtered, []);
    title(['Φιλτραρισμένη Εικόνα με N = ', num2str(N)]);    
    saveas(gcf, ['median_filtered_image_N', num2str(N), '.png']);
end
