%% Interactive prototyping.
% comment
load S02_MedData

%% Basic data exploration
figure
x = MedData.Age;
y = MedData.BPDiff; % Pulse pressure
scatter(x, y, 'kx')
xlabel('Age (years)')
ylabel('Pulse pressure (mmHf)')
title('Pulse pressure vs. age')

%% Task: aim to fit a model to this data set
% Preprocess to deal with missing values
missingVals = isnan(x) | isnan(y);
xClean = x(~missingVals);
yClean = y(~missingVals);
% Formulate the model and write it in MATLAB code.
% We can write this as
% pulsePressure = [1, Age, Age^2] * [C0; C1; C2]
% This is vector multiplucation   (Ax = b)
% A = age (known)
% x = (C0, C1, C2) (unknown)
% b is the pulse pressure
b = yClean;
A = [ones(size(xClean)), xClean, xClean.^2];
% Alternative to ONES: xClean.^0
modelCoeffs = A\b; % Solve the system
% Get the fitted curve;
pulseModel = A * modelCoeffs;
% Plot;
hold on
plot(xClean, pulseModel, 'r*')
legend('Raw Data', 'Fitted Model')

%% Move to three dimensions (Exercise before break)
height = MedData.Height; % x1
waist = MedData.Waist;  % x2
weight = MedData.Weight; % y
x1 = height;
x2 = waist;
y = weight;
% Problem: can we estimate wight (y) using height and waist measurments (x1
% and x2)
% We'll use a quadratic model.

% Step 1: Plot the raw data (SCATTER3)
figure 
scatter3(x1, x2, y, 'kx')
xlabel('height (cm)')
ylabel('waist (cm)')
zlabel('weight (kg)')
title('height vs. waist vs. weight')

% Step 2: Clean the data (ISNAN)
badRows = any(isnan([x1, x2, y]),2);
% missingVals2 = isnan(height) | isnan(waist) | isnan(weight);
x1Clean = x1(~badRows);
x2Clean = x2(~badRows);
yClean = y(~badRows);

% Step 3: Formulate and solve the model
% Formula
% C0 + C1*height + C2*height^2 + C3*waist + C4*waist^2 + C5*waist*height
A2 = [ones(size(x1Clean)), x1Clean, ...
    x1Clean.^2, x2Clean, x2Clean.^2, ...
    x2Clean.*x1Clean];
b2 = yClean;

modelCoeffs2 = A2\b2;
weightModel = A2 * modelCoeffs2;
% 
% plot3(heightClean, waistClean, weightModel, 'r*')

%% Step 4: Visulisation
modelFun = @(c, x1, x2) c(1) + c(2)*x1 + c(3)*x1.^2 + ...
                        c(4)*x2 + c(5)*x2.^2 + c(6)*x1.*x2;
% Substep 1: make vector data for x1 and x2.
x1Vec = linspace(min(x1Clean), max(x1Clean),150);
x2Vec = linspace(min(x2Clean), max(x2Clean),150);
% Substep 2: turn this into a grid
[X1, X2] = meshgrid(x1Vec, x2Vec);
% Substep3: evaluate the model on the grid
modelOnGrid = modelFun(modelCoeffs2, X1, X2);
hold on

surf(X1, X2, modelOnGrid, 'EdgeAlpha', 0,'LineStyle','none')

% EdgeAlpha = transparency of the edges in the grid
