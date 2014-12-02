function out = myAssert(bool,stop,message)

if ~bool && ~stop
    fprintf(strcat('*!* \t',message, '\t *!* \n'));
else
    assert(bool,message)
end
    
end
