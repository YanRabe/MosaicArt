clear;
close all;

% Lecture des images couleur
Im1_coul = imread('cancale1.jpg');
Im2_coul = imread('cancale2.jpg');
Im3_coul = imread('cancale3.jpg');

% Affichage des trois images couleur
figure;
affichage_image(Im1_coul, 'Image 1', 1, 3, 1);
affichage_image(Im2_coul, 'Image 2', 1, 3, 2);
affichage_image(Im3_coul, 'Image 3', 1, 3, 3);

% Mosaique couleur sur N images (h x w x 3 x n)
In_coul = cat(4, Im1_coul, Im2_coul, Im3_coul);
Imos_coul = mosaiqueN_coul(In_coul);

% Affichage de la mosaique
figure;
affichage_image(uint8(Imos_coul), 'Mosaique couleur obtenue a partir des N images', 1, 1, 1);

% Sauvegarde
imwrite(uint8(Imos_coul), 'mosaiqueN_coul.jpg');