% Phase 1
t1 = solution.phase(1).time;
x1 = solution.phase(1).state(:,1);
y1 = solution.phase(1).state(:,2);
z1 = solution.phase(1).state(:,3);
vx1 = solution.phase(1).state(:,4);
vy1 = solution.phase(1).state(:,5);
vz1 = solution.phase(1).state(:,6);
ux1 = solution.phase(1).control(:,1);
uy1 = solution.phase(1).control(:,2);
uz1 = solution.phase(1).control(:,3);

% Phase 2
t2 = solution.phase(2).time;
x2 = solution.phase(2).state(:,1);
y2 = solution.phase(2).state(:,2);
z2 = solution.phase(2).state(:,3);
vx2 = solution.phase(2).state(:,4);
vy2 = solution.phase(2).state(:,5);
vz2 = solution.phase(2).state(:,6);
ux2 = solution.phase(2).control(:,1);
uy2 = solution.phase(2).control(:,2);
uz2 = solution.phase(2).control(:,3);

figure(1)
px1 = plot(t1,x1,'-ob'); hold on; px2=plot(t2,x2,'-xb');
py1 = plot(t1,y1,'-om');  py2 = plot(t2,y2,'-xm');
pz1=plot(t1,z1,'-og');  pz2=plot(t2,z2,'-xg');
pvx1=plot(t1,vx1,'-oy'); pvx2 = plot(t2,vx2,'-xy');
pvy1 = plot(t1,vy1,'-ok');  pvy2 = plot(t2,vy2,'-xk');
pvz1 = plot(t1,vz1,'-oc');  pvz2= plot(t2,vz2,'-xc');
xl = xlabel('$t$','Interpreter','LaTeX');
yl = ylabel('$(x(t) [km], v(t) [km/s])$','Interpreter','LaTeX');
ll = legend([px1,py1,pz1,pvx1,pvy1,pvz1],{'$x(t)$','$y(t)$','$z(t)$','$v_x(t)$','$v_y(t)$','$v_z(t)$'},'Location','NorthEast');

set(xl,'FontSize',18);
set(yl,'FontSize',18);
set(ll,'FontSize',18,'Interpreter','LaTeX');
set(gca,'FontSize',16,'FontName','Times');
title('Chaser state')
grid on
print -dpng debrisPickupState.png

figure(2)
pp = plot(solution.phase(1).time,solution.phase(1).state(:,7),'-ok'); hold on;
pp2 = plot(solution.phase(2).time,solution.phase(2).state(:,7),'-xk');
xl = xlabel('$t$','Interpreter','LaTeX');
yl = ylabel('$m(t) [kg]$','Interpreter','LaTeX');
ll = legend('$m_1(t)$','$m_2(t)$','Location','NorthWest');
set(pp,'LineWidth',1.25,'MarkerSize',8);
set(pp2,'LineWidth',1.25,'MarkerSize',8);
set(xl,'FontSize',18);
set(yl,'FontSize',18);
set(ll,'FontSize',18,'Interpreter','LaTeX');
set(gca,'FontSize',16,'FontName','Times');
title('Mass')
grid on
print -dpng debrisPickupMass.png

figure(3)
pux1=plot(t1,ux1,'-ok'); hold on; pux2=plot(t2, ux2, '-xk');
puy1 = plot(t1,uy1,'-or'); puy2 = plot(t2,uy2,'-xr');
puz1 = plot(t1,uz1,'-og'); puz2 = plot(t2,uz2,'-xg');

xl = xlabel('$t$','Interpreter','LaTeX');
yl = ylabel('$u(t)$','Interpreter','LaTeX');
ll = legend([pux1,puy1,puz1],{'$u_1(t)$','$u_2(t)$','$u_3(t)$'},'Location','NorthEast');
set(xl,'FontSize',18);
set(yl,'FontSize',18);
set(ll,'FontSize',18,'Interpreter','LaTeX');
set(gca,'FontSize',16,'FontName','Times');
grid on
print -dpng debrisPickupControl.png

figure(4)
pp=plot3(x1,y1,z1,'-ob');
hold on;
pp2=plot3(x2,y2,z2,'-xb');
xl = xlabel('$x(t) [km]$','Interpreter','LaTeX');
yl = ylabel('$y(t) [km]$','Interpreter','LaTeX');
zl = zlabel('$z(t) [km]$','Interpreter','LaTeX');
set(pp,'LineWidth',1.25,'MarkerSize',8);
set(pp2,'LineWidth',1.25,'MarkerSize',8);
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

x2 = solution.phase(2).state(:,1);
y2 = solution.phase(2).state(:,2);
z2 = solution.phase(2).state(:,3);
tspan2 = solution.phase(2).time;

figure
%plot3(x(1),y(1),z(1),'k'); hold on;
grid on;
xl = xlabel('$x(t) [km]$','Interpreter','LaTeX');
yl = ylabel('$y(t) [km]$','Interpreter','LaTeX');
zl = zlabel('$z(t) [km]$','Interpreter','LaTeX');
set(xl,'FontSize',18);
set(yl,'FontSize',18);
set(zl,'FontSize',18);

m = 20;
axis([minx-m maxx+m miny-m maxy+m minz-m maxz+m]);
l = 2.5;
%chaser = patch([x(1)-5 x(1)],[y(1)-5 y(1)], [z(1)-5 z(1)], 'r');
%chaser = patch([x(1)-5 x(1)-5 x(1) x(1)],[y(1)-5 y(1) y(1) y(1)-5],'r');
chaser = patch([x(1)-l x(1)-l x(1)+l x(1)+l],[y(1)-l y(1)+l y(1)+l y(1)-l],[z(1)-l z(1)+l z(1)+l z(1)-l], 'r');
target = patch([x(end)-l x(end)-l x(end)+l x(end)+l],[y(end)-l y(end)+l y(end)+l y(end)-l],[z(end)-l z(end)+l z(end)+l z(end)-l], 'g');
txt = '\leftarrow Target 1';
text(x(end),y(end),z(end),txt);
n = length(x);

for i=2:n
    chaser.XData=([x(i)-l x(i)-l x(i)+l x(i)+l]);
    chaser.YData=([y(i)-l y(i)+l y(i)+l y(i)-l]);
    chaser.ZData=([z(i)-l z(i)+l z(i)+l z(i)-l]);
    hold on;
    plot3(x(i), y(i), z(i), 'k.');
    drawnow;
end

m = length(x2);
for i=1:m
    chaser.XData=([x2(i)-l x2(i)-l x2(i)+l x2(i)+l]);
    chaser.YData=([y2(i)-l y2(i)+l y2(i)+l y2(i)-l]);
    chaser.ZData=([z2(i)-l z2(i)+l z2(i)+l z2(i)-l]);
    hold on;
    plot3(x2(i), y2(i), z2(i), 'k.');
    drawnow;
end

