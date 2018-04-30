%---------------------------------------------------%
% Debris Pickup Problem                             %
%---------------------------------------------------%
% The problem solved here is given as follows:      %
%   Minimize dV = Isp*g0*ln((mp+mf)/mf)             % or dV = A_tot*dt
% subject to the dynamic constraints                %
%    dx/dt = v(t)                                   %
%    dv/dt = -v(t) + u(t)                           %
% and the control constraints are                   %
%    0 <= u(t) <= 2                                 %
% and the boundary conditions                       %
%    x(0) = 0, v(0) = 0.1                           %
%    x(1) = 0.5, v(1) = 0.8                         %
%---------------------------------------------------%

clear all; close all; clc

% Constants
mu                  = 398601; %[km^3/s^2] %3.986012e14; %[m^3/s^2]
thrusterForce       = 200; %[N]
initialMass         = 1088; %[kg], mass of ASTRO (orbital express); mp = 136kg
g0                  = 9.80665; %[m/s^2]
Isp                 = 300; %[s], chemical bipropellant
TAR1Mass            = 124; %[kg]
TAR2Mass            = 110; %[kg]
TAR3Mass            = 170; %[kg]

% Time
t0 = 0;
tfmin = 0; tfmax = 1000;
%%%% Chaser - circular orbit with no inclination %%%%
% initialize position
CHA_x0 = 6600; %[km]
CHA_y0 = -300; %[km]
CHA_z0 = 0;   %[km]
CHA_r0 = [CHA_x0, CHA_y0, CHA_z0];
CHA_rmag = sqrt(CHA_x0^2 + CHA_y0^2 + CHA_z0^2); %[km]
% initialize velocity
CHA_vmag = sqrt(mu/CHA_rmag); %[km/s]
CHA_vx0 = CHA_vmag*(CHA_x0/CHA_rmag);
CHA_vy0 = CHA_vmag*(CHA_y0/CHA_rmag);
CHA_vz0 = CHA_vmag*(CHA_z0/CHA_rmag);
CHA_v0 = [CHA_vx0,CHA_vy0,CHA_vz0];
CHA_rmin = -10000*ones(1,3); CHA_rmax = 10000*ones(1,3);
CHA_vmin = -50*ones(1,3); CHA_vmax = 100*ones(1,3); 
% Chaser mass
m0 = initialMass;
mmax = 2*initialMass;
mmin = 1;

%%%% Target 1 - HETE-2 %%%%
% initial position from Earth's center?
TAR1_x0 = 6916;  %[km]
TAR1_y0 = -325;  %[km]
TAR1_z0 = 53;  %[km]
TAR1_r0 = sqrt(TAR1_x0^2 + TAR1_y0^2 + TAR1_z0^2); %[km]

CHA_xf = TAR1_x0; CHA_yf = TAR1_y0; CHA_zf = TAR1_z0; 

%%%% Target 2 - Pegasus 3rd stage %%%%
TAR2_x0 = 6080; %[km]
TAR2_y0 = -3261; %[km]
TAR2_z0 = -202; %[km]

%%%% Target 3 - AGILE %%%%
TAR3_x0 = 5993; %[km]
TAR3_y0 = -3311; %[km]
TAR3_z0 = 52; %[km]

% Control (for Chaser)
umin = -10*ones(1,3); 
umax = 10*ones(1,3); 

% Auxiliary Data
auxdata.thrusterForce   = thrusterForce;
auxdata.g0              = g0;
auxdata.Isp             = Isp;
auxdata.mu              = mu;
auxdata.TAR1_x          = TAR1_x0;
auxdata.TAR1_y          = TAR1_y0;
auxdata.TAR1_z          = TAR1_z0;
auxdata.TAR1Mass        = TAR1Mass;

%-------------------------------------------------------------------------%
%----------------------Phase 1: Chaser to Target 1------------------------%
%-------------------------------------------------------------------------%

