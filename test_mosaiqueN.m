clear;
close all;

% Lecture des images
Im1 = imread('cancale1.pgm');
Im2 = imread('cancale2.pgm');
Im3 = imread('cancale3.pgm');
Im1_coul = imread('cancale1.jpg');
Im2_coul = imread('cancale2.jpg');
Im3_coul = imread('cancale3.jpg');

% Affichage des trois images en niveaux de gris
figure;
affichage_image(Im1, 'Image 1', 1, 3, 1);
affichage_image(Im2, 'Image 2', 1, 3, 2);
affichage_image(Im3, 'Image 3', 1, 3, 3);

% Mosaique sur N images (niveaux de gris)
In = cat(3, clear;
close all;

% Lecture des images
Im1 = imread('cancale1.pgm');
Im2 = imread('cancale2.pgm');
Im3 = imread('cancale3.pgm');
Im1_coul = imread('cancale1.jpg');
Im2_coul = imread('cancale2.jpg');
Im3_coul = imread('cancale3.jpg');

% Affichage des trois images en niveaux de gris
figure;
affichage_image(Im1, 'Image 1', 1, 3, 1);
affichage_image(Im2, 'Image 2', 1, 3, 2);
affichage_image(Im3, 'Image 3', 1, 3, 3);

% Mosaique sur N images (niveaux de gris)
In = cat(3, Im1, Im2, Im3);
Imos = mosaiqueN(In);

% Affichage de la mosaique
figure;
affichage_image(uint8(Imos), 'Mosaique obtenue a partir des N images', 1, 1, 1);

% Sauvegarde
imwrite(uint8(Imos), 'mosaiqueN.pgm');Im1, Im2, Im3);
Imos = mosaiqueN(In);

% Affichage de la mosaique
figure;
affichage_image(uint8(Imos), 'Mosaique obtenue a partir des N images', 1, 1, 1);

tes% Sauvegarde
imwrite(uint8(Imos), 'mosaiqueN.pgm');