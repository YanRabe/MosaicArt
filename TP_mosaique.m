clear;
close all;

% Lecture des images
Im1 = imread('cancale1.pgm');
Im2 = imread('cancale2.pgm');
Im3 = imread('cancale3.pgm');
Im1_coul = imread('cancale1.jpg');
Im2_coul = imread('cancale2.jpg');
Im3_coul = imread('cancale3.jpg');
 
% Affichage des deux premières images en niveaux de gris
figure;
affichage_image(Im1,'Image 1',1,2,1);
affichage_image(Im2,'Image 2',1,2,2);

% Choix des parametres
TailleFenetre = 15;
NbPoints = 100; 
k = 0.05;
seuil = 0.9;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Detection des points d'interet avec Harris %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*
%A DECOMMENTER POUR OBSERVER LA DETECTION DE HARRIS
[XY_1,Res_1] = harris(Im1,TailleFenetre,NbPoints,k);
[XY_2,Res_2] = harris(Im2,TailleFenetre,NbPoints,k);
[XY_3,Res_3] = harris(Im3,TailleFenetre,NbPoints,k);
figure;
affichage_POI(Im1,XY_1,'POI Image 1',1,2,1);
affichage_POI(Im2,XY_2,'POI Image 2',1,2,2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Appariement des points d'interet %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% A DECOMMENTER POUR OBSERVER LA MISE EN CORRESPONDANCE 
% avec/sans verification des contraintes
[XY_C1, XY_C2] = apparier_POI(Im1, XY_1, Im2, XY_2, TailleFenetre, seuil);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Estimation (et verification) de l'homographie %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% A DECOMMENTER QUAND HOMOGRAPHIE AURA ETE COMPLETEE
H12 = homographie(XY_C1, XY_C2)

%%%%%%%%%%%%%%%%%%%%%%%%%
% Calcul de la mosaique %
%%%%%%%%%%%%%%%%%%%%%%%%%
% A DECOMMENTER QUAND HOMOGRAPHIE AURA ETE VALIDEE
Imos = mosaique(Im1,Im2,H12);
figure; 
affichage_image(uint8(Imos),'Mosaique obtenue a partir des 2 images initiales',1,1,1);
% SAUVEGARDE DE LA MOSAIQUE A DEUX IMAGES
imwrite(uint8(Imos),'mosaique2.pgm');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Version 2 pour la reconstruction                %
% A DECOMMENTER QUAND MOSAIQUEBIS AURA ETE ECRITE %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Imosbis = mosaiquebis(Im1,Im2,H12);
figure; 
affichage_image(uint8(Imosbis),'Mosaique obtenue a partir des 2 images initiales (version 2)',1,1,1);
% SAUVEGARDE DE LA MOSAIQUE A DEUX IMAGES VERSION 2
imwrite(uint8(Imosbis),'mosaique2_bis.pgm');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Version 3 pour la reconstruction avec les couleurs R, G et B %
% A DECOMMENTER QUAND MOSAIQUECOUL AURA ETE ECRITE             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Imoscoul = mosaiquecoul(Im1_coul,Im2_coul,H12);
figure;
affichage_image(uint8(Imoscoul),'Mosaique obtenue a partir des 2 images couleur initiales (version 2)',1,1,1);
% SAUVEGARDE DE LA MOSAIQUE A DEUX IMAGES EN COULEUR VERSION 2
imwrite(uint8(Imoscoul),'mosaique2_coul.jpg');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Version 4 pour la reconstruction avec 3 images %%  
% en couleurs et/ou en niveaux de gris           %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% MOSAIQUE 1 2 ET 3

%appariage de l'image 2 et 3 pour obtenir le H de 2 à 3
[XY_C2b, XY_C3] = apparier_POI(Im2, XY_2, Im3, XY_3, TailleFenetre, seuil);

H23 = homographie(XY_C2b, XY_C3);


[nblI2, nbcI2] = size(Im2);

% Calcul des dimensions de la mosaique.
xy_coinsI2_R2 = [1 1; nbcI2 1; nbcI2 nblI2; 1 nblI2];
% Application de l'homographie Hinv sur ces coins.
% Calcul des images des coins dans Imos.
xy_coinsI2_R1 = appliquerHomographie(inv(H12), xy_coinsI2_R2);

% Determination des dimensions de l'image mosaique,
xmin = floor(min([xy_coinsI2_R1(:, 1)' 1]));
ymin = floor(min([xy_coinsI2_R1(:, 2)' 1]));

% Calcul de l'origine de l'image Imos dans le repere de la mosaique Imos2.
O1x_Rmos = 1 - (xmin - 1);
O1y_Rmos = 1 - (ymin - 1);

T12 = [1 0 O1x_Rmos;
       0 1 O1y_Rmos;
       0 0 1];

H_123 = (H23 * H12) / T12;

Imos2 = mosaique(Imosbis, Im3, H_123);
figure;
affichage_image(uint8(Imos2), 'Mosaique obtenue a partir des images 1, 2 et 3', 1, 1, 1);
imwrite(uint8(Imos2), 'mosaique4.pgm');

Imos2coul = mosaiquecoul(Imoscoul, Im3_coul, H_123);
figure;
affichage_image(uint8(Imos2coul), 'Mosaique couleur obtenue a partir des images 1, 2 et 3', 1, 1, 1);
imwrite(uint8(Imos2coul), 'mosaique4_coul.jpg');