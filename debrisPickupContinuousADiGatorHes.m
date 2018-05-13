% This code was generated using ADiGator version 1.4
% �2010-2014 Matthew J. Weinstein and Anil V. Rao
% ADiGator may be obtained at https://sourceforge.net/projects/adigator/ 
% Contact: mweinstein@ufl.edu
% Bugs/suggestions may be reported to the sourceforge forums
%                    DISCLAIMER
% ADiGator is a general-purpose software distributed under the GNU General
% Public License version 3.0. While the software is distributed with the
% hope that it will be useful, both the software and generated code are
% provided 'AS IS' with NO WARRANTIES OF ANY KIND and no merchantability
% or fitness for any purpose or application.

function phaseout = debrisPickupContinuousADiGatorHes(input)
global ADiGator_debrisPickupContinuousADiGatorHes
if isempty(ADiGator_debrisPickupContinuousADiGatorHes); ADiGator_LoadData(); end
Gator1Data = ADiGator_debrisPickupContinuousADiGatorHes.debrisPickupContinuousADiGatorHes.Gator1Data;
Gator2Data = ADiGator_debrisPickupContinuousADiGatorHes.debrisPickupContinuousADiGatorHes.Gator2Data;
% ADiGator Start Derivative Computations
thrusterForce = input.auxdata.thrusterForce;
%User Line: thrusterForce = input.auxdata.thrusterForce;
g0 = input.auxdata.g0;
%User Line: g0 = input.auxdata.g0;
Isp = input.auxdata.Isp;
%User Line: Isp = input.auxdata.Isp;
mu = input.auxdata.mu;
%User Line: mu = input.auxdata.mu;
%User Line: %%% Phase 1
iphase.f = 1;
%User Line: iphase = 1;
t.dV = input.phase(iphase.f).time.dV;
t.f = input.phase(iphase.f).time.f;
%User Line: t = input.phase(iphase).time;
CHA_r.dV = input.phase(iphase.f).state.dV(:,Gator1Data.Index14);
CHA_r.f = input.phase(iphase.f).state.f(:,Gator1Data.Index13);
%User Line: CHA_r = input.phase(iphase).state(:,1:3);
CHA_v.dV = input.phase(iphase.f).state.dV(:,Gator1Data.Index16);
CHA_v.f = input.phase(iphase.f).state.f(:,Gator1Data.Index15);
%User Line: CHA_v = input.phase(iphase).state(:,4:6);
m.dV = input.phase(iphase.f).state.dV(:,7);
m.f = input.phase(iphase.f).state.f(:,7);
%User Line: m = input.phase(iphase).state(:,7);
u1.dV = input.phase(iphase.f).control.dV;
u1.f = input.phase(iphase.f).control.f;
%User Line: u1 = input.phase(iphase).control;
CHA_rdot.dV = CHA_v.dV;
CHA_rdot.f = CHA_v.f;
%User Line: CHA_rdot = CHA_v;
cada1f1 = uminus(thrusterForce);
cada1f2 = size(t.f);
cada1f3 = ones(cada1f2);
cada1f4 = cada1f1*cada1f3;
cada1f5 = g0*Isp;
mdot.f = cada1f4/cada1f5;
%User Line: mdot = -thrusterForce*ones(size(t))/(g0*Isp);
cada1td1dV = CHA_r.dV.*CHA_r.dV;
cada1td1 = CHA_r.f.*CHA_r.dV;
cada2f1dV = CHA_r.dV.*CHA_r.dV;
cada2f1 = CHA_r.f.*CHA_r.dV;
cada2td1 = cada1td1dV;
cada2td1 = cada2td1 + cada2f1dV;
cada1td1dV = cada2td1;
cada1td1 = cada1td1 + cada2f1;
cada1f1dVdV = cada1td1dV; cada1f1dV = cada1td1;
cada1f1 = CHA_r.f.*CHA_r.f;
cada1tf2 =  ones(3,1);
cada1tf1 =  zeros(3,3);
cada2f1 = cada1tf2(Gator1Data.Index17);
cada1tf1(Gator1Data.Index18) = cada2f1;
cada2tf1 = zeros(3,3);
cada2tf1(Gator2Data.Index35) = cada1tf1(Gator2Data.Index34);
cada1f2dVdV = cada1f1dVdV*cada2tf1;
cada1f2dV = cada1f1dV*cada1tf1;
cada1f2 = sum(cada1f1,2);
cada1tf1dV = cada1f2dV(:,Gator2Data.Index36);
cada1tf1 = cada1f2(:,Gator1Data.Index19);
cada2tf1 = cada1tf1(:,Gator2Data.Index37);
cada2f1dV = (1/2)./sqrt(cada2tf1).*cada1tf1dV;
cada2f1dV(cada2tf1 == 0 & cada1tf1dV == 0) = 0;
cada2f1 = sqrt(cada1tf1);
cada2tf2 = cada2f1(:,Gator2Data.Index38);
cada2f2dV = -0.5./cada2tf2.^2.*cada2f1dV;
cada2f2 = 0.5./cada2f1;
cada2tf1 = cada1f2dV(:,Gator2Data.Index39);
cada2td1 = cada2tf1.*cada2f2dV;
cada2td1(:,Gator2Data.Index40) = cada2td1(:,Gator2Data.Index40) + cada2f2.*cada1f2dVdV;
r_mag.dVdV = cada2td1;
r_mag.dV = cada2f2.*cada1f2dV;
cada2f1 = eq(cada1tf1,0);
cada2f2 = eq(cada1f2dV,0);
cada2f3 = and(cada2f1,cada2f2);
cada2td2 = r_mag.dVdV;
cada2tind1 = cada2f3(:,Gator2Data.Index41);
cada2td2(cada2tind1) = 0;
r_mag.dVdV = cada2td2;
r_mag.dV(cada2f3) = 0;
r_mag.f = sqrt(cada1f2);
%User Line: r_mag = sqrt(sum(CHA_r.*CHA_r,2));
%User Line: % grav = (-mu./r_mag.^(3)).*CHA_r;
%User Line: % thrust = thrusterForce.*u1./m;
cadaforvar1.f = [1 2 3];
%User Line: cadaforvar1 = 1:3;
grav.dV = zeros(0,9);
grav.f = zeros(0,3);
thrust.dV = zeros(0,6);
thrust.f = zeros(0,3);
grav.dVdV = zeros(size(grav.dV,1),27);
thrust.dVdV = zeros(size(thrust.dV,1),9);
for cadaforcount1 = 1:3
    i.f = cadaforvar1.f(:,cadaforcount1);
    %User Line: i = cadaforvar1(:,cadaforcount1);
    cada1f1 = uminus(mu);
    cada1tf2dV = r_mag.dV(:,Gator2Data.Index1);
    cada1tf2 = r_mag.f(:,Gator1Data.Index20);
    cada2tf2 = cada1tf2(:,Gator2Data.Index42);
    cada2f1dV = 2.*cada2tf2.^(2-1).*cada1tf2dV;
    cada2f1 = cada1tf2.^2;
    cada2f2dV = 3.*cada2f1dV;
    cada2f2 = 3*cada2f1;
    cada2tf1 = r_mag.dV(:,Gator2Data.Index43);
    cada2td1 = cada2tf1.*cada2f2dV;
    cada2tf1 = cada2f2(:,Gator2Data.Index44);
    cada2td1 = cada2td1 + cada2tf1.*r_mag.dVdV;
    cada1f2dVdV = cada2td1;
    cada1f2dV = cada2f2.*r_mag.dV;
    cada1f2 = r_mag.f.^3;
    cada1tf2dV = cada1f2dV(:,Gator2Data.Index2);
    cada1tf2 = cada1f2(:,Gator1Data.Index21);
    cada2f1 = uminus(cada1f1);
    cada2tf2 = cada1tf2(:,Gator2Data.Index45);
    cada2f2dV = 2.*cada2tf2.^(2-1).*cada1tf2dV;
    cada2f2 = cada1tf2.^2;
    cada2tf2 = cada2f2(:,Gator2Data.Index46);
    cada2f3dV = -cada2f1./cada2tf2.^2.*cada2f2dV;
    cada2f3 = cada2f1./cada2f2;
    cada2tf1 = cada1f2dV(:,Gator2Data.Index47);
    cada2td1 = cada2tf1.*cada2f3dV;
    cada2tf1 = cada2f3(:,Gator2Data.Index48);
    cada2td1 = cada2td1 + cada2tf1.*cada1f2dVdV;
    cada1f3dVdV = cada2td1;
    cada1f3dV = cada2f3.*cada1f2dV;
    cada1f3 = cada1f1./cada1f2;
    cada2f1 = size(CHA_r.f,1);
    cada1td1 = zeros(cada2f1,3);
    cada2f1 = Gator1Data.Index1(:,cadaforcount1);
    cada2tempf1 = nonzeros(cada2f1);
    cada2f2 = zeros(1,1);
    cada2f2(1:length(cada2tempf1)) = cada2tempf1;
    cada2f3 = CHA_r.dV(:,cada2f2);
    cada2f4 = Gator1Data.Index1(:,cadaforcount1);
    cada2f5 = logical(cada2f4);
    cada1td1(:,cada2f5) = cada2f3;
    cada1f4dV = cada1td1;
    cada1f4 = CHA_r.f(:,i.f);
    cada1tf1dV = cada1f4dV(:,Gator2Data.Index3);
    cada1tf1 = cada1f4(:,Gator1Data.Index22);
    cada2tf1 = cada1f3dV(:,Gator2Data.Index49);
    cada2td1 = cada2tf1.*cada1tf1dV;
    cada2tf1 = cada1tf1(:,Gator2Data.Index50);
    cada2td1 = cada2td1 + cada2tf1.*cada1f3dVdV;
    cada1td1dV = cada2td1;
    cada1td1 = cada1tf1.*cada1f3dV;
    cada1tf1dV = cada1f3dV(:,Gator2Data.Index4);
    cada1tf1 = cada1f3(:,Gator1Data.Index23);
    cada2tf1 = cada1f4dV(:,Gator2Data.Index51);
    cada2f1dV = cada2tf1.*cada1tf1dV;
    cada2f1 = cada1tf1.*cada1f4dV;
    cada2td1 = cada1td1dV;
    cada2td1 = cada2td1 + cada2f1dV;
    cada1td1dV = cada2td1;
    cada1td1 = cada1td1 + cada2f1;
    cada1f5dVdV = cada1td1dV;     cada1f5dV = cada1td1;
    cada1f5 = cada1f3.*cada1f4;
    cada2f1 = size(cada1f5,1);
    cada1tf1 = 1:cada2f1;
    cada2f1 = Gator1Data.Index3(:,cadaforcount1);
    cada2f2 = logical(cada2f1);
    cada2f3 = Gator1Data.Index3(:,cadaforcount1);
    cada2tempf1 = nonzeros(cada2f3);
    cada2f4 = zeros(3,1);
    cada2f4(1:length(cada2tempf1)) = cada2tempf1;
    cada2f5dV = cada1f5dVdV(:,Gator2Data.Index5);
    cada2f5 = cada1f5dV(:,cada2f4);
    grav.dVdV(cada1tf1,logical(Gator2Data.Index8(:,cadaforcount1))) = cada2f5dV(:,nonzeros(Gator2Data.Index8(:,cadaforcount1)));
    grav.dV(cada1tf1,cada2f2) = cada2f5;
    grav.f(cada1tf1,i.f) = cada1f5;
    %User Line: grav(:,i) = (-mu./r_mag.^(3)).*CHA_r(:,i);
    cada2f1 = size(u1.f,1);
    cada1td1 = zeros(cada2f1,3);
    cada2f1 = Gator1Data.Index2(:,cadaforcount1);
    cada2tempf1 = nonzeros(cada2f1);
    cada2f2 = zeros(1,1);
    cada2f2(1:length(cada2tempf1)) = cada2tempf1;
    cada2f3 = u1.dV(:,cada2f2);
    cada2f4 = Gator1Data.Index2(:,cadaforcount1);
    cada2f5 = logical(cada2f4);
    cada1td1(:,cada2f5) = cada2f3;
    cada1f1dV = cada1td1;
    cada1f1 = u1.f(:,i.f);
    cada1f3dV = thrusterForce*cada1f1dV;
    cada1f3 = thrusterForce*cada1f1;
    cada1tf1dV = m.dV(:,Gator2Data.Index6);
    cada1tf1 = m.f(:,Gator1Data.Index24);
    cada2f1 = size(cada1f3dV,1);
    cada1td1 = zeros(cada2f1,4);
    cada1td1dV = zeros(size(cada1td1,1),7);
    cada2f1dV = -cada1f3dV./cada1tf1.^2.*cada1tf1dV;
    cada2f1 = cada1f3dV./cada1tf1;
    cada1td1dV(:,logical(Gator2Data.Index9)) = cada2f1dV(:,nonzeros(Gator2Data.Index9));
    cada1td1(:,Gator1Data.Index25) = cada2f1;
    cada2f1 = cada1td1(:,1);
    cada2f2dV = -cada1f3dV;
    cada2f2 = uminus(cada1f3);
    cada2f3dV = 2.*m.f.^(2-1).*m.dV;
    cada2f3 = m.f.^2;
    cada2tf1 = cada2f3(:,Gator2Data.Index52);
    cada2td1 = zeros(size(cada2f2dV,1),4);
    cada2td1(:,Gator2Data.Index53) = cada2f2dV./cada2tf1;
    cada2td1(:,1) = cada2td1(:,1) + -cada2f2./cada2f3.^2.*cada2f3dV;
    cada2f4dV = cada2td1;
    cada2f4 = cada2f2./cada2f3;
    cada2tf1 = m.dV(:,Gator2Data.Index54);
    cada2f5dV = cada2tf1.*cada2f4dV;
    cada2f5 = cada2f4.*m.dV;
    cada2f6dV = cada2f5dV;
    cada2f6 = cada2f1 + cada2f5;
    cada1td1dV(:,logical(Gator2Data.Index10)) = cada2f6dV(:,nonzeros(Gator2Data.Index10));
    cada1td1(:,1) = cada2f6;
    cada1f4dVdV = cada1td1dV;     cada1f4dV = cada1td1;
    cada1f4 = cada1f3./m.f;
    cada2f1 = size(cada1f4,1);
    cada1tf1 = 1:cada2f1;
    cada2f1 = Gator1Data.Index4(:,cadaforcount1);
    cada2f2 = logical(cada2f1);
    cada2f3 = Gator1Data.Index4(:,cadaforcount1);
    cada2tempf1 = nonzeros(cada2f3);
    cada2f4 = zeros(2,1);
    cada2f4(1:length(cada2tempf1)) = cada2tempf1;
    cada2f5dV = cada1f4dVdV(:,Gator2Data.Index7(:,cadaforcount1));
    cada2f5 = cada1f4dV(:,cada2f4);
    thrust.dVdV(cada1tf1,logical(Gator2Data.Index11(:,cadaforcount1))) = cada2f5dV(:,nonzeros(Gator2Data.Index11(:,cadaforcount1)));
    thrust.dV(cada1tf1,cada2f2) = cada2f5;
    thrust.f(cada1tf1,i.f) = cada1f4;
    %User Line: thrust(:,i) = thrusterForce*u1(:,i)./m;
