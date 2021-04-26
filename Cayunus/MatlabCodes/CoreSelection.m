%% Core Selection
% Core Parameters
u0 = (4*pi)*1e-7; % Henry/meter - permability of free space
AL = 168e-9; % Henry/Turns^2 - Inductance factor
u = 125*u0; % Permeability of core
le = 98.4e-3; % m - Path length of the core
Ae = 107e-6; % m2 - Cross section of a core
Bsat = 0.6; % Tesla - Saturation flux density of a core type
Lm = 1e-3; % Henry - Desired primary inductance
N = sqrt(Lm/AL); % Turns of primary winding
Ipeak = 4; % A - Max current seen on primary side
Bmax = (N*Ipeak*u)/le; % Tesla - Needed max B (Flux density)

% Saturation current can also calculated from the formula below
Isat_other = (Bsat*le)/(N*u);
Isat = (Bsat*Ae)/sqrt(Lm*AL); % A - Saturation current of the core
%% Winding
% Main aim of the calculation of skin depth is to choose cable having
% radius as thin as skin depth value for the sake of avoid to use thick
% cables in vain.
% Copper relative permeability = 1;
uCu = 1*u0; % Henry/meter - Permeability of copper
TCu = 80; % Celcius - Temperature of Cu
roCu = (1.68e-8)*(1+(TCu-25)*4.29e-3); % Ohm-meter - Resistivity of Cu at T degree
SigmaCu = 1/roCu; % siemens/meter - Conductivity of copper
fs = 100e3; % Hz - Switching frequency
SkinDepth = 1/sqrt(fs*pi*SigmaCu*uCu)*1e3; % mm- Theor. skin depth
SkinDepth_OzanHSlide = [(7.5e-2)/sqrt(fs)]*1e3; % mm - Skin depth at 100°C Ozan Hoca Slide
r_awg = (0.455e-3)/2; % AWG 25 
% Resistance of 1m cable with consideration of skin depth
if (SkinDepth >= r_awg) % Compare the cable mm and SkinDepth
    R_Skin = (roCu*1)/(pi*((r_awg^2)));
else
    R_Skin = (roCu*1)/(pi*((r_awg^2)-((r_awg-SkinDepth)^2)));
end
