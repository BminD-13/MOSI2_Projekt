%% Das öffnen der 3 Modelle dauert etwas
% die meisten Ergebnisse sind in Plots dargestellt 

%%
clc
clear
close all 

%% Simulationsparameter
timeInitial = 0;            % [jahr]
timeFinal = 20;             % [jahr]
timeStep = 0.05;            % [jahr]

timeVektor = timeInitial : timeStep : timeFinal;

%% Startwerte
touristen_0 = 0.1;
umweltQualitaet_0 = 1;

%% Modelle
simuLinkModels = [
    "WerbeEinflussKonstant.slx"
    "WerbeEinflussLinSteigend.slx"
    "WerbeEinflussSaisonal.slx"
];
ctMdl = length(simuLinkModels);



%% Tests mit pWerbeEinfluss und verschiedenen Modellen
figure('Name','Tourismusdynamik in Abhängigkeit zur Werbung');

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

%% Plot Ergebnisse pWerbeEinfluss 

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

% Plot des Zustandstraumdiagramm
subplot(3, ctMdl, i+ctMdl*2)
t = title("Tourismusdynamik Zustandsraumdiagramm");
t.FontSize = 10;
xlabel("Touristen")
ylabel("Umweltqualitaet")
hold on
for j = 1 : length(iParaSets)
    plot(modelData(j).touristen.Data, modelData(j).umweltQualitaet.Data, 'LineWidth', 1 )
end

hold off

end





%% Tests mit dem Umsatzanteil für Umwelt

figure('Name','Tourismusdynamik in Abhängigkeit Umsatsanteil für Uwelt');

%% p Parameter
% verschiedene Parametersaetze

UmsatzanteilFuerUmwelt = [0.0, 0.1, 0.25, 0.5, 1.0];

for j = 1 : length(UmsatzanteilFuerUmwelt)

    % Standartwerte
    pWerbeEinfluss = 5;          % [1/jahr]
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

%% Plot Ergebnisse Umsatzanteil für Umwelt

% Plot der Touristen
subplot(3, 2, 1)
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
subplot(3, 2, 3)
t = title("Umwelqualität Zeitreihendiagramm");
t.FontSize = 10;
xlabel("Jahre")
hold on
    for j = 1 : length(UmsatzanteilFuerUmwelt)
        plot(modelData(j).tout, modelData(j).umweltQualitaet.Data, 'LineWidth', 1)
        legendInfo(j)= "pUmsatzanteilFuerUmwelt = " + num2str(UmsatzanteilFuerUmwelt(j));
    end
hold off

% Plot Zustandstraumdiagramm
subplot(3, 2, 5)
t = title("Tourismusdynamik Zustandsraumdiagramm");
t.FontSize = 10;
xlabel("Touristen")
ylabel("Umweltqualitaet")
hold on
for j = 1 : length(UmsatzanteilFuerUmwelt)
    plot(modelData(j).touristen.Data, modelData(j).umweltQualitaet.Data, 'LineWidth', 1 )
end
hold off






%% Tests mit dem Umsatzanteil für Umwelt 
% wird in vorheriger Figure geplottet

%% p Parameter
    % Standartwerte
    pWerbeEinfluss = 5;          % [1/jahr]
    pVerlustRate = 0.5;          % [1/jahr]
    pUmsatzanteilFuerUmwelt = 0; % [1]
    pVerbrauchsRate = 0.1;       % [1/jahr]
    pVerbesserungsRate = 1;      % [1/jahr]
    pRegenerationsZeit = 10;     % [1/jahr]
    pKapazitaet = 1;             % [1]

for j = 1 : 20
    %% Startwerte
    touristen_0 = rand*2.2;
    umweltQualitaet_0 = rand*1.2;
    
    %% Simulink Modell
    open("WerbeEinflussLinSteigend.slx")
    modelData(j) = sim("WerbeEinflussLinSteigend.slx");
end

%% Plot der Trajektoren (Ggw und Stabilität) 

% Plot der Touristen
subplot(3, 2, 2)
t = title("Tourismusdynamik Zustandsraumdiagramm");
t.FontSize = 10;
xlabel("Touristen")
ylabel("Umweltqualitaet")
hold on
for j = 1 : 20
    plot(modelData(j).touristen.Data, modelData(j).umweltQualitaet.Data, 'LineWidth', 0.8, 'Color',"#80B3FF" )
end
hold off

