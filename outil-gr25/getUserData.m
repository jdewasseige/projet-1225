% GETUSERDATA
%
%
% Some explanations ...
%
%

disp('Choix : ');
disp(' 1- Bilan massique');
disp(' 2- Analyse paramétrique ???');
disp(' 3- Bilan énergétique');
disp(' 4- Nombre de tubes');
disp(' 5- Refroidissement des réacteurs');
disp(' 6- Tout détailler');
choix = 0;
while choix < 1 | choix > 6
    choix = input('Votre choix >> ');
    if isempty(choix)
        choix = 0;
    end
end



        