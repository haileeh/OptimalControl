%---------------------------------------------%
% BEGIN: function debrisPickupContinuous.m %
%---------------------------------------------%
function phaseout = debrisPickupContinuous(input)

m_temp            = 50;  %[kg]
thrusterForce     = input.auxdata.thrusterForce;
g0                = input.auxdata.g0;
Isp               = input.auxdata.Isp;
mu                = input.auxdata.mu;

t                 = input.phase.time;
CHA_r             = input.phase.state(:,1:3);
CHA_v             = input.phase.state(:,4:6);
m                 = input.phase.state(:,7);

u                 = input.phase.control;

CHA_rdot          = CHA_v;

mdot              = -thrusterForce*ones(size(t))/(g0*Isp);
r_mag             = sqrt(sum(CHA_r.*CHA_r,2));
grav              = (-1./r_mag.^3).*CHA_r;%(-mu./r_mag.^3).*CHA_r;
thrust            = thrusterForce.*u./m; 
CHA_vdot          = thrust+grav;
phaseout.dynamics = [CHA_rdot,CHA_vdot,mdot];

phaseout.integrand = ones(length(input.phase.time),1);
phaseout.path = [sum(u.*u,2)];
%---------------------------------------------%
% END: function debrisPickupContinuous.m   %
%---------------------------------------------%