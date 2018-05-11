%---------------------------------------------%
% BEGIN: function debrisPickupContinuous.m %
%---------------------------------------------%
function phaseout = debrisPickupContinuous(input)

thrusterForce = input.auxdata.thrusterForce;
g0 = input.auxdata.g0;
Isp = input.auxdata.Isp;
mu = input.auxdata.mu;

%%% Phase 1
iphase = 1;
t = input.phase(iphase).time;
CHA_r = input.phase(iphase).state(:,1:3);
CHA_v = input.phase(iphase).state(:,4:6);
m = input.phase(iphase).state(:,7);

u1 = input.phase(iphase).control;

CHA_rdot = CHA_v;

mdot = -thrusterForce*ones(size(t))/(g0*Isp);
r_mag = sqrt(sum(CHA_r.*CHA_r,2));
% grav = (-mu./r_mag.^(3)).*CHA_r;
% thrust = thrusterForce.*u1./m; 
for i = 1:3
    grav(:,i) = (-mu./r_mag.^(3)).*CHA_r(:,i);
    thrust(:,i) = thrusterForce*u1(:,i)./m;
end
CHA_vdot = thrust+grav;
phaseout(iphase).dynamics = [CHA_rdot,CHA_vdot,mdot];

phaseout(iphase).integrand = ones(length(input.phase(iphase).time),1);
phaseout(iphase).path = [sum(u1.*u1,2)];

%%%% Phase 2
iphase = 2;
t2 = input.phase(iphase).time;
CHA_r2 = input.phase(iphase).state(:,1:3);
CHA_v2 = input.phase(iphase).state(:,4:6);
m2 = input.phase(iphase).state(:,7);
u2 = input.phase(iphase).control;

CHA_rdot2 = CHA_v2;

mdot2 = -thrusterForce*ones(size(t2))/(g0*Isp);
r_mag2 = sqrt(sum(CHA_r2.*CHA_r2,2));
%grav2 = (-mu./r_mag2.^3).*CHA_r2;%(-mu./r_mag.^3).*CHA_r;
%thrust2 = thrusterForce.*u2./m2; 
for i = 1:3
    grav2(:,i) = (-mu./r_mag2.^(3)).*CHA_r2(:,i);
    thrust2(:,i) = thrusterForce*u2(:,i)./m2;
end
CHA_vdot2 = thrust2+grav2;
phaseout(iphase).dynamics = [CHA_rdot2,CHA_vdot2,mdot2];

phaseout(iphase).integrand = ones(length(input.phase(iphase).time),1);

phaseout(iphase).path = [sum(u2.*u2,2)];

%%%% Phase 3
iphase = 3;
t3 = input.phase(iphase).time;
CHA_r3 = input.phase(iphase).state(:,1:3);
CHA_v3 = input.phase(iphase).state(:,4:6);
m3 = input.phase(iphase).state(:,7);
u3 = input.phase(iphase).control;

CHA_rdot3 = CHA_v3;

mdot3 = -thrusterForce*ones(size(t3))/(g0*Isp);
r_mag3 = sqrt(sum(CHA_r3.*CHA_r3,2));
%grav3 = (-mu./r_mag3.^3).*CHA_r3;%(-mu./r_mag.^3).*CHA_r;
%thrust3 = thrusterForce.*u3./m3; 
for i = 1:3
    grav3(:,i) = (-mu./r_mag3.^(3)).*CHA_r3(:,i);
    thrust3(:,i) = thrusterForce*u3(:,i)./m3;
end
CHA_vdot3 = thrust3+grav3;
phaseout(iphase).dynamics = [CHA_rdot3,CHA_vdot3,mdot3];

phaseout(iphase).integrand = ones(length(input.phase(iphase).time),1);

phaseout(iphase).path = [sum(u3.*u3,2)];
%---------------------------------------------%
% END: function debrisPickupContinuous.m %
%---------------------------------------------%