end
cada2f1 = size(thrust.dV,1);
cada1td1 = zeros(cada2f1,15);
cada1td1dV = thrust.dVdV;
cada1td1(:,Gator1Data.Index26) = thrust.dV;
cada2f1 = cada1td1(:,Gator1Data.Index27);
cada2f2dV = grav.dVdV;
cada2f2 = cada2f1 + grav.dV;
cada2td1 = zeros(size(cada1td1,1),36);
cada2td1(:,Gator2Data.Index55) = cada2f2dV;
cada2td1(:,Gator2Data.Index56) = cada1td1dV(:,Gator2Data.Index57);
cada1td1dV = cada2td1;
cada1td1(:,Gator1Data.Index27) = cada2f2;
CHA_vdot.dVdV = cada1td1dV; CHA_vdot.dV = cada1td1;
CHA_vdot.f = thrust.f + grav.f;
%User Line: CHA_vdot = thrust+grav;
cada2f1 = size(CHA_rdot.f,1);
cada1td1 = zeros(cada2f1,18);
cada1td1(:,Gator1Data.Index28) = CHA_rdot.dV;
cada1td1dV = CHA_vdot.dVdV;
cada1td1(:,Gator1Data.Index29) = CHA_vdot.dV;
cada1f1dVdV = cada1td1dV; cada1f1dV = cada1td1;
cada1f1 = [CHA_rdot.f CHA_vdot.f mdot.f];
phaseout(iphase.f).dynamics.dVdV = cada1f1dVdV;
phaseout(iphase.f).dynamics.dV = cada1f1dV;
phaseout(iphase.f).dynamics.f = cada1f1;
%User Line: phaseout(iphase).dynamics = [CHA_rdot,CHA_vdot,mdot];
cada1f1 = input.phase(iphase.f).time.f;
cada1f2 = length(cada1f1);
cada1f3 = ones(cada1f2,1);
phaseout(iphase.f).integrand.f = cada1f3;
%User Line: phaseout(iphase).integrand = ones(length(input.phase(iphase).time),1);
cada1td1dV = u1.dV.*u1.dV;
cada1td1 = u1.f.*u1.dV;
cada2f1dV = u1.dV.*u1.dV;
cada2f1 = u1.f.*u1.dV;
cada2td1 = cada1td1dV;
cada2td1 = cada2td1 + cada2f1dV;
cada1td1dV = cada2td1;
cada1td1 = cada1td1 + cada2f1;
cada1f1dVdV = cada1td1dV; cada1f1dV = cada1td1;
cada1f1 = u1.f.*u1.f;
cada1tf2 =  ones(3,1);
cada1tf1 =  zeros(3,3);
cada2f1 = cada1tf2(Gator1Data.Index30);
cada1tf1(Gator1Data.Index31) = cada2f1;
cada2tf1 = zeros(3,3);
cada2tf1(Gator2Data.Index59) = cada1tf1(Gator2Data.Index58);
cada1f2dVdV = cada1f1dVdV*cada2tf1;
cada1f2dV = cada1f1dV*cada1tf1;
cada1f2 = sum(cada1f1,2);
phaseout(iphase.f).path.dVdV = cada1f2dVdV;
phaseout(iphase.f).path.dV = cada1f2dV;
phaseout(iphase.f).path.f = cada1f2;
%User Line: phaseout(iphase).path = [sum(u1.*u1,2)];
%User Line: %%%% Phase 2
iphase.f = 2;
%User Line: iphase = 2;
t2.dV = input.phase(iphase.f).time.dV;
t2.f = input.phase(iphase.f).time.f;
%User Line: t2 = input.phase(iphase).time;
CHA_r2.dV = input.phase(iphase.f).state.dV(:,Gator1Data.Index33);
CHA_r2.f = input.phase(iphase.f).state.f(:,Gator1Data.Index32);
%User Line: CHA_r2 = input.phase(iphase).state(:,1:3);
CHA_v2.dV = input.phase(iphase.f).state.dV(:,Gator1Data.Index35);
CHA_v2.f = input.phase(iphase.f).state.f(:,Gator1Data.Index34);
%User Line: CHA_v2 = input.phase(iphase).state(:,4:6);
m2.dV = input.phase(iphase.f).state.dV(:,7);
m2.f = input.phase(iphase.f).state.f(:,7);
%User Line: m2 = input.phase(iphase).state(:,7);
u2.dV = input.phase(iphase.f).control.dV;
u2.f = input.phase(iphase.f).control.f;
%User Line: u2 = input.phase(iphase).control;
CHA_rdot2.dV = CHA_v2.dV;
CHA_rdot2.f = CHA_v2.f;
%User Line: CHA_rdot2 = CHA_v2;
cada1f1 = uminus(thrusterForce);
cada1f2 = size(t2.f);
cada1f3 = ones(cada1f2);
cada1f4 = cada1f1*cada1f3;
cada1f5 = g0*Isp;
mdot2.f = cada1f4/cada1f5;
%User Line: mdot2 = -thrusterForce*ones(size(t2))/(g0*Isp);
cada1td1dV = CHA_r2.dV.*CHA_r2.dV;
cada1td1 = CHA_r2.f.*CHA_r2.dV;
cada2f1dV = CHA_r2.dV.*CHA_r2.dV;
cada2f1 = CHA_r2.f.*CHA_r2.dV;
cada2td1 = cada1td1dV;
cada2td1 = cada2td1 + cada2f1dV;
cada1td1dV = cada2td1;
cada1td1 = cada1td1 + cada2f1;
cada1f1dVdV = cada1td1dV; cada1f1dV = cada1td1;
cada1f1 = CHA_r2.f.*CHA_r2.f;
cada1tf2 =  ones(3,1);
cada1tf1 =  zeros(3,3);
cada2f1 = cada1tf2(Gator1Data.Index36);
cada1tf1(Gator1Data.Index37) = cada2f1;
cada2tf1 = zeros(3,3);
cada2tf1(Gator2Data.Index61) = cada1tf1(Gator2Data.Index60);
cada1f2dVdV = cada1f1dVdV*cada2tf1;
cada1f2dV = cada1f1dV*cada1tf1;
cada1f2 = sum(cada1f1,2);
cada1tf1dV = cada1f2dV(:,Gator2Data.Index62);
cada1tf1 = cada1f2(:,Gator1Data.Index38);
cada2tf1 = cada1tf1(:,Gator2Data.Index63);
cada2f1dV = (1/2)./sqrt(cada2tf1).*cada1tf1dV;
cada2f1dV(cada2tf1 == 0 & cada1tf1dV == 0) = 0;
cada2f1 = sqrt(cada1tf1);
cada2tf2 = cada2f1(:,Gator2Data.Index64);
cada2f2dV = -0.5./cada2tf2.^2.*cada2f1dV;
cada2f2 = 0.5./cada2f1;
cada2tf1 = cada1f2dV(:,Gator2Data.Index65);
cada2td1 = cada2tf1.*cada2f2dV;
cada2td1(:,Gator2Data.Index66) = cada2td1(:,Gator2Data.Index66) + cada2f2.*cada1f2dVdV;
r_mag2.dVdV = cada2td1;
r_mag2.dV = cada2f2.*cada1f2dV;
cada2f1 = eq(cada1tf1,0);
cada2f2 = eq(cada1f2dV,0);
cada2f3 = and(cada2f1,cada2f2);
cada2td2 = r_mag2.dVdV;
cada2tind1 = cada2f3(:,Gator2Data.Index67);
cada2td2(cada2tind1) = 0;
r_mag2.dVdV = cada2td2;
r_mag2.dV(cada2f3) = 0;
r_mag2.f = sqrt(cada1f2);
%User Line: r_mag2 = sqrt(sum(CHA_r2.*CHA_r2,2));
%User Line: %grav2 = (-mu./r_mag2.^3).*CHA_r2;%(-mu./r_mag.^3).*CHA_r;
%User Line: %thrust2 = thrusterForce.*u2./m2;
cadaforvar2.f = [1 2 3];
%User Line: cadaforvar2 = 1:3;
grav2.dV = zeros(0,9);
grav2.f = zeros(0,3);
thrust2.dV = zeros(0,6);
thrust2.f = zeros(0,3);
grav2.dVdV = zeros(size(grav2.dV,1),27);
thrust2.dVdV = zeros(size(thrust2.dV,1),9);
for cadaforcount2 = 1:3
    i.f = cadaforvar2.f(:,cadaforcount2);
    %User Line: i = cadaforvar2(:,cadaforcount2);
    cada1f1 = uminus(mu);
    cada1tf2dV = r_mag2.dV(:,Gator2Data.Index12);
    cada1tf2 = r_mag2.f(:,Gator1Data.Index39);
    cada2tf2 = cada1tf2(:,Gator2Data.Index68);
    cada2f1dV = 2.*cada2tf2.^(2-1).*cada1tf2dV;
    cada2f1 = cada1tf2.^2;
    cada2f2dV = 3.*cada2f1dV;
    cada2f2 = 3*cada2f1;
    cada2tf1 = r_mag2.dV(:,Gator2Data.Index69);
    cada2td1 = cada2tf1.*cada2f2dV;
    cada2tf1 = cada2f2(:,Gator2Data.Index70);
    cada2td1 = cada2td1 + cada2tf1.*r_mag2.dVdV;
    cada1f2dVdV = cada2td1;
    cada1f2dV = cada2f2.*r_mag2.dV;
    cada1f2 = r_mag2.f.^3;
    cada1tf2dV = cada1f2dV(:,Gator2Data.Index13);
    cada1tf2 = cada1f2(:,Gator1Data.Index40);
    cada2f1 = uminus(cada1f1);
    cada2tf2 = cada1tf2(:,Gator2Data.Index71);
    cada2f2dV = 2.*cada2tf2.^(2-1).*cada1tf2dV;
    cada2f2 = cada1tf2.^2;
    cada2tf2 = cada2f2(:,Gator2Data.Index72);
    cada2f3dV = -cada2f1./cada2tf2.^2.*cada2f2dV;
    cada2f3 = cada2f1./cada2f2;
    cada2tf1 = cada1f2dV(:,Gator2Data.Index73);
    cada2td1 = cada2tf1.*cada2f3dV;
    cada2tf1 = cada2f3(:,Gator2Data.Index74);
    cada2td1 = cada2td1 + cada2tf1.*cada1f2dVdV;
    cada1f3dVdV = cada2td1;
    cada1f3dV = cada2f3.*cada1f2dV;
    cada1f3 = cada1f1./cada1f2;
    cada2f1 = size(CHA_r2.f,1);
    cada1td1 = zeros(cada2f1,3);
    cada2f1 = Gator1Data.Index5(:,cadaforcount2);
    cada2tempf1 = nonzeros(cada2f1);
    cada2f2 = zeros(1,1);
    cada2f2(1:length(cada2tempf1)) = cada2tempf1;
    cada2f3 = CHA_r2.dV(:,cada2f2);
    cada2f4 = Gator1Data.Index5(:,cadaforcount2);
    cada2f5 = logical(cada2f4);
    cada1td1(:,cada2f5) = cada2f3;
    cada1f4dV = cada1td1;
    cada1f4 = CHA_r2.f(:,i.f);
    cada1tf1dV = cada1f4dV(:,Gator2Data.Index14);
    cada1tf1 = cada1f4(:,Gator1Data.Index41);
    cada2tf1 = cada1f3dV(:,Gator2Data.Index75);
    cada2td1 = cada2tf1.*cada1tf1dV;
    cada2tf1 = cada1tf1(:,Gator2Data.Index76);
    cada2td1 = cada2td1 + cada2tf1.*cada1f3dVdV;
    cada1td1dV = cada2td1;
    cada1td1 = cada1tf1.*cada1f3dV;
    cada1tf1dV = cada1f3dV(:,Gator2Data.Index15);
    cada1tf1 = cada1f3(:,Gator1Data.Index42);
    cada2tf1 = cada1f4dV(:,Gator2Data.Index77);
    cada2f1dV = cada2tf1.*cada1tf1dV;
    cada2f1 = cada1tf1.*cada1f4dV;
    cada2td1 = cada1td1dV;
    cada2td1 = cada2td1 + cada2f1dV;
    cada1td1dV = cada2td1;
    cada1td1 = cada1td1 + cada2f1;
    cada1f5dVdV = cada1td1dV;     cada1f5dV = cada1td1;
    cada1f5 = cada1f3.*cada1f4;
    cada2f1 = size(cada1f5,1);
    cada1tf1 = 1:cada2f1;
    cada2f1 = Gator1Data.Index7(:,cadaforcount2);
    cada2f2 = logical(cada2f1);
    cada2f3 = Gator1Data.Index7(:,cadaforcount2);
    cada2tempf1 = nonzeros(cada2f3);
    cada2f4 = zeros(3,1);
    cada2f4(1:length(cada2tempf1)) = cada2tempf1;
    cada2f5dV = cada1f5dVdV(:,Gator2Data.Index16);
    cada2f5 = cada1f5dV(:,cada2f4);
    grav2.dVdV(cada1tf1,logical(Gator2Data.Index19(:,cadaforcount2))) = cada2f5dV(:,nonzeros(Gator2Data.Index19(:,cadaforcount2)));
    grav2.dV(cada1tf1,cada2f2) = cada2f5;
    grav2.f(cada1tf1,i.f) = cada1f5;
    %User Line: grav2(:,i) = (-mu./r_mag2.^(3)).*CHA_r2(:,i);
    cada2f1 = size(u2.f,1);
    cada1td1 = zeros(cada2f1,3);
    cada2f1 = Gator1Data.Index6(:,cadaforcount2);
    cada2tempf1 = nonzeros(cada2f1);
    cada2f2 = zeros(1,1);
    cada2f2(1:length(cada2tempf1)) = cada2tempf1;
    cada2f3 = u2.dV(:,cada2f2);
    cada2f4 = Gator1Data.Index6(:,cadaforcount2);
    cada2f5 = logical(cada2f4);
    cada1td1(:,cada2f5) = cada2f3;
    cada1f1dV = cada1td1;
    cada1f1 = u2.f(:,i.f);
    cada1f3dV = thrusterForce*cada1f1dV;
    cada1f3 = thrusterForce*cada1f1;
    cada1tf1dV = m2.dV(:,Gator2Data.Index17);
    cada1tf1 = m2.f(:,Gator1Data.Index43);
    cada2f1 = size(cada1f3dV,1);
    cada1td1 = zeros(cada2f1,4);
    cada1td1dV = zeros(size(cada1td1,1),7);
    cada2f1dV = -cada1f3dV./cada1tf1.^2.*cada1tf1dV;
    cada2f1 = cada1f3dV./cada1tf1;
    cada1td1dV(:,logical(Gator2Data.Index20)) = cada2f1dV(:,nonzeros(Gator2Data.Index20));
    cada1td1(:,Gator1Data.Index44) = cada2f1;
    cada2f1 = cada1td1(:,1);
    cada2f2dV = -cada1f3dV;
    cada2f2 = uminus(cada1f3);
    cada2f3dV = 2.*m2.f.^(2-1).*m2.dV;
    cada2f3 = m2.f.^2;
    cada2tf1 = cada2f3(:,Gator2Data.Index78);
    cada2td1 = zeros(size(cada2f2dV,1),4);
    cada2td1(:,Gator2Data.Index79) = cada2f2dV./cada2tf1;
    cada2td1(:,1) = cada2td1(:,1) + -cada2f2./cada2f3.^2.*cada2f3dV;
    cada2f4dV = cada2td1;
    cada2f4 = cada2f2./cada2f3;
    cada2tf1 = m2.dV(:,Gator2Data.Index80);
    cada2f5dV = cada2tf1.*cada2f4dV;
    cada2f5 = cada2f4.*m2.dV;
    cada2f6dV = cada2f5dV;
    cada2f6 = cada2f1 + cada2f5;
    cada1td1dV(:,logical(Gator2Data.Index21)) = cada2f6dV(:,nonzeros(Gator2Data.Index21));
    cada1td1(:,1) = cada2f6;
    cada1f4dVdV = cada1td1dV;     cada1f4dV = cada1td1;
    cada1f4 = cada1f3./m2.f;
    cada2f1 = size(cada1f4,1);
    cada1tf1 = 1:cada2f1;
    cada2f1 = Gator1Data.Index8(:,cadaforcount2);
    cada2f2 = logical(cada2f1);
    cada2f3 = Gator1Data.Index8(:,cadaforcount2);
    cada2tempf1 = nonzeros(cada2f3);
    cada2f4 = zeros(2,1);
    cada2f4(1:length(cada2tempf1)) = cada2tempf1;
    cada2f5dV = cada1f4dVdV(:,Gator2Data.Index18(:,cadaforcount2));
    cada2f5 = cada1f4dV(:,cada2f4);
    thrust2.dVdV(cada1tf1,logical(Gator2Data.Index22(:,cadaforcount2))) = cada2f5dV(:,nonzeros(Gator2Data.Index22(:,cadaforcount2)));
    thrust2.dV(cada1tf1,cada2f2) = cada2f5;
    thrust2.f(cada1tf1,i.f) = cada1f4;
    %User Line: thrust2(:,i) = thrusterForce*u2(:,i)./m2;
