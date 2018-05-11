function output = debrisPickupEndpoint(input)

% Target 1's position
TAR1_x0 = input.auxdata.TAR1_x;
TAR1_y0 = input.auxdata.TAR1_y;
TAR1_z0 = input.auxdata.TAR1_z;
TAR2_x0 = input.auxdata.TAR2_x;
TAR2_y0 = input.auxdata.TAR2_y;
TAR2_z0 = input.auxdata.TAR2_z;
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
a3 = input.phase(3).integral;
mf3 = input.phase(3).finalstate(7);

% Construct Objective
a = a1+a2+a3;
mf = mf1+mf2+mf3;
output.objective = a-mf; 

% What's finaltime of phase 1?
% if finaltime1 < TAR1_t(1)
%     r=1;
% else 
%     r=length(TAR1_t);
% end
% 
% TAR1_x0 = TAR1_r(r,1); TAR1_y0 = TAR1_r(r,2); TAR1_z0 = TAR1_r(r,3);
    
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

end