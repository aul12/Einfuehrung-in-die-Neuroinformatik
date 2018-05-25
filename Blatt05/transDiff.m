function y = transDiff(x)
    y = ones(size(x))./(cosh(x).^2);
end;
