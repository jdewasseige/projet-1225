function out = myAssert(bool,stop,message)
% Cette fonction est une variante de la fonction 'assert'.
% Elle permet de continuer l'execution du programme si l'argument
% 'stop' est faux, tout en affichant un message pour prevenir 
% d'une possible erreur.
%
% input  - bool    : condition qui doit etre verifiee
%        - stop    : 0 (resp. 1) on continue (resp. arrete) l'execution
%                    en affichant un $message
%        - message : message d'erreur

if ~bool && ~stop
    fprintf(strcat('*!* \t',message, '\t *!* \n'));
else
    assert(bool,message)
end
    
end
