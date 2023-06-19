clc
clear
close all 

%% p Parameter
pWerbeEinfluss = 5;          % [1/jahr]
pVerlustRate = 0.5;          % [1/jahr]
pUmsatzanteilFuerUmwelt = 0; % [1]
pVerbrauchsRate = 0.1;       % [1/jahr]
pVerbesserungsRate = 1;      % [1/jahr]
pRegenerationsZeit = 10;     % [1/jahr]
pKapazitaet = 1;             % [1]

%% Simulationsparameter
timeInitial = 0;            % [jahr]
timeFinal = 20;             % [jahr]
timeStep = 0.05;            % [jahr]

timeVektor = timeInitial : timeStep : timeFinal;

%% Simulink Modell

open("TourismusdynamikSim")
modelData = sim("TourismusdynamikSim");

%% Plot Ergebnisse Simulink Modell 
figure('Name','Zeitreihendiagramm');
hold on
    plot(modelData.tout, modelData.touristen.Data, 'LineWidth', 1)
    plot(modelData.tout, modelData.umweltQualitaet.Data, 'LineWidth', 1)
    title("Tourismusdynamik Zeitreihendiagramm")
    xlabel("Jahre")
    legend("Touristen","Umweltqualitaet")
hold off

%% Plot Ergebnisse Zustandstraumdiagramm
figure('Name','Zustandsraumdiagramm');              
hold on
plot(modelData.touristen.Data, modelData.umweltQualitaet.Data, 'LineWidth', 1 )
title("Tourismusdynamik Zustandsraumdiagramm")
xlabel("Touristen")
ylabel("Umweltqualitaet")

%Richtungsfeld funktioniert noch nicht
%[modelData.touristen.Data,modelData.umweltQualitaet.Data]= meshgrid ( 0 :.1 : 3, 0 : .1 : 1) ; % Gitter
%dI = ;
%dS = ;
%norm = sqrt (dI.*dI+dS.*dS);
%h = quiver (I,S,dI./ norm , dS./ norm , 0.5);
%set (h ,Color’, [0.36,0.38,0.4]);
%axis ([0 , 3 ,0 ,1])
hold off

