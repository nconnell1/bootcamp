function [ modelCoeffs ] = fitQuadModel( X, y )
% FITQUADMODEL Generic function for fitting quadratic models to data
% X can be either a 1 or 2 column matrix, y is a matrix
% See also surf, meshgrid, linspace, ones.

narginchk(2,2)

% Validate X 
validateattributes(X, {'double'}, {'2d', 'real','nonempty'})
if size(X,2) >= 3
    error('fitQuadModel:TooManyCols', 'X must have one or two columns.')
end % if
if any(isinf(X(:)))
    error('fitQuadModel:InfValues', 'X cannot contain Inf or -Inf')
end % if

% Exercise: write the checking code for y
% Validate y
validateattributes(y, {'double'}, ...
    {'column', 'real','nonempty','numel', size(X,1)})
if any(isinf(y) )
    error('fitQuadModel:InfValues', 'y cannot contain Inf or -Inf')
end % if
% if size(y) ~= size(X,1)
%     error('fitQuadModel:SizeInputs','Size of y must be equal to the number of rows in X')
% end % if

% Clean the data.
[XClean, yClean] = removeNANs(X,y);

% Fitting the model.
modelCoeffs = fitModel(XClean, yClean);

% Visualise the results
% visResults(X, y, XClean, modelCoeffs);

end % fitQuadModel


function [XClean, yClean] = removeNANs(X,y)

missingVals = any(isnan([X,y]),2);
XClean = X(~missingVals, :);
yClean = y(~missingVals);

end % remove NaNs

function modelCoeffs = fitModel(XClean, yClean)

nVars = size(XClean, 2); % 1 or 2.
switch nVars
    case 1
        A = [ones(size(XClean)), XClean, XClean.^2];
    case 2
        x1 =XClean(:,1);    x2 =XClean(:,2);    
        A = [ones(size(x1)), x1, x1.^2, x2, x2.^2, x1.*x2];
    otherwise
        error('fitQuadModel:WrongNumberOfVars', ...
            'X must have one or two columns.')
end %switch/case

modelCoeffs = A\yClean;

end % fitModel

function visResults(X, y, XClean, modelCoeffs) %#ok<INUSD,DEFNU>

end % visResults