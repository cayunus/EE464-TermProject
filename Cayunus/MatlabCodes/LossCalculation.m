%% MOSFET Loss Calculation
% Parameters
% Rds is taken according to calculated RMS value
Rds = 0.4; % Ohm - Mosfet on resistance
ton = (6+5)*1e-9; % Second - Mosfet turn-on time
toff = (13+27)*1e-9; % Second - Mosfet turn-off time

Lm = 1e-3; % Henry - Coupled inductor primary inductance
fs = 100e3; % Hz - Switching frequency
n = 20; % Turns ratio n:1
Pout = 100; % W - Output power
Vo = 12; % V - Output voltage
Ro = (Vo^2)/Pout; % Ohm - Output resistance

VoltageRange = linspace(220,400,2000); % V - Input voltage range
i = 1; % index value for arrays in the while loop
while(i <= numel(VoltageRange))
    D(i) = 1/[((VoltageRange(i)/Vo)*(1/n))+1]; % CCM Duty cycle
    ILripple(i) = [D(i)*VoltageRange(i)]/[fs*Lm];
    ILdc(i) = Pout/(VoltageRange(i)*D(i));
    Vds(i) = (VoltageRange(i)+(n*Vo))*1.3;
    A(i) = ILdc(i)-ILripple(i)/2;
    B(i) = ILdc(i)+ILripple(i)/2;
    Irms(i) = sqrt([(ILripple(i)^2)/3]+[ILripple(i)*A(i)]+[A(i)^2]);
    if (ILripple(i)/2 > ILdc(i)) % Transition to DCM
        D(i) = [(Vo/VoltageRange(i))/sqrt(Ro/(2*Lm*fs))]; % Constant Vo Duty
        ILripple(i) = [D(i)*VoltageRange(i)]/[fs*Lm];
        Ddcm(i) = [(ILripple(i)*Lm*fs)/(Vo*n)];
        Irms(i) = ILripple(i)/sqrt(3);
        Vds(i) = VoltageRange(i);
        A(i) = 0;
        B(i) = ILripple(i);
    end
    Pmos_cond(i) = (Irms(i)^2)*Rds*D(i);
    Pmos_swOn(i) = 0.5*A(i)*Vds(i)*ton*fs;
    Pmos_swOff(i) = 0.5*B(i)*Vds(i)*toff*fs;
    i = i+1;
end
figure(1);
plot(VoltageRange,Pmos_cond);
title('Conduction Losses')
figure(2);
plot(VoltageRange,Pmos_swOn);
title('Switching Turn-On Losses')
figure(3);
plot(VoltageRange,Pmos_swOff);
title('Switching Turn-Off Losses')