end
cada2f1 = size(thrust2.dV,1);
cada1td1 = zeros(cada2f1,15);
cada1td1dV = thrust2.dVdV;
cada1td1(:,Gator1Data.Index45) = thrust2.dV;
cada2f1 = cada1td1(:,Gator1Data.Index46);
cada2f2dV = grav2.dVdV;
cada2f2 = cada2f1 + grav2.dV;
cada2td1 = zeros(size(cada1td1,1),36);
cada2td1(:,Gator2Data.Index81) = cada2f2dV;
cada2td1(:,Gator2Data.Index82) = cada1td1dV(:,Gator2Data.Index83);
cada1td1dV = cada2td1;
cada1td1(:,Gator1Data.Index46) = cada2f2;
CHA_vdot2.dVdV = cada1td1dV; CHA_vdot2.dV = cada1td1;
CHA_vdot2.f = thrust2.f + grav2.f;
%User Line: CHA_vdot2 = thrust2+grav2;
cada2f1 = size(CHA_rdot2.f,1);
cada1td1 = zeros(cada2f1,18);
cada1td1(:,Gator1Data.Index47) = CHA_rdot2.dV;
cada1td1dV = CHA_vdot2.dVdV;
cada1td1(:,Gator1Data.Index48) = CHA_vdot2.dV;
cada1f1dVdV = cada1td1dV; cada1f1dV = cada1td1;
cada1f1 = [CHA_rdot2.f CHA_vdot2.f mdot2.f];
phaseout(iphase.f).dynamics.dVdV = cada1f1dVdV;
phaseout(iphase.f).dynamics.dV = cada1f1dV;
phaseout(iphase.f).dynamics.f = cada1f1;
%User Line: phaseout(iphase).dynamics = [CHA_rdot2,CHA_vdot2,mdot2];
cada1f1 = input.phase(iphase.f).time.f;
cada1f2 = length(cada1f1);
cada1f3 = ones(cada1f2,1);
phaseout(iphase.f).integrand.f = cada1f3;
%User Line: phaseout(iphase).integrand = ones(length(input.phase(iphase).time),1);
cada1td1dV = u2.dV.*u2.dV;
cada1td1 = u2.f.*u2.dV;
cada2f1dV = u2.dV.*u2.dV;
cada2f1 = u2.f.*u2.dV;
cada2td1 = cada1td1dV;
cada2td1 = cada2td1 + cada2f1dV;
cada1td1dV = cada2td1;
cada1td1 = cada1td1 + cada2f1;
cada1f1dVdV = cada1td1dV; cada1f1dV = cada1td1;
cada1f1 = u2.f.*u2.f;
cada1tf2 =  ones(3,1);
cada1tf1 =  zeros(3,3);
cada2f1 = cada1tf2(Gator1Data.Index49);
cada1tf1(Gator1Data.Index50) = cada2f1;
cada2tf1 = zeros(3,3);
cada2tf1(Gator2Data.Index85) = cada1tf1(Gator2Data.Index84);
cada1f2dVdV = cada1f1dVdV*cada2tf1;
cada1f2dV = cada1f1dV*cada1tf1;
cada1f2 = sum(cada1f1,2);
phaseout(iphase.f).path.dVdV = cada1f2dVdV;
phaseout(iphase.f).path.dV = cada1f2dV;
phaseout(iphase.f).path.f = cada1f2;
%User Line: phaseout(iphase).path = [sum(u2.*u2,2)];
%User Line: %%%% Phase 3
iphase.f = 3;
%User Line: iphase = 3;
t3.dV = input.phase(iphase.f).time.dV;
t3.f = input.phase(iphase.f).time.f;
%User Line: t3 = input.phase(iphase).time;
CHA_r3.dV = input.phase(iphase.f).state.dV(:,Gator1Data.Index52);
CHA_r3.f = input.phase(iphase.f).state.f(:,Gator1Data.Index51);
%User Line: CHA_r3 = input.phase(iphase).state(:,1:3);
CHA_v3.dV = input.phase(iphase.f).state.dV(:,Gator1Data.Index54);
CHA_v3.f = input.phase(iphase.f).state.f(:,Gator1Data.Index53);
%User Line: CHA_v3 = input.phase(iphase).state(:,4:6);
m3.dV = input.phase(iphase.f).state.dV(:,7);
m3.f = input.phase(iphase.f).state.f(:,7);
%User Line: m3 = input.phase(iphase).state(:,7);
u3.dV = input.phase(iphase.f).control.dV;
u3.f = input.phase(iphase.f).control.f;
%User Line: u3 = input.phase(iphase).control;
CHA_rdot3.dV = CHA_v3.dV;
CHA_rdot3.f = CHA_v3.f;
%User Line: CHA_rdot3 = CHA_v3;
cada1f1 = uminus(thrusterForce);
cada1f2 = size(t3.f);
cada1f3 = ones(cada1f2);
cada1f4 = cada1f1*cada1f3;
cada1f5 = g0*Isp;
mdot3.f = cada1f4/cada1f5;
%User Line: mdot3 = -thrusterForce*ones(size(t3))/(g0*Isp);
cada1td1dV = CHA_r3.dV.*CHA_r3.dV;
cada1td1 = CHA_r3.f.*CHA_r3.dV;
cada2f1dV = CHA_r3.dV.*CHA_r3.dV;
cada2f1 = CHA_r3.f.*CHA_r3.dV;
cada2td1 = cada1td1dV;
cada2td1 = cada2td1 + cada2f1dV;
cada1td1dV = cada2td1;
cada1td1 = cada1td1 + cada2f1;
cada1f1dVdV = cada1td1dV; cada1f1dV = cada1td1;
cada1f1 = CHA_r3.f.*CHA_r3.f;
cada1tf2 =  ones(3,1);
cada1tf1 =  zeros(3,3);
cada2f1 = cada1tf2(Gator1Data.Index55);
cada1tf1(Gator1Data.Index56) = cada2f1;
cada2tf1 = zeros(3,3);
cada2tf1(Gator2Data.Index87) = cada1tf1(Gator2Data.Index86);
cada1f2dVdV = cada1f1dVdV*cada2tf1;
cada1f2dV = cada1f1dV*cada1tf1;
cada1f2 = sum(cada1f1,2);
cada1tf1dV = cada1f2dV(:,Gator2Data.Index88);
cada1tf1 = cada1f2(:,Gator1Data.Index57);
cada2tf1 = cada1tf1(:,Gator2Data.Index89);
cada2f1dV = (1/2)./sqrt(cada2tf1).*cada1tf1dV;
cada2f1dV(cada2tf1 == 0 & cada1tf1dV == 0) = 0;
cada2f1 = sqrt(cada1tf1);
cada2tf2 = cada2f1(:,Gator2Data.Index90);
cada2f2dV = -0.5./cada2tf2.^2.*cada2f1dV;
cada2f2 = 0.5./cada2f1;
cada2tf1 = cada1f2dV(:,Gator2Data.Index91);
cada2td1 = cada2tf1.*cada2f2dV;
cada2td1(:,Gator2Data.Index92) = cada2td1(:,Gator2Data.Index92) + cada2f2.*cada1f2dVdV;
r_mag3.dVdV = cada2td1;
r_mag3.dV = cada2f2.*cada1f2dV;
cada2f1 = eq(cada1tf1,0);
cada2f2 = eq(cada1f2dV,0);
cada2f3 = and(cada2f1,cada2f2);
cada2td2 = r_mag3.dVdV;
cada2tind1 = cada2f3(:,Gator2Data.Index93);
cada2td2(cada2tind1) = 0;
r_mag3.dVdV = cada2td2;
r_mag3.dV(cada2f3) = 0;
r_mag3.f = sqrt(cada1f2);
%User Line: r_mag3 = sqrt(sum(CHA_r3.*CHA_r3,2));
%User Line: %grav3 = (-mu./r_mag3.^3).*CHA_r3;%(-mu./r_mag.^3).*CHA_r;
%User Line: %thrust3 = thrusterForce.*u3./m3;
cadaforvar3.f = [1 2 3];
%User Line: cadaforvar3 = 1:3;
grav3.dV = zeros(0,9);
grav3.f = zeros(0,3);
thrust3.dV = zeros(0,6);
thrust3.f = zeros(0,3);
grav3.dVdV = zeros(size(grav3.dV,1),27);
thrust3.dVdV = zeros(size(thrust3.dV,1),9);
for cadaforcount3 = 1:3
    i.f = cadaforvar3.f(:,cadaforcount3);
    %User Line: i = cadaforvar3(:,cadaforcount3);
    cada1f1 = uminus(mu);
    cada1tf2dV = r_mag3.dV(:,Gator2Data.Index23);
    cada1tf2 = r_mag3.f(:,Gator1Data.Index58);
    cada2tf2 = cada1tf2(:,Gator2Data.Index94);
    cada2f1dV = 2.*cada2tf2.^(2-1).*cada1tf2dV;
    cada2f1 = cada1tf2.^2;
    cada2f2dV = 3.*cada2f1dV;
    cada2f2 = 3*cada2f1;
    cada2tf1 = r_mag3.dV(:,Gator2Data.Index95);
    cada2td1 = cada2tf1.*cada2f2dV;
    cada2tf1 = cada2f2(:,Gator2Data.Index96);
    cada2td1 = cada2td1 + cada2tf1.*r_mag3.dVdV;
    cada1f2dVdV = cada2td1;
    cada1f2dV = cada2f2.*r_mag3.dV;
    cada1f2 = r_mag3.f.^3;
    cada1tf2dV = cada1f2dV(:,Gator2Data.Index24);
    cada1tf2 = cada1f2(:,Gator1Data.Index59);
    cada2f1 = uminus(cada1f1);
    cada2tf2 = cada1tf2(:,Gator2Data.Index97);
    cada2f2dV = 2.*cada2tf2.^(2-1).*cada1tf2dV;
    cada2f2 = cada1tf2.^2;
    cada2tf2 = cada2f2(:,Gator2Data.Index98);
    cada2f3dV = -cada2f1./cada2tf2.^2.*cada2f2dV;
    cada2f3 = cada2f1./cada2f2;
    cada2tf1 = cada1f2dV(:,Gator2Data.Index99);
    cada2td1 = cada2tf1.*cada2f3dV;
    cada2tf1 = cada2f3(:,Gator2Data.Index100);
    cada2td1 = cada2td1 + cada2tf1.*cada1f2dVdV;
    cada1f3dVdV = cada2td1;
    cada1f3dV = cada2f3.*cada1f2dV;
    cada1f3 = cada1f1./cada1f2;
    cada2f1 = size(CHA_r3.f,1);
    cada1td1 = zeros(cada2f1,3);
    cada2f1 = Gator1Data.Index9(:,cadaforcount3);
    cada2tempf1 = nonzeros(cada2f1);
    cada2f2 = zeros(1,1);
    cada2f2(1:length(cada2tempf1)) = cada2tempf1;
    cada2f3 = CHA_r3.dV(:,cada2f2);
    cada2f4 = Gator1Data.Index9(:,cadaforcount3);
    cada2f5 = logical(cada2f4);
    cada1td1(:,cada2f5) = cada2f3;
    cada1f4dV = cada1td1;
    cada1f4 = CHA_r3.f(:,i.f);
    cada1tf1dV = cada1f4dV(:,Gator2Data.Index25);
    cada1tf1 = cada1f4(:,Gator1Data.Index60);
    cada2tf1 = cada1f3dV(:,Gator2Data.Index101);
    cada2td1 = cada2tf1.*cada1tf1dV;
    cada2tf1 = cada1tf1(:,Gator2Data.Index102);
    cada2td1 = cada2td1 + cada2tf1.*cada1f3dVdV;
    cada1td1dV = cada2td1;
    cada1td1 = cada1tf1.*cada1f3dV;
    cada1tf1dV = cada1f3dV(:,Gator2Data.Index26);
    cada1tf1 = cada1f3(:,Gator1Data.Index61);
    cada2tf1 = cada1f4dV(:,Gator2Data.Index103);
    cada2f1dV = cada2tf1.*cada1tf1dV;
    cada2f1 = cada1tf1.*cada1f4dV;
    cada2td1 = cada1td1dV;
    cada2td1 = cada2td1 + cada2f1dV;
    cada1td1dV = cada2td1;
    cada1td1 = cada1td1 + cada2f1;
    cada1f5dVdV = cada1td1dV;     cada1f5dV = cada1td1;
    cada1f5 = cada1f3.*cada1f4;
    cada2f1 = size(cada1f5,1);
    cada1tf1 = 1:cada2f1;
    cada2f1 = Gator1Data.Index11(:,cadaforcount3);
    cada2f2 = logical(cada2f1);
    cada2f3 = Gator1Data.Index11(:,cadaforcount3);
    cada2tempf1 = nonzeros(cada2f3);
    cada2f4 = zeros(3,1);
    cada2f4(1:length(cada2tempf1)) = cada2tempf1;
    cada2f5dV = cada1f5dVdV(:,Gator2Data.Index27);
    cada2f5 = cada1f5dV(:,cada2f4);
    grav3.dVdV(cada1tf1,logical(Gator2Data.Index30(:,cadaforcount3))) = cada2f5dV(:,nonzeros(Gator2Data.Index30(:,cadaforcount3)));
    grav3.dV(cada1tf1,cada2f2) = cada2f5;
    grav3.f(cada1tf1,i.f) = cada1f5;
    %User Line: grav3(:,i) = (-mu./r_mag3.^(3)).*CHA_r3(:,i);
    cada2f1 = size(u3.f,1);
    cada1td1 = zeros(cada2f1,3);
    cada2f1 = Gator1Data.Index10(:,cadaforcount3);
    cada2tempf1 = nonzeros(cada2f1);
    cada2f2 = zeros(1,1);
    cada2f2(1:length(cada2tempf1)) = cada2tempf1;
    cada2f3 = u3.dV(:,cada2f2);
    cada2f4 = Gator1Data.Index10(:,cadaforcount3);
    cada2f5 = logical(cada2f4);
    cada1td1(:,cada2f5) = cada2f3;
    cada1f1dV = cada1td1;
    cada1f1 = u3.f(:,i.f);
    cada1f3dV = thrusterForce*cada1f1dV;
    cada1f3 = thrusterForce*cada1f1;
    cada1tf1dV = m3.dV(:,Gator2Data.Index28);
    cada1tf1 = m3.f(:,Gator1Data.Index62);
    cada2f1 = size(cada1f3dV,1);
    cada1td1 = zeros(cada2f1,4);
    cada1td1dV = zeros(size(cada1td1,1),7);
    cada2f1dV = -cada1f3dV./cada1tf1.^2.*cada1tf1dV;
    cada2f1 = cada1f3dV./cada1tf1;
    cada1td1dV(:,logical(Gator2Data.Index31)) = cada2f1dV(:,nonzeros(Gator2Data.Index31));
    cada1td1(:,Gator1Data.Index63) = cada2f1;
    cada2f1 = cada1td1(:,1);
    cada2f2dV = -cada1f3dV;
    cada2f2 = uminus(cada1f3);
    cada2f3dV = 2.*m3.f.^(2-1).*m3.dV;
    cada2f3 = m3.f.^2;
    cada2tf1 = cada2f3(:,Gator2Data.Index104);
    cada2td1 = zeros(size(cada2f2dV,1),4);
    cada2td1(:,Gator2Data.Index105) = cada2f2dV./cada2tf1;
    cada2td1(:,1) = cada2td1(:,1) + -cada2f2./cada2f3.^2.*cada2f3dV;
    cada2f4dV = cada2td1;
    cada2f4 = cada2f2./cada2f3;
    cada2tf1 = m3.dV(:,Gator2Data.Index106);
    cada2f5dV = cada2tf1.*cada2f4dV;
    cada2f5 = cada2f4.*m3.dV;
    cada2f6dV = cada2f5dV;
    cada2f6 = cada2f1 + cada2f5;
    cada1td1dV(:,logical(Gator2Data.Index32)) = cada2f6dV(:,nonzeros(Gator2Data.Index32));
    cada1td1(:,1) = cada2f6;
    cada1f4dVdV = cada1td1dV;     cada1f4dV = cada1td1;
    cada1f4 = cada1f3./m3.f;
    cada2f1 = size(cada1f4,1);
    cada1tf1 = 1:cada2f1;
    cada2f1 = Gator1Data.Index12(:,cadaforcount3);
    cada2f2 = logical(cada2f1);
    cada2f3 = Gator1Data.Index12(:,cadaforcount3);
    cada2tempf1 = nonzeros(cada2f3);
    cada2f4 = zeros(2,1);
    cada2f4(1:length(cada2tempf1)) = cada2tempf1;
    cada2f5dV = cada1f4dVdV(:,Gator2Data.Index29(:,cadaforcount3));
    cada2f5 = cada1f4dV(:,cada2f4);
    thrust3.dVdV(cada1tf1,logical(Gator2Data.Index33(:,cadaforcount3))) = cada2f5dV(:,nonzeros(Gator2Data.Index33(:,cadaforcount3)));
    thrust3.dV(cada1tf1,cada2f2) = cada2f5;
    thrust3.f(cada1tf1,i.f) = cada1f4;
    %User Line: thrust3(:,i) = thrusterForce*u3(:,i)./m3;
