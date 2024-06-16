close all
clear
freqz([1 -1],1);
n = 0:1000;
x = cos(pi/32*n);

y = filter([1 -1],1,x);
figure;
plot(x);
figure;
plot(y);

img = imread('photo.jpg');
figure
imagesc(img);colormap gray

dy = filter([1 -1], 1, img);
%imshow(uint8(abs(y)))
figure
%subplot(121);imagesc(img);colormap gray
imagesc(dy);colormap gray

dx = filter([1 -1], 1, img')';
%imshow(uint8(abs(y))')
figure
%subplot(121);imagesc(img);colormap gray
imagesc(dx);colormap gray

N = 5;
h = ones(2*N+1,2*N+1) / (2*N+1)^2;
y = filter2(h,img);
figure
imshow(y/max(y(:)));

