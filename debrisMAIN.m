%---------------------------------------------------%
% Debris Pickup Problem                             %
%---------------------------------------------------%
% The problem solved here is given as follows:      %
%   Minimize J = int 1 dt - m(tf)                   % 
% subject to the dynamic constraints                %
%     rdot(t) = v(t)                                %
%     vdot(t) = T_f*u/m - mu/rmag^3*r               %
% and the control constraints are                   %
%    ||u(t)|| <= 1                                  %
% and the boundary conditions                       %
%    r(t0) = r0, v(t0) = v0                         %
%    r(t1) = TAR1_r, v(t1) = 0.1 km/s               %
%    r(t2) = r0, v(t2) = free                       %
%---------------------------------------------------%

clear all; close all; clc
n = 1; %1 = km; 1000 = m;
% Constants
earthRadius         = 6378.1*n; % [km]
if n==1
    mu              = 398601; %[km^3/s^2] 
else
    mu              = 3.986012e14; %[m^3/s^2]
end

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
CHA_x0 = 6600*n; %[km]
CHA_y0 = -300*n; %[km]
CHA_z0 = 0*n;   %[km]
CHA_r0 = [CHA_x0, CHA_y0, CHA_z0];
CHA_rmag = sqrt(CHA_x0^2 + CHA_y0^2 + CHA_z0^2); %[km]
% initialize velocity
CHA_vmag = sqrt((mu)/CHA_rmag); %[km/s]
CHA_vx0 = CHA_vmag*(CHA_x0/CHA_rmag);
CHA_vy0 = CHA_vmag*(CHA_y0/CHA_rmag);
CHA_vz0 = CHA_vmag*(CHA_z0/CHA_rmag);
CHA_v0 = [CHA_vx0,CHA_vy0,CHA_vz0];

% Chaser position and velocity bounds
CHA_rmin = -2*earthRadius*ones(1,3); CHA_rmax = -CHA_rmin;
CHA_vmin = -10*n*ones(1,3); CHA_vmax = -CHA_vmin;
CHA_vfixed_max = 0.1*ones(1,3); CHA_vfixed_min = -0.1*ones(1,3); 
CHA_vfixed = 0.1*ones(1,3);

% Chaser mass bounds
m0 = initialMass;
mmax = 2*initialMass;
mmin = 0.1;

%%%% Target 1 - HETE-2 %%%%
% initial position from Earth's center?
TAR1_x0 = 6916*n;  %[km]
TAR1_y0 = -325*n;  %[km]
TAR1_z0 = 53*n;  %[km]
TAR1_rmag = sqrt(TAR1_x0^2 + TAR1_y0^2 + TAR1_z0^2); %[km]
TAR1_r0 = [TAR1_x0, TAR1_y0, TAR1_z0];
TAR1_vx0 = 0.37; %[km/s]
TAR1_vy0 = 7.575; %[km/s]
TAR1_vz0 = -0.251; %[km/s]
TAR1_v0 = [TAR1_vx0, TAR1_vy0, TAR1_z0];
% Time history
TAR1_t = [15, 30, 45, 60, 75, 90];
TAR1_r = [6921, -212, 50; 6924, -98, 46; 6925, 16, 42; 6924, 130, 38;...
    6921, 243, 34; 6917, 357, 31];

%%%%% COULD PROPAGATE USING LOOKUP TABLE WITH VALUES FROM SGP4!

CHA_xf = TAR1_x0; CHA_yf = TAR1_y0; CHA_zf = TAR1_z0; 

%%%% Target 2 - Pegasus 3rd stage %%%%
TAR2_x0 = 6080*n; %[km]
TAR2_y0 = -3261*n; %[km]
TAR2_z0 = -202*n; %[km]

