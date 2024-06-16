img = imread('photo-deg.jpg');
img2 = rgb2gray(img);

%img = imread('photo.jpg')
%img2 = imnoise(img,'salt & pepper',0.1);

imshow(img2);
y = medfilt2(img2,[5 5]);
figure
imshow(y)