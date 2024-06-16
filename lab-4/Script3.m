
close all
load eye
approx = zeros(size(I(:,:,1)));
figure;imshow(I(:,:,1))
for counter = 1 : 100
    approx = approx + I(:, :, counter);
end
approx = approx/100;
figure
imshow(approx/max(approx(:)));

%check for a single image
noise_single = I(:,:,1) - approx;
histogram(noise_single, 100);

%m,s extracted from noise from first image
m = mean(noise(:));
s = std(noise(:));

%store into I2 the noise added to each image
I_noise = zeros(100,100,100);
for counter = 1 : 100
    I_noise(:,:,counter) =  I(:, :, counter) -  approx;
end

%calculate the global mean, std
m = mean(I_noise(:)); % I_noise(:) flattens I_noise to a single vector
s = std(I_noise(:));

%m=mean(I2(:)); %flatten I to a vector by I(:)
%s = std(I2(:));
%figure

%generate one random sample per image to check the central
%limit theorem
for j=1:100
    sample(j) = sum(sum(I_noise(:,:,j)-m))/(s*sqrt(100^2));
end

histogram(sample)
m2 = mean(sample);
std2 = std(sample);
