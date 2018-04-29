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
thrusterForce       = 100; %[N]
initialMass         = 1088; %[kg], mass of ASTRO (orbital express); mp = 136kg
g0                  = 9.80665; %[m/s^2]
Isp                 = 400; %[s], chemical bipropellant


% Time
t0 = 0;
tfmin = 0; tfmax = 1000;
%%%% Chaser - circular orbit with no inclination %%%%
% initialize position
CHA_x0 = 300; %[km]
CHA_y0 = 180; %[km]
CHA_z0 = 0;   %[km]
CHA_r0 = [CHA_x0, CHA_y0, CHA_z0];
CHA_rmag = sqrt(CHA_x0^2 + CHA_y0^2 + CHA_z0^2); %[km]
% initialize velocity
CHA_vmag = sqrt(mu/CHA_rmag); %[km/s]
CHA_vx0 = 0; %CHA_vmag*(CHA_x0/CHA_rmag);
CHA_vy0 = 0; %CHA_vmag*(CHA_y0/CHA_rmag);
CHA_vz0 = 0; %CHA_vmag*(CHA_z0/CHA_rmag);
CHA_v0 = [CHA_vx0,CHA_vy0,CHA_vz0];
CHA_rmin = -50*ones(1,3); CHA_rmax = 1000*ones(1,3);
CHA_vmin = -50*ones(1,3); CHA_vmax = 100*ones(1,3); 
% Chaser mass
m0 = initialMass;
mmax = initialMass;
mmin = 1;


%%%% Target 1 - circular orbit %%%%
% initial position
TAR1_x0 = 195;  %[km]
TAR1_y0 = 350;  %[km]
TAR1_z0 = 0;  %[km]
TAR1_r0 = sqrt(TAR1_x0^2 + TAR1_y0^2 + TAR1_z0^2); %[km]
% initial velocity
TAR1_v0 = sqrt(mu/TAR1_r0); %[km/s]
TAR1_vx0 = TAR1_v0*(TAR1_x0/TAR1_r0);
TAR1_vy0 = TAR1_v0*(TAR1_y0/TAR1_r0);
TAR1_vz0 = TAR1_v0*(TAR1_z0/TAR1_r0);

CHA_xf = TAR1_x0; CHA_yf = TAR1_y0; CHA_zf = TAR1_z0; 
% Control (for Chaser)
umin = -10*ones(1,3); 
umax = 10*ones(1,3); 

% Auxiliary Data
auxdata.thrusterForce   = thrusterForce;
auxdata.g0              = g0;
auxdata.Isp             = Isp;
auxdata.mu              = mu;

%-------------------------------------------------------------------------%
%----------------------- Setup for Problem Bounds ------------------------%
%-------------------------------------------------------------------------%
% t0 fixed
bounds.phase.initialtime.lower = t0; 
bounds.phase.initialtime.upper = t0;
% tf free
bounds.phase.finaltime.lower = tfmin; 
bounds.phase.finaltime.upper = tfmax;
% initial positions and velocities fixed
bounds.phase.initialstate.lower = [CHA_r0,CHA_v0,m0];
bounds.phase.initialstate.upper = [CHA_r0,CHA_v0,m0];
bounds.phase.state.lower = [CHA_rmin,CHA_vmin,mmin];
bounds.phase.state.upper = [CHA_rmax,CHA_vmax,mmax];
% final positions and velocities free
bounds.phase.finalstate.lower = [CHA_rmin,CHA_vmin,mmin];
bounds.phase.finalstate.upper = [CHA_rmax,CHA_vmax,mmax];
bounds.phase.control.lower = [umin]; 
bounds.phase.control.upper = [umax];
bounds.phase.integral.lower = -100;
bounds.phase.integral.upper = 100;
bounds.eventgroup.lower = [0,0,0];
bounds.eventgroup.upper = [0,0,0];
bounds.phase.path.lower  = [1];
bounds.phase.path.upper  = [1];

%-------------------------------------------------------------------------%
%---------------------- Provide Guess of Solution ------------------------%
%-------------------------------------------------------------------------%
guess.phase.time    = [t0; tfmax/5]; 
guess.phase.state   = [[CHA_x0; CHA_xf],[CHA_y0; CHA_yf],[CHA_z0; CHA_zf],...
    [CHA_vx0; CHA_vx0],[CHA_vy0; CHA_vy0],[CHA_vz0;CHA_vz0],[m0;mmin]];
guess.phase.control = [[1;1],[0;0],[0;0]];
guess.phase.integral = [50];

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