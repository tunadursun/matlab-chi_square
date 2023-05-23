clear all 
clc 
dataTD = dlmread('sleeplessnights.txt'); 
tempTD = (dataTD(:, 2) - 32) * 5 / 9; 
xTD = dataTD(:, 1) / 60;  
yTD = tempTD; 
nTD = length(xTD); 
xmeanTD = mean(xTD); 
ymeanTD = mean(yTD); 
xyTD = sum(xTD .* yTD) - nTD * xmeanTD * ymeanTD; 
xxTD = sum(xTD .* xTD) - nTD * xmeanTD * xmeanTD; 
b1TD = xyTD / xxTD;   
b0TD = ymeanTD - b1TD * xmeanTD; 

plot(xTD, yTD, 'o', 'MarkerSize', 6, 'MarkerEdgeColor', 'b', 'MarkerFaceColor', 'b'); 
hold on; 
xfitTD = linspace(min(xTD), max(xTD), 100); 
yfitTD = b0TD + b1TD * xfitTD; 
plot(xfitTD, yfitTD, 'r-', 'LineWidth', 2); 
xlabel('Chirps per Second'); 
ylabel('Temperature (Celsius)'); 
legend('Data', 'Linear Fit', 'Location', 'Northwest'); 
title('Temperature vs. Chirps per Second'); 

yexpectedTD = b0TD + b1TD * xTD;  
observedTD = yTD - yexpectedTD;  
sigmaTD = std(observedTD);  
chi2TD = sum(observedTD .^ 2 / sigmaTD ^ 2);  
dofTD = nTD - 2;  
pTD = gammainc(chi2TD/2, dofTD/2); 
fprintf('  Chi-Square Value = %f\n', chi2TD); 
fprintf('  Degrees of Freedom = %d\n', dofTD); 
fprintf('  p-value = %f\n', pTD); 
