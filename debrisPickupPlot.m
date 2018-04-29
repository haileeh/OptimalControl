figure(1)
pp = plot(solution.phase(1).time,solution.phase(1).state(:,1:6),'-o');
xl = xlabel('$t$','Interpreter','LaTeX');
yl = ylabel('$(x(t) [km], v(t) [km/s])$','Interpreter','LaTeX');
ll = legend('$x(t)$','$y(t)$','$z(t)$','$v_x(t)$','$v_y(t)$','$v_z(t)$','Location','NorthWest');
set(pp,'LineWidth',1.25,'MarkerSize',8);
set(xl,'FontSize',18);
set(yl,'FontSize',18);
set(ll,'FontSize',18,'Interpreter','LaTeX');
set(gca,'FontSize',16,'FontName','Times');
title('Chaser state')
grid on
print -dpng debrisPickupState.png

figure(2)
pp = plot(solution.phase(1).time,solution.phase(1).state(:,7),'-o');
xl = xlabel('$t$','Interpreter','LaTeX');
yl = ylabel('$m(t) [kg]$','Interpreter','LaTeX');
%ll = legend('$x(t)$','$y(t)$','$z(t)$','$v_x(t)$','$v_y(t)$','$v_z(t)$','Location','NorthWest');
set(pp,'LineWidth',1.25,'MarkerSize',8);
set(xl,'FontSize',18);
set(yl,'FontSize',18);
%set(ll,'FontSize',18,'Interpreter','LaTeX');
set(gca,'FontSize',16,'FontName','Times');
title('Mass')
grid on
print -dpng debrisPickupState.png

figure(3)
pp = plot(solution.phase(1).time,solution.phase(1).control,'-o');
xl = xlabel('$t$','Interpreter','LaTeX');
yl = ylabel('$u(t)$','Interpreter','LaTeX');
ll = legend('$u_1(t)$','$u_2(t)$','$u_3(t)$','Location','NorthWest');
set(pp,'LineWidth',1.25,'MarkerSize',8);
set(xl,'FontSize',18);
set(yl,'FontSize',18);
set(ll,'FontSize',18,'Interpreter','LaTeX');
set(gca,'FontSize',16,'FontName','Times');
grid on
print -dpng debrisPickupControl.png

figure(4)
pp=plot3(solution.phase(1).state(:,1),solution.phase(1).state(:,2),solution.phase(1).state(:,3),'-o');
xl = xlabel('$x(t) [km]$','Interpreter','LaTeX');
yl = ylabel('$y(t) [km]$','Interpreter','LaTeX');
zl = zlabel('$z(t) [km]$','Interpreter','LaTeX');
set(pp,'LineWidth',1.25,'MarkerSize',8);
set(xl,'FontSize',18);
set(yl,'FontSize',18);
set(zl,'FontSize',18);
set(ll,'FontSize',18,'Interpreter','LaTeX');
set(gca,'FontSize',16,'FontName','Times');
grid on
print -dpng singularArcXvYvZ.png
