%% Parameter
werbeEinfluss = 5;          % [1/jahr]
verlustRate = 0.5;          % [1/jahr]
umsatzanteilFuerUmwelt = 0; % [1]
verbrauchsRate = 0.1;       % [1/jahr]
verbesserungsRate = 1;      % [1/jahr]
regenerationsZeit = 10;     % [1/jahr]
kapazitaet = 1;             % [1]

%% Simulationsparameter
initialTime = 0;            % [jahr]
finalTime = 20;             % [jahr]
timeStep = 0.05;            % [jahr]

%% Dynamik
preisniveau = touristen;                                        % [1]
attraktivitaet = umweltQualitaet/(touristen * preisniveau);     % [1]
umsatz = touristen;                                             % [1]

% Touristen
touristenZuwachs = attraktivitaet * werbeEinfluss * touristen;  % [1/jahr]
touristenVerlust = verlustRate * touristen;                     % [1/jahr]

touristen = integralueber(+ touristenZuwachs - touristenVerlust, 1);% [1]

% Umwelt
umweltAusgaben = umsatz * umsatzanteilFuerUmwelt / 100;         % [1]
umweltVerbrauch = umsatz * umweltQualitaet * verbrauchsRate;    % [1/jahr]
umweltVerbesserung = umweltAusgaben * verbesserungsRate;        % [1/jahr]
umweltErneuerung = (umweltQualitaet / regenerationsZeit) * (1 - umweltQualitaet / kapazitaet); % [1/jahr]

umweltQualitaet = integralueber(umweltErneuerung + umweltVerbesserung - umweltVerbrauch); % [1]
