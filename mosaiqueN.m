
% Pour réaliser une mosaique sur N images
% In : les n images de dim dim(I) x n
% return Imos : mosaique des n images

function Imos = mosaiqueN(In)
    
    TailleFenetre = 15;
    NbPoints = 100;
    k = 0.05;
    seuil = 0.9;

    
    % nombre d'image
    n = size(In, 3);

    % points d'intêrets
    XY = zeros(NbPoints,2, n);
    for i = 1:n
        XY(:, :, i) = harris(In(:, :, i), TailleFenetre, NbPoints, k);
        
    end


    Imos = In(:, :, 1);
    Hmos = eye(3); % Homographie entre Imos actuelle et le niveau i-1

    for i=2:n 

        % apparier_POI
        [XY_Cprecedent, XY_Ccourant] = apparier_POI(In(:, :, i - 1), XY(:, :, i - 1), In(:, :, i), XY(:, :, i), TailleFenetre, seuil);


        % H de precedent vers courant
        H = homographie(XY_Cprecedent, XY_Ccourant);
        Hi = H * Hmos;

        % Dimensions
        [nbl, nbc] = size(In(:, :, i));

        xy_coins_R2 = [1 1; nbc 1; nbc nbl; 1 nbl];
        xy_coins_Rmos = appliquerHomographie(inv(Hi), xy_coins_R2);

        % Determination des dimensions de l'image mosaique,
        xmin = floor(min([xy_coins_Rmos(:, 1)' 1]));
        ymin = floor(min([xy_coins_Rmos(:, 2)' 1]));

        % Calcul de l'origine de l'image Imos dans le repere de la mosaique Imos2.
        O1x_Rmos = 1 - (xmin - 1);
        O1y_Rmos = 1 - (ymin - 1);

        T = [1 0 O1x_Rmos;
            0 1 O1y_Rmos;
            0 0 1];

        % ajout de l'image i
        Imos = mosaiquebis(Imos, In(:, :, i), Hi);

        Hmos = Hi / T;

    end





end