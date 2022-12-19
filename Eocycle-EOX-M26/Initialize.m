
%%%%%%%%%%% Calculate generator initial speed at rated %%%%%%%%%%%%%%%%%%%%
N               = 55;                           %%% Rated rotor speed, RPM
wn              = (2*pi*N/60);                  %%% Rated rotor speed (rad/s)

%%%%%%%%%%% Cp & Cq Calculation parameters %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
rho             = 1.225;                        %%% Air Density (kg/m3)
rotor_radius    = 13;                           %%% Rotor radius (m)
Mp              = 0.5*rho*pi*rotor_radius^2;    %%% for mechanical power calculation

%%%%%%%%%%%% Values for Passive Rectifier %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Cs              = Inf;                          %%% Snubber capacitance Cs (F)
Rs              = 1e6;                          %%% Snubber resistance Rs (Ohms)
Ron             = 0.03;                         %%% Ron (Ohms) 
Vf              = 1.0;                          %%% Forward voltage Vf (V)

%%%%%%%%%%%% Values for Phase Filters left of rectifier %%%%%%%%%%%%%%%%%%%
C3p             = 55e-6;                        %%% F  
R3p             = 0.001;                        %%% Ohms

%%%%%%%%%%%% Values for RLC filter left of voltage source %%%%%%%%%%%%%%%%%%
Rdc             = 0.001;                        %%% Ohms
Cdc             = 0.1;                          %%% F
Ldc             = 0.06;                         %%% H 

%%%%%%%%%%%% Values for DC Load (can replace voltage source and RC filter)  
RL              = 27.8;                         %%% Ohms 

%%%%%%%%%%%% Nominal DC voltage, yields rated power at rated wind speed %%%
Vdc_nom         = 380;                          %%% V

%%%%%%%%%%%% Wind turbine nominal power output %%%%%%%%%%%%%%%%%%%%%%%%%%%%
Prated          = 92450;                        %%% W
Qrated          = 110000;                       %%% Var  

%%%%%%%%%%%%%%%%%% Windspeed cutin/cutout %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Ucutin          = 2.75;                         %%% m/s
Ucutout         = 20;                           %%% m/s

%%%%%%%%%%%% CP calculations %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Import the data from Excel for a Cp lookup table
cp_data         = xlsread('TSR_Cp.xlsx','Sheet1');
% Input indices for lookup table
breakpoints     = cp_data(2:end,1)';
% Output values for lookup table
TSR_Cp_table    = cp_data(2:end,2);

%%%%%%%%%%%%%%%%% VDC setpoint calculations from Windspeed %%%%%%%%%%%%%%%%
% Import the data from Excel 
Vdc_data        = xlsread('WS_CP_VDC.xlsx','Sheet1');
% Row indices for lookup table
WS              = Vdc_data(2:end,1)';
% Output values for lookup table
Vdc_set         = Vdc_data(2:end,2)'; 
Power_est       = Vdc_data(2:end,3)';

%%%%%%%%%%%%%%%%%% APC droop parameters. IEEE 1547-2018 defaults %%%%%%%%%%
kf              = 0.05;                         %%% frequency droop (1/pu)
dbf             = 0.02;                         %%% frequency deadband, (Hz)
kV              = 0.06/0.44;                    %%% Voltage droop (1/pu)
dbV             = 0.02;                         %%% Voltage deadband (pu)

%%%%%%%%%%%%%%%%%% Grid Parameters %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Vnom            = 480;                          %%% V, RMS ph-ph
fnom            = 60;                           %%% Hz

%%%%%%%%%%%% Simulation time parameters %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Ts              = 20e-6;                        %%% s