end
cada2f1 = size(thrust3.dV,1);
cada1td1 = zeros(cada2f1,15);
cada1td1dV = thrust3.dVdV;
cada1td1(:,Gator1Data.Index64) = thrust3.dV;
cada2f1 = cada1td1(:,Gator1Data.Index65);
cada2f2dV = grav3.dVdV;
cada2f2 = cada2f1 + grav3.dV;
cada2td1 = zeros(size(cada1td1,1),36);
cada2td1(:,Gator2Data.Index107) = cada2f2dV;
cada2td1(:,Gator2Data.Index108) = cada1td1dV(:,Gator2Data.Index109);
cada1td1dV = cada2td1;
cada1td1(:,Gator1Data.Index65) = cada2f2;
CHA_vdot3.dVdV = cada1td1dV; CHA_vdot3.dV = cada1td1;
CHA_vdot3.f = thrust3.f + grav3.f;
%User Line: CHA_vdot3 = thrust3+grav3;
cada2f1 = size(CHA_rdot3.f,1);
cada1td1 = zeros(cada2f1,18);
cada1td1(:,Gator1Data.Index66) = CHA_rdot3.dV;
cada1td1dV = CHA_vdot3.dVdV;
cada1td1(:,Gator1Data.Index67) = CHA_vdot3.dV;
cada1f1dVdV = cada1td1dV; cada1f1dV = cada1td1;
cada1f1 = [CHA_rdot3.f CHA_vdot3.f mdot3.f];
phaseout(iphase.f).dynamics.dVdV = cada1f1dVdV;
phaseout(iphase.f).dynamics.dV = cada1f1dV;
phaseout(iphase.f).dynamics.f = cada1f1;
%User Line: phaseout(iphase).dynamics = [CHA_rdot3,CHA_vdot3,mdot3];
cada1f1 = input.phase(iphase.f).time.f;
cada1f2 = length(cada1f1);
cada1f3 = ones(cada1f2,1);
phaseout(iphase.f).integrand.f = cada1f3;
%User Line: phaseout(iphase).integrand = ones(length(input.phase(iphase).time),1);
cada1td1dV = u3.dV.*u3.dV;
cada1td1 = u3.f.*u3.dV;
cada2f1dV = u3.dV.*u3.dV;
cada2f1 = u3.f.*u3.dV;
cada2td1 = cada1td1dV;
cada2td1 = cada2td1 + cada2f1dV;
cada1td1dV = cada2td1;
cada1td1 = cada1td1 + cada2f1;
cada1f1dVdV = cada1td1dV; cada1f1dV = cada1td1;
cada1f1 = u3.f.*u3.f;
cada1tf2 =  ones(3,1);
cada1tf1 =  zeros(3,3);
cada2f1 = cada1tf2(Gator1Data.Index68);
cada1tf1(Gator1Data.Index69) = cada2f1;
cada2tf1 = zeros(3,3);
cada2tf1(Gator2Data.Index111) = cada1tf1(Gator2Data.Index110);
cada1f2dVdV = cada1f1dVdV*cada2tf1;
cada1f2dV = cada1f1dV*cada1tf1;
cada1f2 = sum(cada1f1,2);
phaseout(iphase.f).path.dVdV = cada1f2dVdV;
phaseout(iphase.f).path.dV = cada1f2dV;
phaseout(iphase.f).path.f = cada1f2;
%User Line: phaseout(iphase).path = [sum(u3.*u3,2)];
%User Line: %---------------------------------------------%
%User Line: % END: function debrisPickupContinuous.m %
%User Line: %---------------------------------------------%
cada2f1 = [7 11];
phaseout(1).dynamics.dV_size = cada2f1;
phaseout(1).dynamics.dV_location = Gator1Data.Index70;
cada2f1 = 11;
phaseout(1).path.dV_size = cada2f1;
phaseout(1).path.dV_location = Gator1Data.Index71;
cada2f1 = [7 11];
phaseout(2).dynamics.dV_size = cada2f1;
phaseout(2).dynamics.dV_location = Gator1Data.Index72;
cada2f1 = 11;
phaseout(2).path.dV_size = cada2f1;
phaseout(2).path.dV_location = Gator1Data.Index73;
cada2f1 = [7 11];
phaseout(3).dynamics.dV_size = cada2f1;
phaseout(3).dynamics.dV_location = Gator1Data.Index74;
cada2f1 = 11;
phaseout(3).path.dV_size = cada2f1;
phaseout(3).path.dV_location = Gator1Data.Index75;
phaseout(1).dynamics.dVdV_size = [phaseout(1).dynamics.dV_size,11];
phaseout(1).dynamics.dVdV_location = [phaseout(1).dynamics.dV_location(Gator2Data.Index112,:), Gator2Data.Index113];
phaseout(1).path.dVdV_size = [phaseout(1).path.dV_size,11];
phaseout(1).path.dVdV_location = [phaseout(1).path.dV_location(Gator2Data.Index114,:), Gator2Data.Index115];
phaseout(2).dynamics.dVdV_size = [phaseout(2).dynamics.dV_size,11];
phaseout(2).dynamics.dVdV_location = [phaseout(2).dynamics.dV_location(Gator2Data.Index116,:), Gator2Data.Index117];
phaseout(2).path.dVdV_size = [phaseout(2).path.dV_size,11];
phaseout(2).path.dVdV_location = [phaseout(2).path.dV_location(Gator2Data.Index118,:), Gator2Data.Index119];
phaseout(3).dynamics.dVdV_size = [phaseout(3).dynamics.dV_size,11];
phaseout(3).dynamics.dVdV_location = [phaseout(3).dynamics.dV_location(Gator2Data.Index120,:), Gator2Data.Index121];
phaseout(3).path.dVdV_size = [phaseout(3).path.dV_size,11];
phaseout(3).path.dVdV_location = [phaseout(3).path.dV_location(Gator2Data.Index122,:), Gator2Data.Index123];
end


function ADiGator_LoadData()
global ADiGator_debrisPickupContinuousADiGatorHes
ADiGator_debrisPickupContinuousADiGatorHes = load('debrisPickupContinuousADiGatorHes.mat');
return
end