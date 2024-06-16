clear
close all
clc

n=0:1000;
phi = rand(1)*2*pi;
s = sin(0.25*n+phi);

w = randn(1,length(n));
v = filter(1,[1,-0.6],w); %colored noise

%check 
figure;plot(abs(fftshift(fft(w,2^10))))

figure;plot(abs(fftshift(fft(v,2^10))))

x = s+w;


%rn = w.*v;
v0 = v;
w0 = w;

%find the cross correlation
rsx=[0;0];
for n=2:length(v)
    rsx(1)=rsx(1)+v(n)*w(n);
    rsx(2)=rsx(2)+v(n-1)*w(n);
end
rsx=rsx/(length(v)-1);


%find the autocorrelation
v1 = v0;
v2 = v0;

v1(end) = [];
v2(1) = [];

X = [v2;v1];
Rxx = X*X'/length(v1);


hW =  rsx' * inv(Rxx);

%hW = hW;

%corr_vector = xcorr(v, w);

%here find the filter hW
%hW =[];

%apply to colored noise to make it white again 
w_hat = filter(hW,1,v);

%check to see the whitening
figure;plot(abs(fftshift(fft(w_hat,2^10))))


norm(w-w_hat); %to minimize
x_hat = x-w_hat;

subplot(131);plot(s);title('original');
subplot(132);plot(x);title('Noisy');
subplot(133);plot(x_hat);title('Filtered');


rms_noise = norm(x-s);
rms_filtered_noise = norm(x-s-w_hat);