
function y = trans(x) 
    y = tanh(x);
end;

function y = transDiff(x)
    y = 1/cosh(x);
end;
