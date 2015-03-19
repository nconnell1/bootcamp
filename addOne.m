function xplusone = addOne(x)

narginchk(1,1) % Enforce 1 input.
validateattributes(x, {'double', 'char'}, {'nonempty'})

xplusone = x + 1;
if ischar(x) == 1
    xplusone = char(xplusone);
end %if

end % addOne