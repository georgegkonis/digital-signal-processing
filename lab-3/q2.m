clear; clc; close all
v = VideoReader('500fps.avi');
i=0;
while hasFrame(v)
    i=i+1;
    I = rgb2gray(im2double(readFrame(v)));
    x(i)=I(293,323);
end
y = x - mean(x);
Y = abs(fftshift(fft(y,512)));
F = linspace(-250,250,512);
plot(F,Y);