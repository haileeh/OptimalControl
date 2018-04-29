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

%% Animation
x = solution.phase(1).state(:,1);
minx = min(x); maxx = max(x);
y = solution.phase(1).state(:,2);
miny = min(y); maxy = max(y);
z = solution.phase(1).state(:,3);
minz = min(z); maxz = max(z);
tspan = solution.phase(1).time;

figure
%plot3(x(1),y(1),z(1),'k'); hold on;
grid on;
xl = xlabel('$x(t) [km]$','Interpreter','LaTeX');
yl = ylabel('$y(t) [km]$','Interpreter','LaTeX');
zl = zlabel('$z(t) [km]$','Interpreter','LaTeX');
set(xl,'FontSize',18);
set(yl,'FontSize',18);
set(zl,'FontSize',18);

axis([minx-5 maxx+5 miny-5 maxy+5 minz-5 maxz+5]);
l = 2.5;
%chaser = patch([x(1)-5 x(1)],[y(1)-5 y(1)], [z(1)-5 z(1)], 'r');
%chaser = patch([x(1)-5 x(1)-5 x(1) x(1)],[y(1)-5 y(1) y(1) y(1)-5],'r');
chaser = patch([x(1)-l x(1)-l x(1)+l x(1)+l],[y(1)-l y(1)+l y(1)+l y(1)-l],[z(1)-l z(1)+l z(1)+l z(1)-l], 'r');
target = patch([x(end)-l x(end)-l x(end)+l x(end)+l],[y(end)-l y(end)+l y(end)+l y(end)-l],[z(end)-l z(end)+l z(end)+l z(end)-l], 'g');
txt = '\leftarrow Target 1';
text(x(end),y(end),z(end),txt);
n = length(x);
i=1;

for i=2:n
    chaser.XData=([x(i)-l x(i)-l x(i)+l x(i)+l]);
    chaser.YData=([y(i)-l y(i)+l y(i)+l y(i)-l]);
    chaser.ZData=([z(i)-l z(i)+l z(i)+l z(i)-l]);
    hold on;
    plot3(x(i), y(i), z(i), 'k.');
    drawnow;
end

