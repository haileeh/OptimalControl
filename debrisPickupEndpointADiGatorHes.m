% This code was generated using ADiGator version 1.4
% ©2010-2014 Matthew J. Weinstein and Anil V. Rao
% ADiGator may be obtained at https://sourceforge.net/projects/adigator/ 
% Contact: mweinstein@ufl.edu
% Bugs/suggestions may be reported to the sourceforge forums
%                    DISCLAIMER
% ADiGator is a general-purpose software distributed under the GNU General
% Public License version 3.0. While the software is distributed with the
% hope that it will be useful, both the software and generated code are
% provided 'AS IS' with NO WARRANTIES OF ANY KIND and no merchantability
% or fitness for any purpose or application.

function output = debrisPickupEndpointADiGatorHes(input)
global ADiGator_debrisPickupEndpointADiGatorHes
if isempty(ADiGator_debrisPickupEndpointADiGatorHes); ADiGator_LoadData(); end
Gator1Data = ADiGator_debrisPickupEndpointADiGatorHes.debrisPickupEndpointADiGatorHes.Gator1Data;
Gator2Data = ADiGator_debrisPickupEndpointADiGatorHes.debrisPickupEndpointADiGatorHes.Gator2Data;
% ADiGator Start Derivative Computations
%User Line: % Target 1's position
TAR1_x0 = input.auxdata.TAR1_x;
%User Line: TAR1_x0 = input.auxdata.TAR1_x;
TAR1_y0 = input.auxdata.TAR1_y;
%User Line: TAR1_y0 = input.auxdata.TAR1_y;
TAR1_z0 = input.auxdata.TAR1_z;
%User Line: TAR1_z0 = input.auxdata.TAR1_z;
TAR2_x0 = input.auxdata.TAR2_x;
%User Line: TAR2_x0 = input.auxdata.TAR2_x;
TAR2_y0 = input.auxdata.TAR2_y;
%User Line: TAR2_y0 = input.auxdata.TAR2_y;
TAR2_z0 = input.auxdata.TAR2_z;
%User Line: TAR2_z0 = input.auxdata.TAR2_z;
TAR1_t = input.auxdata.TAR1_t;
%User Line: TAR1_t  = input.auxdata.TAR1_t;
TAR1_r = input.auxdata.TAR1_r;
%User Line: TAR1_r  = input.auxdata.TAR1_r;
%User Line: % Phase 1
initialstate1.dv = input.phase(1).initialstate.dv;
initialstate1.f = input.phase(1).initialstate.f;
%User Line: initialstate1 = input.phase(1).initialstate;
finalstate1.dv = input.phase(1).finalstate.dv;
finalstate1.f = input.phase(1).finalstate.f;
%User Line: finalstate1 = input.phase(1).finalstate;
finaltime1.dv = input.phase(1).finaltime.dv;
finaltime1.f = input.phase(1).finaltime.f;
%User Line: finaltime1 = input.phase(1).finaltime;
a1.dv = input.phase(1).integral.dv;
a1.f = input.phase(1).integral.f;
%User Line: a1 = input.phase(1).integral;
mf1.dv = input.phase(1).finalstate.dv(7);
mf1.f = input.phase(1).finalstate.f(7);
%User Line: mf1 = input.phase(1).finalstate(7);
%User Line: % Phase 2
initialstate2.dv = input.phase(2).initialstate.dv;
initialstate2.f = input.phase(2).initialstate.f;
%User Line: initialstate2 = input.phase(2).initialstate;
initialtime2.dv = input.phase(2).initialtime.dv;
initialtime2.f = input.phase(2).initialtime.f;
%User Line: initialtime2 = input.phase(2).initialtime;
finalstate2.dv = input.phase(2).finalstate.dv;
finalstate2.f = input.phase(2).finalstate.f;
%User Line: finalstate2 = input.phase(2).finalstate;
finaltime2.dv = input.phase(2).finaltime.dv;
finaltime2.f = input.phase(2).finaltime.f;
%User Line: finaltime2 = input.phase(2).finaltime;
a2.dv = input.phase(2).integral.dv;
a2.f = input.phase(2).integral.f;
%User Line: a2 = input.phase(2).integral;
mf2.dv = input.phase(2).finalstate.dv(7);
mf2.f = input.phase(2).finalstate.f(7);
%User Line: mf2 = input.phase(2).finalstate(7);
%User Line: % Phase 3
initialstate3.dv = input.phase(3).initialstate.dv;
initialstate3.f = input.phase(3).initialstate.f;
%User Line: initialstate3 = input.phase(3).initialstate;
initialtime3.dv = input.phase(3).initialtime.dv;
initialtime3.f = input.phase(3).initialtime.f;
%User Line: initialtime3 = input.phase(3).initialtime;
finalstate3.dv = input.phase(3).finalstate.dv;
finalstate3.f = input.phase(3).finalstate.f;
%User Line: finalstate3 = input.phase(3).finalstate;
a3.dv = input.phase(3).integral.dv;
a3.f = input.phase(3).integral.f;
%User Line: a3 = input.phase(3).integral;
mf3.dv = input.phase(3).finalstate.dv(7);
mf3.f = input.phase(3).finalstate.f(7);
%User Line: mf3 = input.phase(3).finalstate(7);
%User Line: % Construct Objective
cada1td1 =  zeros(2,1);
cada1td1(1) = a1.dv;
cada2f1 = cada1td1(2);
cada2f2 = cada2f1 + a2.dv;
cada1td1(2) = cada2f2;
cada1f1dv = cada1td1;
cada1f1 = a1.f + a2.f;
cada1td1 =  zeros(3,1);
cada1td1(Gator1Data.Index1) = cada1f1dv;
cada2f1 = cada1td1(3);
cada2f2 = cada2f1 + a3.dv;
cada1td1(3) = cada2f2;
a.dv = cada1td1;
a.f = cada1f1 + a3.f;
%User Line: a = a1+a2+a3;
cada1td1 =  zeros(2,1);
cada1td1(1) = mf1.dv;
cada2f1 = cada1td1(2);
cada2f2 = cada2f1 + mf2.dv;
cada1td1(2) = cada2f2;
cada1f1dv = cada1td1;
cada1f1 = mf1.f + mf2.f;
cada1td1 =  zeros(3,1);
cada1td1(Gator1Data.Index2) = cada1f1dv;
cada2f1 = cada1td1(3);
cada2f2 = cada2f1 + mf3.dv;
cada1td1(3) = cada2f2;
mf.dv = cada1td1;
mf.f = cada1f1 + mf3.f;
%User Line: mf = mf1+mf2+mf3;
cada1td1 =  zeros(6,1);
cada1td1(Gator1Data.Index3) = a.dv;
cada2f1 = cada1td1(Gator1Data.Index4);
cada2f2 = uminus(mf.dv);
cada2f3 = cada2f1 + cada2f2;
cada1td1(Gator1Data.Index4) = cada2f3;
output.objective.dv = cada1td1;
output.objective.f = a.f - mf.f;
%User Line: output.objective = a-mf;
%User Line: % What's finaltime of phase 1?
%User Line: % if finaltime1 < TAR1_t(1)
%User Line: %     r=1;
%User Line: % else
%User Line: %     r=length(TAR1_t);
%User Line: % end
%User Line: %
%User Line: % TAR1_x0 = TAR1_r(r,1); TAR1_y0 = TAR1_r(r,2); TAR1_z0 = TAR1_r(r,3);
%User Line: % Event groups as constraints
%User Line: % constrains when phase ends
cada1f1dv = finalstate1.dv(1);
cada1f1 = finalstate1.f(1);
cada1f2dv = cada1f1dv;
cada1f2 = cada1f1 - TAR1_x0;
cada1f3dv = finalstate1.dv(2);
cada1f3 = finalstate1.f(2);
cada1f4dv = cada1f3dv;
cada1f4 = cada1f3 - TAR1_y0;
cada1f5dv = finalstate1.dv(3);
cada1f5 = finalstate1.f(3);
cada1f6dv = cada1f5dv;
cada1f6 = cada1f5 - TAR1_z0;
cada1td1 =  zeros(3,1);
cada1td1(1) = cada1f2dv;
cada1td1(2) = cada1f4dv;
cada1td1(3) = cada1f6dv;
cada1f7dv = cada1td1;
cada1f7 = [cada1f2 cada1f4 cada1f6];
output.eventgroup(1).event.dv = cada1f7dv;
output.eventgroup(1).event.f = cada1f7;
%User Line: output.eventgroup(1).event = [finalstate1(1)-TAR1_x0, finalstate1(2)-TAR1_y0, finalstate1(3)-TAR1_z0];
%User Line: % constrains phase 2 to start at end of phase 1
cada1f1dv = initialstate2.dv(Gator1Data.Index6);
cada1f1 = initialstate2.f(:,Gator1Data.Index5);
cada1f2dv = finalstate1.dv(Gator1Data.Index8);
cada1f2 = finalstate1.f(:,Gator1Data.Index7);
cada1td1 =  zeros(14,1);
cada1td1(Gator1Data.Index9) = cada1f1dv;
cada2f1 = cada1td1(Gator1Data.Index10);
cada2f2 = uminus(cada1f2dv);
cada2f3 = cada2f1 + cada2f2;
cada1td1(Gator1Data.Index10) = cada2f3;
cada1f3dv = cada1td1;
cada1f3 = cada1f1 - cada1f2;
cada1td1 =  zeros(2,1);
cada1td1(2) = initialtime2.dv;
cada2f1 = cada1td1(1);
cada2f2 = uminus(finaltime1.dv);
cada2f3 = cada2f1 + cada2f2;
cada1td1(1) = cada2f3;
cada1f4dv = cada1td1;
cada1f4 = initialtime2.f - finaltime1.f;
cada1td1 =  zeros(16,1);
cada1td1(Gator1Data.Index11) = cada1f3dv;
cada1td1(Gator1Data.Index12) = cada1f4dv;
cada1f5dv = cada1td1;
cada1f5 = [cada1f3 cada1f4];
output.eventgroup(2).event.dv = cada1f5dv;
output.eventgroup(2).event.f = cada1f5;
%User Line: output.eventgroup(2).event = [initialstate2(:,1:7)-finalstate1(:,1:7), initialtime2-finaltime1];
%User Line: % constrains phase 2 to end at position phase 1 started at
cada1f1dv = finalstate2.dv(1);
cada1f1 = finalstate2.f(1);
cada1f2dv = initialstate1.dv(1);
cada1f2 = initialstate1.f(1);
cada1td1 =  zeros(2,1);
cada1td1(2) = cada1f1dv;
cada2f1 = cada1td1(1);
cada2f2 = uminus(cada1f2dv);
cada2f3 = cada2f1 + cada2f2;
cada1td1(1) = cada2f3;
cada1f3dv = cada1td1;
cada1f3 = cada1f1 - cada1f2;
cada1f4dv = finalstate2.dv(2);
cada1f4 = finalstate2.f(2);
cada1f5dv = initialstate1.dv(2);
cada1f5 = initialstate1.f(2);
cada1td1 =  zeros(2,1);
cada1td1(2) = cada1f4dv;
cada2f1 = cada1td1(1);
cada2f2 = uminus(cada1f5dv);
cada2f3 = cada2f1 + cada2f2;
cada1td1(1) = cada2f3;
cada1f6dv = cada1td1;
cada1f6 = cada1f4 - cada1f5;
cada1f7dv = finalstate2.dv(3);
cada1f7 = finalstate2.f(3);
cada1f8dv = initialstate1.dv(3);
cada1f8 = initialstate1.f(3);
cada1td1 =  zeros(2,1);
cada1td1(2) = cada1f7dv;
cada2f1 = cada1td1(1);
cada2f2 = uminus(cada1f8dv);
cada2f3 = cada2f1 + cada2f2;
cada1td1(1) = cada2f3;
cada1f9dv = cada1td1;
cada1f9 = cada1f7 - cada1f8;
cada1td1 =  zeros(6,1);
cada1td1(Gator1Data.Index13) = cada1f3dv;
cada1td1(Gator1Data.Index14) = cada1f6dv;
cada1td1(Gator1Data.Index15) = cada1f9dv;
cada1f10dv = cada1td1;
cada1f10 = [cada1f3 cada1f6 cada1f9];
output.eventgroup(3).event.dv = cada1f10dv;
output.eventgroup(3).event.f = cada1f10;
%User Line: output.eventgroup(3).event = [finalstate2(1)-initialstate1(1),    finalstate2(2)-initialstate1(2), finalstate2(3)-initialstate1(3)];
%User Line: % constrains phase 3 to start at end of phase 2
cada1f1dv = initialstate3.dv(Gator1Data.Index17);
cada1f1 = initialstate3.f(:,Gator1Data.Index16);
cada1f2dv = finalstate2.dv(Gator1Data.Index19);
cada1f2 = finalstate2.f(:,Gator1Data.Index18);
cada1td1 =  zeros(14,1);
cada1td1(Gator1Data.Index20) = cada1f1dv;
cada2f1 = cada1td1(Gator1Data.Index21);
cada2f2 = uminus(cada1f2dv);
cada2f3 = cada2f1 + cada2f2;
cada1td1(Gator1Data.Index21) = cada2f3;
cada1f3dv = cada1td1;
cada1f3 = cada1f1 - cada1f2;
cada1td1 =  zeros(2,1);
cada1td1(2) = initialtime3.dv;
cada2f1 = cada1td1(1);
cada2f2 = uminus(finaltime2.dv);
cada2f3 = cada2f1 + cada2f2;
cada1td1(1) = cada2f3;
cada1f4dv = cada1td1;
cada1f4 = initialtime3.f - finaltime2.f;
cada1td1 =  zeros(16,1);
cada1td1(Gator1Data.Index22) = cada1f3dv;
cada1td1(Gator1Data.Index23) = cada1f4dv;
cada1f5dv = cada1td1;
cada1f5 = [cada1f3 cada1f4];
output.eventgroup(4).event.dv = cada1f5dv;
output.eventgroup(4).event.f = cada1f5;
%User Line: output.eventgroup(4).event = [initialstate3(:,1:7)-finalstate2(:,1:7), initialtime3-finaltime2];
%User Line: % constrains phase 3 to end at TAR2 position
cada1f1dv = finalstate3.dv(1);
cada1f1 = finalstate3.f(1);
cada1f2dv = cada1f1dv;
cada1f2 = cada1f1 - TAR2_x0;
cada1f3dv = finalstate3.dv(2);
cada1f3 = finalstate3.f(2);
cada1f4dv = cada1f3dv;
cada1f4 = cada1f3 - TAR2_y0;
cada1f5dv = finalstate3.dv(3);
cada1f5 = finalstate3.f(3);
cada1f6dv = cada1f5dv;
cada1f6 = cada1f5 - TAR2_z0;
cada1td1 =  zeros(3,1);
cada1td1(1) = cada1f2dv;
cada1td1(2) = cada1f4dv;
cada1td1(3) = cada1f6dv;
cada1f7dv = cada1td1;
cada1f7 = [cada1f2 cada1f4 cada1f6];
output.eventgroup(5).event.dv = cada1f7dv;
output.eventgroup(5).event.f = cada1f7;
%User Line: output.eventgroup(5).event = [finalstate3(1)-TAR2_x0,finalstate3(2)-TAR2_y0, finalstate3(3)-TAR2_z0];
cada2f1 = [3 51];
output.eventgroup(1).event.dv_size = cada2f1;
output.eventgroup(1).event.dv_location = Gator1Data.Index24;
cada2f1 = [8 51];
output.eventgroup(2).event.dv_size = cada2f1;
output.eventgroup(2).event.dv_location = Gator1Data.Index25;
cada2f1 = [3 51];
output.eventgroup(3).event.dv_size = cada2f1;
output.eventgroup(3).event.dv_location = Gator1Data.Index26;
cada2f1 = [8 51];
output.eventgroup(4).event.dv_size = cada2f1;
output.eventgroup(4).event.dv_location = Gator1Data.Index27;
cada2f1 = [3 51];
output.eventgroup(5).event.dv_size = cada2f1;
output.eventgroup(5).event.dv_location = Gator1Data.Index28;
output.objective.dv_size = 51;
output.objective.dv_location = Gator1Data.Index29;
end


function ADiGator_LoadData()
global ADiGator_debrisPickupEndpointADiGatorHes
ADiGator_debrisPickupEndpointADiGatorHes = load('debrisPickupEndpointADiGatorHes.mat');
return
end