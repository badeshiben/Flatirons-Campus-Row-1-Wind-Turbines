%%%%%%%%%%% Test of PMSG and wn nominal calculation %%%%%%%%%%%%%%%%%%%%%%%
%%% 32000 W: Rated mechanical power calculated by P = 1/2*rho*A*Cpmax*Urated^3
N               = 90;               %%% Max rotor speed, RPM
wn              = (2*pi*N/60);      %%% Max rotor speed (rad/s)

%%%%%%%%%%%Cp & Cq Calculation parameters%%%%%%%%%%%%%%%%%%%%%%%%%
rho             = 1.225;            %%% Air Density (kg/m3)
rotor_radius    = 6.25;             %%% Rotor radius (m)
Swept_Area      = 118.82;           %%% Swept Area (m2)
Mp              = Swept_Area*0.5*rho;

%%%%%%%%%%%% Values for Passive Rectifier %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Cs              = Inf;              %%% Snubber capacitance Cs (F)
Rs              = 1e6;              %%% Snubber resistance Rs (Ohms)
Ron             = 1e-2;             %%% Ron (Ohms) 
Vf              = 1.0;              %%% Forward voltage Vf (V)

%%%%%%%%%%%% Values for Power Correction Capacitor right of rectifier %%%
Cpc             = 2.2e-3;           %%% F
RCpc            = 0.84e-3;          %%% Ohms

%%%%%%%%%%%% Values for Phase Filters left of rectifier %%%%%%%%%%
C3p             = 55e-6;            %%% F  
R3p             = 0.001;            %%% Ohms

%%%%%%%%%%%% Values for RC filter left of voltage source %%%%%%%%%%
Rdc             = 6;                %%% Ohms
Cdc             = 10e-3;            %%% F

%%%%%%%%%%%% Values for DC Load (can replace voltage source and RC filter %%% 
RL              = 27.8;             %%% Ohms 

%%%%%%%%%%%% Nominal DC voltage, yields rated power at rated wind speed %%
Vdc_nom         = 605;              %%% V

%%%%%%%%%%%% Wind turbine nominal power output Done%%%%%%%%%%%%%%%%%%%%%%%%%%%
Prated          = 20000;            %%% W
Qrated          = 20000;            %%% Var  

%%%%%%%%%%%%%%%%%% Windspeed cutin/cutout %%%%%%%%%%%%%
Ucutin          = 3;                %%% m/s
Ucutout         = 20;               %%% m/s
%%%%%%%%%%%% CP calculations %%%%%%%%%%%%%%%%%%%%%%%%%
% Import the data from Excel for a Cp lookup table
cp_data         = xlsread('TSR_Cp.xlsx','Sheet1');
% Input indices for lookup table
breakpoints1    = cp_data(2:end,1)';
% Output values for lookup table
TSR_Cp_table    = cp_data(2:end,2);

% %%%%%%%%%%%% CQ calculations %%%%%%%%%%%%%%%%%%%%%%%%%
% Import the data from Excel for a Cp lookup table
cq_data         = xlsread('TSR_Cq.xlsx','Sheet1');
% Input indices for lookup table
breakpoints2    = cq_data(2:end,1)';
% Output values for lookup table
TSR_Cq_table    = cq_data(2:end,2);
 
%%%%%%%%%%%%%%%%% VDC setpoint calculations from Windspeed %%%%%%%%%%%%%%
% Import the data from Excel 
Vdc_data        = xlsread('WS_Cp_VDC.xlsx','Sheet1');
% Row indices for lookup table
WS              = Vdc_data(2:end,1)';
% Output values for lookup table
Vdc_set         = Vdc_data(2:end,3)'; 
Pcal            = Vdc_data(2:end,5)';

%%%%%%%%%%%%%%%%%% APC droop parameters. IEEE 1547-2018 defaults %%%%%%%%%
kf              = 0.05;             %%% frequency droop (1/pu)
dbf             = 0.02;             %%% frequency deadband, (Hz)
kV              = 0.06/0.44;        %%% Voltage droop (1/pu)
dbV             = 0.02;             %%% Voltage deadband (pu)

%%%%%%%%%%%%%%%%%% Grid Parameters %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Vnom            = 240;              %%% V, RMS ph-ph
fnom            = 60;               %%% Hz

%%%%%%%%%%%% Simulation time parameters %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Ts              = 20e-6;            %%% s


