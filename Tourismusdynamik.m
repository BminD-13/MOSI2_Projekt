clc
clear
close all 

%% Simulationsparameter
timeInitial = 0;            % [jahr]
timeFinal = 20;             % [jahr]
timeStep = 0.05;            % [jahr]

timeVektor = timeInitial : timeStep : timeFinal;

figure('Name','Tourismusdynamik in Abhängigkeit zur Werbung');

%% Modelle
simuLinkModels = [
    "WerbeEinflussKonstant.slx"
    "WerbeEinflussLinSteigend.slx"
    "WerbeEinflussSaisonal.slx"
];
ctMdl = length(simuLinkModels);

%% p Parameter
% verschiedene Parametersaetze
ParameterSets

for i = 1 : ctMdl
for j = 1 : length(iParaSets)

    % Standartwerte
    pWerbeEinfluss = iParaSets(j).pWerbeEinfluss;
    pVerlustRate = iParaSets(j).pVerlustRate;                   % [1/jahr]
    pUmsatzanteilFuerUmwelt = iParaSets(j).pUmsatzanteilFuerUmwelt; % [1]
    pVerbrauchsRate = iParaSets(j).pVerbrauchsRate;             % [1/jahr]
    pVerbesserungsRate = iParaSets(j).pVerbesserungsRate;       % [1/jahr]
    pRegenerationsZeit = iParaSets(j).pRegenerationsZeit;       % [1/jahr]
    pKapazitaet = iParaSets(j).pKapazitaet;                     % [1]
    
    %% Simulink Modell
    open(simuLinkModels(i))
    modelData(j) = sim(simuLinkModels(i));
end

%% Plot Ergebnisse Simulink Modell 

% Plot der Touristen
subplot(3, ctMdl, i)
[t, s] = title(simuLinkModels(i),"Touristen Zeitreihendiagramm");
t.FontSize = 12;
s.FontSize = 10;
xlabel("Jahre")
hold on  
    for j = 1 : length(iParaSets)
        plot(modelData(j).tout, modelData(j).touristen.Data, 'LineWidth', 1)
    end
hold off

% Plot der Umweltqualitaet
subplot(3, ctMdl, i+ctMdl)
t = title("Umwelqualität Zeitreihendiagramm");
t.FontSize = 10;
xlabel("Jahre")
hold on
    for j = 1 : length(iParaSets)
        plot(modelData(j).tout, modelData(j).umweltQualitaet.Data, 'LineWidth', 1)
        legendInfo(j)= "pWerbeEinfluss = " + num2str(iParaSets(j).pWerbeEinfluss);
    end
    legend(legendInfo);
hold off

%% Plot Ergebnisse Zustandstraumdiagramm
subplot(3, ctMdl, i+ctMdl*2)
t = title("Tourismusdynamik Zustandsraumdiagramm");
t.FontSize = 10;
xlabel("Touristen")
ylabel("Umweltqualitaet")
hold on
for j = 1 : length(iParaSets)
    plot(modelData(j).touristen.Data, modelData(j).umweltQualitaet.Data, 'LineWidth', 1 )
end

%Richtungsfeld funktioniert noch nicht
%[modelData.touristen.Data,modelData.umweltQualitaet.Data]= meshgrid ( 0 :.1 : 3, 0 : .1 : 1) ; % Gitter
%dI = ;
%dS = ;
%norm = sqrt (dI.*dI+dS.*dS);
%h = quiver (I,S,dI./ norm , dS./ norm , 0.5);
%set (h ,Color’, [0.36,0.38,0.4]);
%axis ([0 , 3 ,0 ,1])
hold off

end % verschiedene Siulinkmodelle





%% Tests mit dem Umsatzanteil für Umwelt

figure('Name','Tourismusdynamik in Abhängigkeit Umsatsanteil für Uwelt');

%% p Parameter
% verschiedene Parametersaetze

UmsatzanteilFuerUmwelt = [0.0, 0.1, 0.25, 0.5, 1.0];

for j = 1 : length(UmsatzanteilFuerUmwelt)

    % Standartwerte
    P03.pWerbeEinfluss = 5;          % [1/jahr]
    pVerlustRate = 0.5;          % [1/jahr]
    pUmsatzanteilFuerUmwelt = UmsatzanteilFuerUmwelt(j); % [1]
    pVerbrauchsRate = 0.1;       % [1/jahr]
    pVerbesserungsRate = 1;      % [1/jahr]
    pRegenerationsZeit = 10;     % [1/jahr]
    pKapazitaet = 1;             % [1]

    %% Simulink Modell
    open("WerbeEinflussLinSteigend.slx")
    modelData(j) = sim("WerbeEinflussLinSteigend.slx");
end

%% Plot Ergebnisse Simulink Modell 

% Plot der Touristen
subplot(3, 1, 1)
t = title("Touristen Zeitreihendiagramm");
t.FontSize = 10;
xlabel("Jahre")
hold on  
    for j = 1 : length(UmsatzanteilFuerUmwelt)
        plot(modelData(j).tout, modelData(j).touristen.Data, 'LineWidth', 1)
        legendInfo(j)= "pUmsatzanteilFuerUmwelt = " + num2str(UmsatzanteilFuerUmwelt(j));
    end
legend(legendInfo);
hold off

% Plot der Umweltqualitaet
subplot(3, 1, 2)
t = title("Umwelqualität Zeitreihendiagramm");
t.FontSize = 10;
xlabel("Jahre")
hold on
    for j = 1 : length(UmsatzanteilFuerUmwelt)
        plot(modelData(j).tout, modelData(j).umweltQualitaet.Data, 'LineWidth', 1)
        legendInfo(j)= "pUmsatzanteilFuerUmwelt = " + num2str(UmsatzanteilFuerUmwelt(j));
    end
hold off

%% Plot Ergebnisse Zustandstraumdiagramm
subplot(3, 1, 3)
t = title("Tourismusdynamik Zustandsraumdiagramm");
t.FontSize = 10;
xlabel("Touristen")
ylabel("Umweltqualitaet")
hold on
for j = 1 : length(iParaSets)
    plot(modelData(j).touristen.Data, modelData(j).umweltQualitaet.Data, 'LineWidth', 1 )
end
hold off

