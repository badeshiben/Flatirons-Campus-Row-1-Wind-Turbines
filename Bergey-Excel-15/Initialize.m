
% clc
% clear all
%%%%%%%%%%% Test of PMSG and wn nominal calculation %%%%%%%%%%%%%%%%%%%%
P1=20348.62314*.9;
Pm_rated=15074.71602;       %%% Rated mechanical power
N=140;                      %%% Max rotor speed, RPM
f=16*N/(60);                %%% Max rotor speed, rad/s
wn=(2*pi*N/60);             %%% Max wn
Tm=-Pm_rated/(wn);          %%% Rated mechanical torque
RS=.51;                     %%% Stator resistance
LS=12.8e-3;                 %%% Stator inductance

%%%%%%%%%%%% Values for Passive Rectifier %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Cs=Inf;                     %%% Snubber capacitance Cs (F)
Rs=1e6;                     %%% Snubber resistance Rs (Ohms)
Ron=1e-2;                   %%% Ron (Ohms) 
Vf=0.6;                     %%% Forward voltage Vf (V)

%%%%%%%%%%%% Values for Load Capacitor with losses after rectifier %%%%%%%
CL=2200e-6;                 %%% Capacitance on Load capacitor (F)
RCL=.00084;                 %%% resistance of capacitor CL (Ohms)

%%%%%%%%%%%% Values for Capacitors with losses Before Rectifier %%%%%%%%%%
C=55e-6;                    %%% Capacitance on Load capacitor (F)  
R=0.001;                    %%% resistance of capacitor CL (Ohms)

%%%%%%%%%%%% Values for Load %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
RL=27.8;                    %%% RL (Ohms) 
%Vdc_nom = 625;              %%% nominal DC voltage (V)

%%%%%%%%%%%% Wind turbine nominal power output %%%%%%%%%%%%%%%%%%%%%%%%%%%
Prated = 14170;             %%% W
Qrated = 19000;             %%% Var  

%%%%%%%%%%%% CP calculations %%%%%%%%%%%%%%%%%%%%%%%%%
% Import the data from Excel for a Cp lookup table
cp_data = xlsread('WS_RPM_source.xlsx','Sheet1');
% Row indices for lookup table
breakpoints1 = cp_data(2:end,1)';
% Column indices for lookup table
breakpoints2 = cp_data(1,2:end);
% Output values for lookup table
RPM_Wind_table_data = cp_data(2:end,2:end);

%%%%%%%%%%%%%%%%%% VDC setpoint calculations from Windspeed %%%%%%%%%%%%%%
% Import the data from Excel 
Vdc_data = xlsread('WS_VDC.xlsx','Sheet1');
% Row indices for lookup table
WS = Vdc_data(2:end,1)';
% Output values for lookup table
Vdc_set = Vdc_data(2:end,3)'; 
P = Vdc_data(2:end,4)';

%%%%%%%%%%%%%%%%%% APC droop parameters. IEEE 1547-2018 defaults %%%%%%%%%
kf=0.05;         %For voltage block case 1
dbf=.02; 
kV = 0.06/0.44;
dbV = 0.02;

%%%%%%%%%%%%%%%%%% Grid Parameters %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Vnom = 240; %V, RMS ph-ph
fnom = 60; %Hz

%%%%%%%%%%%% Simulation time parameters %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Ts =20e-6;  

