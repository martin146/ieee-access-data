
clc

bs_height_rooftop = 15;
bs_height = 45;
ue_height = 1.2;
f = 860;
street_w = 20;
building_d = 30;
roof_h = 14;
phi = 5;

%Distance in km
dist = 15;

%Selected technology nbiot, sigfox, lorawan
technology = 'sigfox';


%Okumura-Hata Urban
PL = hata_urban(bs_height, ue_height, f, dist, technology);
fprintf('Okumura-Hata PL: %0.3f dB\n', PL);


%COST231 (Walfisch-Ikegami) model
PL = cost231(bs_height, ue_height, f, dist, street_w, building_d, roof_h, phi, technology);
fprintf('COST 231 PL: %0.3f dB\n', PL);


%Ericsson Urban
PL = ericsson_urban(bs_height, ue_height, f, dist, technology);
fprintf('Ericsson Urban PL: %0.3f dB\n', PL);


%Stanford University Interim
PL = sui(bs_height, ue_height, 'B', f, dist, technology);
fprintf('SUI PL: %0.3f dB\n', PL);

%3GPP Urban
PL = urban_3gpp(bs_height_rooftop, f, dist, technology);
fprintf('3GPP urban PL: %0.3f dB\n', PL);
