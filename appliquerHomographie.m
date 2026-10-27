% Calcul des coordonnees (xy2) des points (xy1)
% apres application d'une homographique H

function [xy2] = appliquerHomographie(H, xy1)

% Entrees :
%
% H   : matrice (3x3) de l'homographie
% xy1 :  matrice (nbPoints x 2) representant les coordonnees 
%       (colonne 1 : les x, colonne 2 : les y) 
%       des nbPoints points auxquels H est appliquee
%
% Sortie :
% xy2 : coordonnees des points apres application de l'homographie

% Nombre de points
% ... A completer ...
NbPoints = size(xy1, 1);

% Construction des coordonnees homogenes pour appliquer l'homographie
% ... A completer ...
xy1_homogene = [xy1 ones(NbPoints, 1)];

% Application de l'homographie
% ... A completer ...
xy2_3d = (H * xy1_homogene')';

% On retourne les coordonnees homogenes (x,y,1)
% Pour cela, il faut diviser par z
% Attention il ne faut garder que les deux premieres coordonnees
% ... A completer ...
z = xy2_3d(:, 3);
xy2_homogene = xy2_3d ./ z;
xy2 = xy2_homogene(:, 1:2);
