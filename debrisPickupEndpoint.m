function output = debrisPickupEndpoint(input)

% Target 1's position
TAR1_x0 = input.auxdata.TAR1_x;
TAR1_y0 = input.auxdata.TAR1_y;
TAR1_z0 = input.auxdata.TAR1_z;

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
a2 = input.phase(2).integral;
mf2 = input.phase(2).finalstate(7);

% Construct Objective
a = a1+a2;
mf = mf1+mf2;
output.objective = a-mf; 

% Event groups as constraints
output.eventgroup(1).event = [finalstate1(1)-TAR1_x0, finalstate1(2)-TAR1_y0, finalstate1(3)-TAR1_z0];
output.eventgroup(2).event = [initialstate2(:,1:7)-finalstate1(:,1:7), initialtime2-finaltime1];
output.eventgroup(3).event = [finalstate2(1)-initialstate1(1),...
    finalstate2(2)-initialstate1(2), finalstate2(3)-initialstate1(3)];

end