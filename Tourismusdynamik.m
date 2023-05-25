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

%% Plot Simulink Modell

plot(modelData.tout, modelData.touristen.Data)
% plot(sim.umweltQualitaet.Time, sim.umweltQualitaet.Data)


%% Dynamik

% attraktivitaet =@(t, touristen, umweltQualitaet) umweltQualitaet / (touristen * preisniveau(t)); % [1]
% preisniveau =@(t, touristen) touristen;                                        % [1]
% umsatz =@(t, touristen) touristen;                                             % [1]
% 
% % Touristen
% touristenZuwachs =@(t, touristen, umweltQualitaet) attraktivitaet(t, touristen, umweltQualitaet) * pWerbeEinfluss * touristen;  % [1/jahr]
% touristenVerlust =@(t, touristen) pVerlustRate * touristen;                     % [1/jahr]
% % der inhalt der klammer muss noch integriert werden !!!!!
% touristen_ =@(t, touristen, umweltQualitaet) (touristenZuwachs(t, touristen, umweltQualitaet) - touristenVerlust(t, touristen));% [1] (+ touristenZuwachs - touristenVerlust, 1)
% 
% % Umwelt
% umweltAusgaben =@(t, touristen) umsatz(t, touristen) * pUmsatzanteilFuerUmwelt / 100;         % [1]
% umweltVerbrauch =@(t, touristen, umweltQualitaet) umsatz(t, touristen) * umweltQualitaet * pVerbrauchsRate;    % [1/jahr]
% umweltVerbesserung =@(t, touristen) umweltAusgaben(t, touristen) * pVerbesserungsRate;        % [1/jahr]
% umweltErneuerung =@(t, umweltQualitaet) (umweltQualitaet / pRegenerationsZeit) * (1 - umweltQualitaet / pKapazitaet); % [1/jahr]
% % der inhalt der klammer muss noch integriert werden !!!!!
% umweltQualitaet_ =@(t, touristen, umweltQualitaet) (umweltErneuerung(t, umweltQualitaet) + umweltVerbesserung(t) - umweltVerbrauch(t, touristen, umweltQualitaet)); % [1]
% 
% % Diff'gleichungen mit ode45 loesen
% touristen       = ode45(touristen_, timeVektor,1);
% umweltQualitaet = ode45(umweltQualitaet_, timeVektor,1);

%% Plot

% subplot(3,1,1)
%     plot(timeVektor, touristen);
% subplot(3,1,2)
%     plot(timeVektor, umweltQualitaet);


