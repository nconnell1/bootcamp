%% Test the function we've just written
% 1D example
x = MedData.Age;
y = MedData.BPDiff; %Pulse Pressure
modelCoeffs = fitQuadModel(x,y)

% Test for the 2D example
height = MedData.Height; % x1
waist = MedData.Waist;   % x2
weight = MedData.Weight; % y
modelCoeffs = fitQuadModel([height, waist], weight)