clear all
Vin = [220,400];
Vout = 12;
f = 50000;  %Highest frequency assuming Lm = 400uH and Full load
Pout = 100; %Max Power

%% Core Properties

Ae = 97.1e-6;       %m^2 
Al = 153;           %nH/T^2
SurfaceArea = 35;   %cm^2
Window_A = 122e-6;  %m^2
Volume = 7.63;      %cm^3
MLT = 60e-3;        %m

%% Core selection

Lm = 0.4;           %mH
Ipeak = 3.3;        %Amps
LI2 = Lm*Ipeak^2    %Value needed to find minimum core size

%% Turns number and Bmax

N1 = sqrt(Lm*1e6/Al);
N2 = ceil(N1/8);
N1 = N2*8;
Lm = N1^2*Al/1e6;
Bmax = Lm*Ipeak/(N1*Ae*1000) %Maximum Flux induced (Tesla)
Bpeak = Bmax/2;

%% Calculating Winding Factor

Is = 13;    %secondary rms current
Ip = 1.2;   %primary rms current
J = 4;      %A/mm^2 Recommended Current Density
area_s = Is/J; %minimum cable area for secondary in mm^2 (AWG12)
area_p = Ip/J; %minimum cable area for primary in mm^2 (AWG22)
AWG22EQV = 5*0.08e-6;       %Made up of 5 strands of AWG28
AWG12EQV = 40*0.08e-6;      %Made up of 40 strands of AWG28
AWG36EQV = 0.0127e-6;
Cable_A = AWG22EQV*N1 + AWG12EQV*N2 + AWG36EQV*N2;
Fill_Factor = Cable_A/Window_A

%% Calculating Core Loss

CoreLoss = Volume*0.14  %150mT 50khz

%% Calculating Copper Loss

CR1 = 0.2129/5;
CR2 = 0.2129/40;
Lp = MLT*N1;
Ls = MLT*N2;
Rp = Lp*CR1;
Rs = Ls*CR2;
CopperLoss = Rp*Ip^2 + Rs*Is^2  %Watts
LT = Lp*5 + Ls*40; %33.6meter 55lb=1000pc

%% Temperature Rise

AmbientT = 25;   %Celcius
DeltaT = ((CopperLoss + CoreLoss)*1000/SurfaceArea)^0.833;
TransformerT = AmbientT + DeltaT

