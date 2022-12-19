
%%%%%%%%%%% Nominal rotor speed calculation %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
N           = 140;              %%% Max rotor speed (RPM)
wn          = (2*pi*N/60);      %%% Max rotor speed (rad/s)                                                                

%%%%%%%%%%%% Values for Passive Rectifier %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Cs          = Inf;              %%% Snubber capacitance (F)
Rs          = 1e6;              %%% Snubber resistance (Ohms)
Ron         = 1e-2;             %%% Ron (Ohms) 
Vf          = 0.6;              %%% Forward voltage (V)

%%%%%%%%%%%% Values for Power Correction Capacitor right of rectifier %%%%%
Cpc         = 2.2e-3;           %%% F
RCpc        = 0.84e-3;          %%% Ohms

%%%%%%%%%%%% Values for Phase Filters left of rectifier %%%%%%%%%%%%%%%%%%%
C3p         = 55e-6;            %%% F  
R3p         = 0.001;            %%% Ohms

%%%%%%%%%%%% Values for RC filter left of voltage source %%%%%%%%%%%%%%%%%%
Rdc         = 6;                %%% Ohms
Cdc         = 10e-3;            %%% F

%%%%%%%%%%%% Values for DC Load (can replace voltage source and RC filter) 
%RL          = 27.8;             %%% Ohms 

%%%%%%%%%%%% Nominal DC voltage, yields rated power at rated wind speed %%%
Vdc_nom     = 490;              %%% V

%%%%%%%%%%%% Wind turbine nominal power output %%%%%%%%%%%%%%%%%%%%%%%%%%%%
Prated      = 14170;            %%% W
Qrated      = 19000;            %%% Var  

%%%%%%%%%%%%%%%%%% Windspeed cutin %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Ucutin      = 4.5;              %%% m/s

%%%%%%%%%%%% CP calculations %%%%%%%%%%%%%%%%%%%%%%%%%
% Import the data from Excel for a Cp lookup table
cp_data     = xlsread('WS_RPM_source.xlsx','Sheet1');
% Row indices for lookup table
breakpoints1 = cp_data(2:end,1)';
% Column indices for lookup table
breakpoints2 = cp_data(1,2:end);
% Output values for lookup table
RPM_Wind_table_data = cp_data(2:end,2:end);

%%%%%%%%%%%%%%%%%% VDC setpoint calculations from Windspeed %%%%%%%%%%%%%%
% Import the data from Excel 
Vdc_data    = xlsread('WS_VDC.xlsx','Sheet1');
% Row indices for lookup table
WS          = Vdc_data(2:end,1)';
% Output values for lookup table
Vdc_set     = Vdc_data(2:end,3)'; 
P           = Vdc_data(2:end,4)';

%%%%%%%%%%%%%%%%%% APC droop parameters. IEEE 1547-2018 defaults %%%%%%%%%
kf          = 0.05;             %%% frequency droop (1/pu)
dbf         = 0.02;             %%% frequency deadband, (Hz)
kV          = 0.06/0.44;        %%% Voltage droop (1/pu)
dbV         = 0.02;             %%% Voltage deadband (pu)

%%%%%%%%%%%%%%%%%% Grid Parameters %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Vnom        = 240;              %%% V, RMS ph-ph
fnom        = 60;               %%% Hz

%%%%%%%%%%%% Simulation time parameters %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Ts          = 20e-6;            %%% s

