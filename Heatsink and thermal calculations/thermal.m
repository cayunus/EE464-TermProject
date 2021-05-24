Pfet=0.69876; %W
Pdiode=6.2902; %W
Pzener=1.3231; %W
Pcontrol=0.0078831; %W
Ta=25;

% MOSFET parameters
Rjc=5;
Rja_fet=80;

%Secondary Diode parameters
Rja_diode=60;
Rjc_diode=4;

%Clamper Zener parameters
Rjl_zener=25;

% Temperatures without heatsink
Tfet=Pfet*Rja_fet+Ta;
Tdiode=Pdiode*Rja_diode+Ta;
Tzener=Pzener*Rjl_zener+Ta;

% Only secondary diode requires heatsink!
Rha=30;
Tdiode_heatsink=Pfet*(Rjc+Rha)+Ta;
% Rch is not given. Not so important anyway.