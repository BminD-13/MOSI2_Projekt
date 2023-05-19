%% Parameter
werbeEinfluss = 5;          % [1/jahr]
verlustRate = 0.5;          % [1/jahr]
umsatzanteilFuerUmwelt = 0; % [1]
verbrauchsRate              % [1/jahr]
verbesserungsRate = 1;      % [1/jahr]
regenerationsZeit = 10;     % [1/jahr]

%% Simulationsparameter
initialTime = 0;            % [jahr]
finalTime = 20;             % [jahr]
timeStep = 0.05;            % [jahr]

%% Dynamik
preisniveau = touristen;    % [1]
attraktivitaet = umweltQualitaet/(touristen * preisniveau);  % [1]
touristenZuwachs = attraktivitaet * werbeEinfluss * touristen; % [1/jahr]
touristenVerlust = verlustRate * touristen; % [1/jahr]
umsatz = touristen; % [1]
ausgabenFuerUmwelt = umsatz * umsatzanteilFuerUmwelt / 100; % [1]
umweltVerbrauch = umsatz * umweltQualitaet * verbrausRate;
umweltVerbesserung = ausgabenFuerUmwelt * verbesserungsRate;
umweltErneuerung = (umweltQualitaet / regenerationsZeit) * (1 - umweltQualitaet / kapazitaet);
umweltQualitaet = integralueber(umweltErneuerung + umweltVerbesserung - umweltVerbrauch); % [1]

touristen = integralueber(+ touristenZuwachs - touristenVerlust, 1);% [1]
