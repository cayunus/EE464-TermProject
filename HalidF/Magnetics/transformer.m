clear all
Vin = [220,400];
Vout = 12;
f = 65000;  %Highest frequency assuming Lm = 400uH and Full load
Pout = 100; %Max Power

%% Core selection

Lm = 0.4;           %mH
Ipeak = 3.5;        %Amps
LI2 = Lm*Ipeak^2    %Value needed to find minimum core size
%Note that for our case losses are ver important as well so we pick a much
%larger core to decreas Bmax.

%% Turns number and Bmax

Ae = 107e-6;    %m^2 0076083A7, 0076076A7
Al = 65;        %nH/T^2 Considering DC bias 0076083A7, 0076076A7
N1 = sqrt(Lm*1e6/Al);
N2 = ceil(N1/8);
N1 = N2*8;
Lm = N1^2*Al/1e6;
Bmax = Lm*Ipeak/(N1*Ae*1000) %Maximum Flux induced (Tesla)
%Bmax must not exceed 0.25T otherwise core losses become very large. The
%design is loss limited.

%% Calculating Winding Factor

Is = 12;    %secondary rms current
Ip = 1.2;   %primary rms current
J = 4;      %A/mm^2 Recommended Current Density
area_s = Is/J; %minimum cable area for secondary in mm^2 (AWG17)
area_p = Ip/J; %minimum cable area for primary in mm^2 (AWG12)
AWG22EQV = 0.327e-6;   %Made up of 40 strands of AWG38 (Litz)
AWG12EQV = 3.31e-6;    %Made up of 420 strands of AWG38 (Litz)
AWG38EQV = 0.00811e-6;
Window_A = 426e-6; %m^2 0076083A7, 0076076A7
Cable_A = AWG22EQV*N1 + AWG12EQV*N2 + AWG38EQV*N2;
Fill_Factor = 2.1*Cable_A/Window_A
%We also factor in the fact that litz takes up more space. From the data
%sheets about 2.1 times more for regular litz cable

%% Calculating Core Loss

CLC = 0.4;      %W/cm^3 @65khz and 0.17T
Volume = 10.5;  %cm^3
CoreLoss = CLC*Volume   %Watts

%% Calculating Copper Loss
