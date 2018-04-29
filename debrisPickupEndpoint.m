function output = debrisPickupEndpoint(input)

finalstate = input.phase.finalstate;
% initialstate = input.phase.initialstate;
% finaltime = input.phase.finaltime;
% a_x = (finalstate(4) - initialstate(4))/finaltime;
% a_y = (finalstate(5) - initialstate(5))/finaltime;
% a_z = (finalstate(6) - initialstate(6))/finaltime;
% a = sqrt(a_x^2+a_y^2+a_z^2);
a = input.phase.integral;
mf = input.phase.finalstate(7);
output.objective = a-mf; 
output.eventgroup.event = [finalstate(1)-195, finalstate(2)-350, finalstate(3)-0];

end