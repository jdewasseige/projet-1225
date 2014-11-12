function out = myAssert(bool,stop,message)
% Cette fonction est une variante de la fonction 'assert'.
% Elle permet de continuer l'execution du programme si l'argument
% 'stop' est faux, tout en affichant un message pour prevenir 
% d'une possible erreur.

if ~bool && ~stop
    fprintf(strcat('*!*!* \t',message, '\t *!*!* \n'));
else
    assert(bool,message)
end
    
end

