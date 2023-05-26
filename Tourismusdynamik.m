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
hold on
    plot(modelData.tout, modelData.touristen.Data)
    plot(modelData.tout, modelData.umweltQualitaet.Data)
    title("Tourismusdynamik")
    xlabel("Jahre")
    legend("Touristen","Umweltqualitaet")
hold off