iphase = 1;
% t0 fixed
bounds.phase(iphase).initialtime.lower = t0; 
bounds.phase(iphase).initialtime.upper = t0;
% tf free
bounds.phase(iphase).finaltime.lower = tfmin; 
bounds.phase(iphase).finaltime.upper = tfmax;
% initial positions and velocities fixed
bounds.phase(iphase).initialstate.lower = [CHA_r0,CHA_v0,m0];
bounds.phase(iphase).initialstate.upper = [CHA_r0,CHA_v0,m0];
bounds.phase(iphase).state.lower = [CHA_rmin,CHA_vmin,mmin];
bounds.phase(iphase).state.upper = [CHA_rmax,CHA_vmax,mmax];
% final positions and velocities free
bounds.phase(iphase).finalstate.lower = [CHA_rmin,CHA_vmin,mmin];
bounds.phase(iphase).finalstate.upper = [CHA_rmax,CHA_vmax,mmax];
bounds.phase(iphase).control.lower = [umin]; 
bounds.phase(iphase).control.upper = [umax];
bounds.phase(iphase).integral.lower = -100;
bounds.phase(iphase).integral.upper = 100;
bounds.eventgroup(1).lower = [0,0,0];
bounds.eventgroup(1).upper = [0,0,0];
bounds.phase(iphase).path.lower  = [1];
bounds.phase(iphase).path.upper  = [1];
guess.phase(iphase).time    = [t0; tfmax/5]; 
guess.phase(iphase).state   = [[CHA_x0; CHA_xf],[CHA_y0; CHA_yf],[CHA_z0; CHA_zf],...
    [CHA_vx0; CHA_vx0],[CHA_vy0; CHA_vy0],[CHA_vz0;CHA_vz0],[m0;mmin]];
guess.phase(iphase).control = [[1;1],[0;0],[0;0]];
guess.phase(iphase).integral = [50];

%-------------------------------------------------------------------------%
%----------------------Phase 2: Chaser drop off TAR1----------------------%
%-------------------------------------------------------------------------%
iphase = 2;
% initial time of phase should equal end time of phase 1
bounds.phase(iphase).initialtime.lower = tfmin; 
bounds.phase(iphase).initialtime.upper = tfmax;
% tf free
bounds.phase(iphase).finaltime.lower = tfmin; 
bounds.phase(iphase).finaltime.upper = tfmax;
% initial positions and velocities constrained to that of phase 1
bounds.phase(iphase).initialstate.lower = [CHA_rmin,CHA_vmin,mmin];
bounds.phase(iphase).initialstate.upper = [CHA_rmax,CHA_vmax,mmax];
bounds.phase(iphase).state.lower = [CHA_rmin,CHA_vmin,mmin];
bounds.phase(iphase).state.upper = [CHA_rmax,CHA_vmax,mmax];
% final positions and velocities free
bounds.phase(iphase).finalstate.lower = [CHA_rmin,CHA_vmin,mmin];
bounds.phase(iphase).finalstate.upper = [CHA_rmax,CHA_vmax,mmax];
bounds.phase(iphase).control.lower = [umin]; 
bounds.phase(iphase).control.upper = [umax];
bounds.phase(iphase).integral.lower = -100;
bounds.phase(iphase).integral.upper = 100;

bounds.eventgroup(2).lower = [0*ones(1,6),TAR1Mass,0];
bounds.eventgroup(2).upper = [0*ones(1,6),TAR1Mass,0];
bounds.eventgroup(3).lower = [0*ones(1,3)];
bounds.eventgroup(3).upper = [0*ones(1,3)];

bounds.phase(iphase).path.lower  = [1];
bounds.phase(iphase).path.upper  = [1];

guess.phase(iphase).time    = [t0; tfmax/5]; 
guess.phase(iphase).state   = [[CHA_xf; CHA_x0],[CHA_yf; CHA_y0],[CHA_zf; CHA_z0],...
    [CHA_vx0; CHA_vx0],[CHA_vy0; CHA_vy0],[CHA_vz0;CHA_vz0],[m0;m0]];
guess.phase(iphase).control = [[1;1],[0;0],[0;0]];
guess.phase(iphase).integral = [50];

% need eventgroup to enforce continuity

%-------------------------------------------------------------------------%
%----------Provide Mesh Refinement Method and Initial Mesh ---------------%
%-------------------------------------------------------------------------%
mesh.tolerance    = 1e-6;
mesh.maxiterations = 80;
mesh.colpointsmin = 4;
mesh.colpointsmax = 50;

%-------------------------------------------------------------------------%
%------------- Assemble Information into Problem Structure ---------------%        
%-------------------------------------------------------------------------%
setup.name                        = 'debrisPickup-Problem';
setup.functions.continuous        = @debrisPickupContinuous;
setup.functions.endpoint          = @debrisPickupEndpoint;
setup.bounds                      = bounds;
setup.auxdata                     = auxdata;
setup.guess                       = guess;
setup.mesh                        = mesh; 
setup.nlp.solver                  = 'ipopt';
setup.derivatives.supplier        = 'sparseFD';
setup.derivatives.derivativelevel = 'second';
setup.method                      = 'RPM-Differentiation';
setup.mesh.method                 = 'hp-PattersonRao';
setup.scales.method               = 'automatic-bounds';

%-------------------------------------------------------------------------%
%------------------------- Solve Problem Using GPOP2 ---------------------%
%-------------------------------------------------------------------------%
output   = gpops2(setup);
solution = output.result.solution;