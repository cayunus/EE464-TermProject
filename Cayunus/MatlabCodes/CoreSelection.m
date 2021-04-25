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