%%%% Target 3 - AGILE %%%%
TAR3_x0 = 5993*n; %[km]
TAR3_y0 = -3311*n; %[km]
TAR3_z0 = 52*n; %[km]

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
auxdata.TAR2_x          = TAR2_x0; 
auxdata.TAR2_y          = TAR2_y0; 
auxdata.TAR2_z          = TAR2_z0;
auxdata.TAR1Mass        = TAR1Mass;
auxdata.TAR1_t          = TAR1_t;
auxdata.TAR1_r          = TAR1_r;

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
bounds.phase(iphase).state.lower = [CHA_rmin,CHA_vmin,m0/2];
bounds.phase(iphase).state.upper = [CHA_rmax,CHA_vmax,mmax];
% final positions and velocities free
bounds.phase(iphase).finalstate.lower = [CHA_rmin,CHA_vfixed_min,m0/2];
bounds.phase(iphase).finalstate.upper = [CHA_rmax,CHA_vfixed_max,mmax];
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
    [CHA_vx0; CHA_vx0],[CHA_vy0; CHA_vy0],[CHA_vz0;CHA_vz0],[m0;0.75*m0]];
guess.phase(iphase).control = [[-1;-1],[0;0],[0;0]];
guess.phase(iphase).integral = [60];

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

guess.phase(iphase).time    = [t0; tfmax/10]; 
guess.phase(iphase).state   = [[CHA_xf; CHA_x0],[CHA_yf; CHA_y0],[CHA_zf; CHA_z0],...
    [CHA_vx0; CHA_vx0],[CHA_vy0; CHA_vy0],[CHA_vz0;CHA_vz0],[m0+TAR1Mass;m0]];
guess.phase(iphase).control = [[-1;-1],[0;0],[0;0]];
guess.phase(iphase).integral = [60];

%-------------------------------------------------------------------------%
%----------------------Phase 3: Chaser pick up TAR2-----------------------%
%-------------------------------------------------------------------------%
iphase = 3;
% initial time of phase should equal end time of phase 2s
bounds.phase(iphase).initialtime.lower = tfmin; 
bounds.phase(iphase).initialtime.upper = tfmax;
% tf free
bounds.phase(iphase).finaltime.lower = tfmin; 
bounds.phase(iphase).finaltime.upper = tfmax;
% initial positions and velocities constrained to that of phase 2
bounds.phase(iphase).initialstate.lower = [CHA_rmin,CHA_vmin,mmin];
bounds.phase(iphase).initialstate.upper = [CHA_rmax,CHA_vmax,mmax];
bounds.phase(iphase).state.lower = [CHA_rmin,CHA_vmin,mmin];
bounds.phase(iphase).state.upper = [CHA_rmax,CHA_vmax,mmax];
% final positions and velocities free
bounds.phase(iphase).finalstate.lower = [CHA_rmin,CHA_vfixed_min,mmin];
bounds.phase(iphase).finalstate.upper = [CHA_rmax,CHA_vfixed_max,mmax];
bounds.phase(iphase).control.lower = [umin]; 
bounds.phase(iphase).control.upper = [umax];
bounds.phase(iphase).integral.lower = -1000;
bounds.phase(iphase).integral.upper = 1000;

% what's the mass req now?
bounds.eventgroup(4).lower = [0*ones(1,6),-TAR1Mass,0];
bounds.eventgroup(4).upper = [0*ones(1,6),-TAR1Mass,0];
bounds.eventgroup(5).lower = [0*ones(1,3)];
bounds.eventgroup(5).upper = [0*ones(1,3)];

bounds.phase(iphase).path.lower  = [1];
bounds.phase(iphase).path.upper  = [1];

guess.phase(iphase).time    = [tfmax/20; tfmax/10]; 
guess.phase(iphase).state   = [[CHA_x0; TAR2_x0],[CHA_y0; TAR2_y0],[CHA_z0; TAR2_z0],...
    [CHA_vx0; CHA_vfixed_max(1)],[CHA_vy0; CHA_vfixed_max(1)],[CHA_vz0;CHA_vfixed_max(1)],[m0;m0]];
guess.phase(iphase).control = [[-1;-1],[0;0],[0;0]];
guess.phase(iphase).integral = [60];

