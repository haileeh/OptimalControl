function output = debrisPickupEndpoint(input)

% Target 1's position
TAR1_x0 = input.auxdata.TAR1_x;
TAR1_y0 = input.auxdata.TAR1_y;
TAR1_z0 = input.auxdata.TAR1_z;
TAR2_x0 = input.auxdata.TAR2_x;
TAR2_y0 = input.auxdata.TAR2_y;
TAR2_z0 = input.auxdata.TAR2_z;
TAR3_x0 = input.auxdata.TAR3_x;
TAR3_y0 = input.auxdata.TAR3_y;
TAR3_z0 = input.auxdata.TAR3_z;
TAR1_t  = input.auxdata.TAR1_t;
TAR1_r  = input.auxdata.TAR1_r;

% Phase 1
initialstate1 = input.phase(1).initialstate;
finalstate1 = input.phase(1).finalstate;
finaltime1 = input.phase(1).finaltime;
a1 = input.phase(1).integral;
mf1 = input.phase(1).finalstate(7);

% Phase 2
initialstate2 = input.phase(2).initialstate;
initialtime2 = input.phase(2).initialtime;
finalstate2 = input.phase(2).finalstate;
finaltime2 = input.phase(2).finaltime;
a2 = input.phase(2).integral;
mf2 = input.phase(2).finalstate(7);

% Phase 3
initialstate3 = input.phase(3).initialstate;
initialtime3 = input.phase(3).initialtime;
finalstate3 = input.phase(3).finalstate;
finaltime3 = input.phase(3).finaltime;
a3 = input.phase(3).integral;
mf3 = input.phase(3).finalstate(7);

% Phase 4
initialstate4 = input.phase(4).initialstate;
initialtime4 = input.phase(4).initialtime;
finalstate4 = input.phase(4).finalstate;
finaltime4 = input.phase(4).finaltime;
a4 = input.phase(4).integral;
mf4 = input.phase(4).finalstate(7);

% Phase 5
initialstate5 = input.phase(5).initialstate;
initialtime5 = input.phase(5).initialtime;
finalstate5 = input.phase(5).finalstate;
finaltime5 = input.phase(5).finaltime;
a5 = input.phase(5).integral;
mf5 = input.phase(5).finalstate(7);

% Phase 6
initialstate6 = input.phase(6).initialstate;
initialtime6 = input.phase(6).initialtime;
finalstate6 = input.phase(6).finalstate;
finaltime6 = input.phase(6).finaltime;
a6 = input.phase(6).integral;
mf6 = input.phase(6).finalstate(7);

% Construct Objective
a = a1+a2+a3+a4+a5+a6;
mf = mf1+mf2+mf3+mf4+mf5+mf6;
output.objective = a-mf; 

    
% Event groups as constraints
% constrains when phase ends
output.eventgroup(1).event = [finalstate1(1)-TAR1_x0, finalstate1(2)-TAR1_y0, finalstate1(3)-TAR1_z0];
% constrains phase 2 to start at end of phase 1
output.eventgroup(2).event = [initialstate2(:,1:7)-finalstate1(:,1:7), initialtime2-finaltime1];
% constrains phase 2 to end at position phase 1 started at
output.eventgroup(3).event = [finalstate2(1)-initialstate1(1),...
    finalstate2(2)-initialstate1(2), finalstate2(3)-initialstate1(3)];
% constrains phase 3 to start at end of phase 2
output.eventgroup(4).event = [initialstate3(:,1:7)-finalstate2(:,1:7), initialtime3-finaltime2];
% constrains phase 3 to end at TAR2 position
output.eventgroup(5).event = [finalstate3(1)-TAR2_x0,finalstate3(2)-TAR2_y0, finalstate3(3)-TAR2_z0];
% constrains phase 4 to start at end of phase 3
output.eventgroup(6).event = [initialstate4(:,1:7)-finalstate3(:,1:7), initialtime4-finaltime3];
% constrains phase 4 to end at CHA_r0 position
output.eventgroup(7).event = [finalstate4(1)-initialstate1(1),finalstate4(2)-initialstate1(2), finalstate4(3)-initialstate1(3)];
% constrains phase 5 to start at end of phase 4
output.eventgroup(8).event = [initialstate5(:,1:7)-finalstate4(:,1:7), initialtime5-finaltime4];
% constrains phase 5 to end at TAR3_r0 position
output.eventgroup(9).event = [finalstate5(1)-TAR3_x0,finalstate5(2)-TAR3_y0, finalstate5(3)-TAR3_z0];
% constrains phase 6 to start at end of phase 5
output.eventgroup(10).event = [initialstate6(:,1:7)-finalstate5(:,1:7), initialtime6-finaltime5];
% constrains phase 6 to end at CHA_r0 position
output.eventgroup(11).event = [finalstate6(1)-initialstate1(1),finalstate6(2)-initialstate1(2), finalstate6(3)-initialstate1(3)];

end