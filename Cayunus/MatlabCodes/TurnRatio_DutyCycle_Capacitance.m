Vo = 12; % V - Output voltage
TurnRatio = 10;
VoltageRange = linspace(220,400,100);
Pout = 100; % W - Max output power
Iout = Pout/Vo; % A - Max output current
R = (Vo^2)/Pout;
fs = 100e3; % Hz - Switching frequency
Lm = 0.2e-3; % Henry - Magnetizing inductance
Ipeak = 0; % Max value of an inductor curren
i = 1; % index value for arrays in the while loop
while(i <= numel(VoltageRange))
    D(i) = 1/[((VoltageRange(i)/Vo)*(1/TurnRatio))+1]; % CCM Duty cycle
    C(i) = (D(i)*Iout)/(fs*Vo*0.04);
    ILripple(i) = [D(i)*VoltageRange(i)]/[fs*Lm];
    ILdc(i) = Pout/(VoltageRange(i)*D(i));
    
    % Determine peak value of IL - CCM
    if (Ipeak <= ILdc(i)+ILripple(i)/2 && ILripple(i)/2 < ILdc(i))
        Ipeak = ILdc(i)+ILripple(i)/2;
    end
    
    if (ILripple(i)/2 > ILdc(i)) % Transition to DCM
        %D(i) = [(1/VoltageRange(i))*sqrt(2*Pout*Lm*fs)]; % Constant Po Duty
        D(i) = [(Vo/VoltageRange(i))/sqrt(R/(2*Lm*fs))]; % Constant Vo Duty
        ILripple(i) = [D(i)*VoltageRange(i)]/[fs*Lm];
        ILdc(i) = ILripple(i)/2;
        Ddcm(i) = [(ILripple(i)*Lm*fs)/(Vo*TurnRatio)];
        Doff = 1-D(i)-Ddcm(i);
        if (Ipeak <= ILripple(i)) % Determine peak value of IL - DCM
            Ipeak = ILripple(i);
        end
    end
    i = i+1;
end
figure(1);
plot(VoltageRange,D);
figure(2);
plot(VoltageRange,C);
figure(3);
plot(VoltageRange,ILripple,VoltageRange,ILdc);
legend('ILripple','ILdc')
%% Critical Conduction Mode Line
Vo = 12; % V - Output voltage
TurnRatio = 10;
fs = 100e3;
Lm = 1e-3;
VoltageRange = linspace(220,400,2000);

i = 1; % index value for arrays in the while loop
while(i <= numel(VoltageRange))
    D(i) = 1/[((VoltageRange(i)/Vo)*(1/TurnRatio))+1]; % CCM Duty cycle
    ILripple(i) = [D(i)*VoltageRange(i)]/[fs*Lm];
    P(i) = VoltageRange(i)*ILripple(i)*0.5*D(i);
    i = i+1;
end
plot(VoltageRange,P);

%% MOSFET Losses
%Conduction - Rds
Vo = 12; % V - Output voltage
TurnRatio = 5;
Rds = 0.39; % MOSFET on resistance
VoltageRange = linspace(220,400,2000);
Pout = 100; % W - Output power
i = 1; % index value for arrays in the while loop
while(i <= numel(VoltageRange))
    D(i) = 1/[((VoltageRange(i)/Vo)*(1/TurnRatio))+1]; % CCM Duty cycle
    ILdc(i) = Pout/(VoltageRange(i)*D(i));
    Pcond(i) = Rds*(ILdc(i)^2)*D(i);
    i = i+1;
end
plot(VoltageRange,Pcond);
%% MOSFET Losses
% Switching
% Switching losses are the result of overlapping drain
% current and drain to source voltage at turn on and turn off

% Switching loss is equal to: Switching-time*Vds*I*frequency. 
% The switching time, rise time, and fall time is a function of 
% the gate to drain Miller-charge of the MOSFET, Qgd, the internal 
% resistance of the driver and the Threshold Voltage, Vgs(th) the

Pcoss = 0.5*Coss*(Vds^2)*fs; % W - 1/2CV2 = energy stored in Coss
Psw = 0.5*Vds*Ipeak*toff*fs; % W - Only turn off time is considered

%% RMS of Trapezoid
Vs = 220; % V - Input voltage
Lm = 0.5e-3;
k = Vs/Lm;
D = 0.214;
Ts = 1/(60e3);
Pout = 100;
ILdc = Pout/(Vs*D);
ILripple = (Vs/Lm)*D*Ts;
A = ILdc-ILripple/2;
RMS_trapezoid = sqrt([((k*D*Ts)^2)/3]+[k*D*Ts*A]+[A^2]);
%RMS_new = sqrt([(ILripple^2)/3]+[ILripple*A]+[A^2]);