%-------------------------------------------------------------------------%
%----------Provide Mesh Refinement Method and Initial Mesh ---------------%
%-----------------------------------------------------------------------x--%
mesh.tolerance    = 1e-6;
mesh.maxiterations = 40;
mesh.colpointsmin = 4;
mesh.colpointsmax = 50;
for i=1:3
  meshphase(i).colpoints = 4*ones(1,10);
  meshphase(i).fraction = 0.1*ones(1,10);
end

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
setup.mesh.phase                  = meshphase;
setup.nlp.solver                  = 'ipopt';
setup.derivatives.supplier        = 'adigator'; %'sparseCD'; %sparceCD finds optimal, sparceFD only finds acceptable level
setup.derivatives.derivativelevel = 'second';
setup.derivatives.dependencies    = 'sparseNaN';
setup.method                      = 'RPM-Differentiation';
setup.mesh.method                 = 'hp-PattersonRao';
% might need to change below
setup.scales.method               = 'automatic-bounds';

if 1
    scales.method = 'defined';
    scales.objscale = 1;
    
    for i=1:2
        scales.phase(i).statescale = 2*[3.9197e-05 3.9197e-05 3.9197e-05 0.0500 0.0500 0.0500 6.1275e-04];
        scales.phase(i).stateshift = [0 0 0 0 0 0 -0.8333];
        scales.phase(i).controlscale = [0.0500 0.0500 0.0500];
        scales.phase(i).controlshift = [0 0 0];
        scales.phase(i).t0scale = 1.0000e-03;
        scales.phase(i).t0shift = -0.5;
        scales.phase(i).tfscale = 1.0000e-03;
        scales.phase(i).tfshift = -0.5;
        scales.phase(i).integralscale = 0.005;
        scales.phase(i).integralshift = 0;
        scales.phase(i).integrandconscale = 0.005;
        scales.phase(i).dynamicsconscale = [3.9197e-05 3.9197e-05 3.9197e-05 0.0500 0.0500 0.0500 6.1275e-04];
        scales.phase(i).pathconscale = 0.0513;
    end
    
    for i=3
        scales.phase(i).statescale = 6*[3.9197e-05 3.9197e-05 3.9197e-05 0.0500 0.0500 0.0500 6.1275e-04]; %4.5958e-04
        scales.phase(i).stateshift = [0 0 0 0 0 0 -0.8333]; %-0.5
        scales.phase(i).controlscale = [0.0500 0.0500 0.0500];
        scales.phase(i).controlshift = [0 0 0];
        scales.phase(i).t0scale = 1.0000e-03;
        scales.phase(i).t0shift = -0.5;
        scales.phase(i).tfscale = 1.0000e-03;
        scales.phase(i).tfshift = -0.5;
        scales.phase(i).integralscale = 0.005;
        scales.phase(i).integralshift = 0;
        scales.phase(i).integrandconscale = 0.005;
        scales.phase(i).dynamicsconscale = 0.25*[3.9197e-05 3.9197e-05 3.9197e-05 0.0500 0.0500 0.0500 6.1275e-04]; %4.5958e-04
        scales.phase(i).pathconscale = 0.0513; %0.0545
    end
    
    scales.eventgroup(1).eventconscale = [1 1 1];
    scales.eventgroup(2).eventconscale = [0.7071 0.7071 0.7071 0.7071 0.7071 0.7071 0.7071 0.7071];
    scales.eventgroup(3).eventconscale = [0.7071 0.7071 0.7071];
    scales.eventgroup(4).eventconscale = [0.7071 0.7071 0.7071 0.7071 0.7071 0.7071 0.7071 0.7071];
    scales.eventgroup(5).eventconscale = [0.7071 0.7071 0.7071]; %[1 1.0000 1.0000];
    
    setup.scales = scales;
end
    

%-------------------------------------------------------------------------%
%------------------------- Solve Problem Using GPOP2 ---------------------%
%-------------------------------------------------------------------------%
output   = gpops2(setup);
solution = output.result.solution;