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

% Phase 3
t3 = solution.phase(3).time;
x3 = solution.phase(3).state(:,1);
y3 = solution.phase(3).state(:,2);
z3 = solution.phase(3).state(:,3);
vx3 = solution.phase(3).state(:,4);
vy3 = solution.phase(3).state(:,5);
vz3 = solution.phase(3).state(:,6);
ux3 = solution.phase(3).control(:,1);
uy3 = solution.phase(3).control(:,2);
uz3 = solution.phase(3).control(:,3);

% Phase 4
t4 = solution.phase(4).time;
x4 = solution.phase(4).state(:,1);
y4 = solution.phase(4).state(:,2);
z4 = solution.phase(4).state(:,3);
vx4 = solution.phase(4).state(:,4);
vy4 = solution.phase(4).state(:,5);
vz4 = solution.phase(4).state(:,6);
ux4 = solution.phase(4).control(:,1);
uy4 = solution.phase(4).control(:,2);
uz4 = solution.phase(4).control(:,3);

% Phase 5
t5 = solution.phase(5).time;
x5 = solution.phase(5).state(:,1);
y5 = solution.phase(5).state(:,2);
z5 = solution.phase(5).state(:,3);
vx5 = solution.phase(5).state(:,4);
vy5 = solution.phase(5).state(:,5);
vz5 = solution.phase(5).state(:,6);
ux5 = solution.phase(5).control(:,1);
uy5 = solution.phase(5).control(:,2);
uz5 = solution.phase(5).control(:,3);

% Phase 6
t6 = solution.phase(6).time;
x6 = solution.phase(6).state(:,1);
y6 = solution.phase(6).state(:,2);
z6 = solution.phase(6).state(:,3);
vx6 = solution.phase(6).state(:,4);
vy6 = solution.phase(6).state(:,5);
vz6 = solution.phase(6).state(:,6);
ux6 = solution.phase(6).control(:,1);
uy6 = solution.phase(6).control(:,2);
uz6 = solution.phase(6).control(:,3);

figure(1)
subplot(2,1,1)
px1 = plot(t1,x1,'-ob'); hold on; px2=plot(t2,x2,'-xb'); px3=plot(t3,x3,'-.b'); 
px4=plot(t4,x4,'-*b'); px5=plot(t5,x5,'-sb'); px6=plot(t6,x6,'-db');
py1 = plot(t1,y1,'-om');  py2 = plot(t2,y2,'-xm'); py3=plot(t3,y3,'-.m'); 
py4=plot(t4,y4,'-*m'); py5=plot(t5,y5,'-sm'); py6=plot(t6,y6,'-dm');
pz1 =plot(t1,z1,'-og');  pz2=plot(t2,z2,'-xg'); pz3=plot(t3,z3,'-.g'); 
pz4=plot(t4,z4,'-*g'); pz5=plot(t5,z5,'-sg'); pz6=plot(t6,z6,'-dg');
xl = xlabel('$t$','Interpreter','LaTeX');
yl = ylabel('$x(t), y(t), z(t) [km]$','Interpreter','LaTeX');
ll = legend([px1,py1,pz1],{'$x(t)$','$y(t)$','$z(t)$'},'Location','NorthEast');
set(xl,'FontSize',18);
set(yl,'FontSize',18);
set(ll,'FontSize',18,'Interpreter','LaTeX');
set(gca,'FontSize',16,'FontName','Times');
title('Chaser Positions')
grid on

subplot(2,1,2)
pvx1=plot(t1,vx1,'-oy'); hold on; pvx2 = plot(t2,vx2,'-xy'); pvx3 = plot(t3,vx3,'-.y'); 
pvx4 = plot(t4,vx4,'-*y'); pvx5 = plot(t5,vx5,'-sy'); pvx6 = plot(t6,vx6,'-dy');
pvy1 = plot(t1,vy1,'-ok');  pvy2 = plot(t2,vy2,'-xk'); pvy3 = plot(t3,vy3,'-.k'); 
pvy4 = plot(t4,vy4,'-*k'); pvy5 = plot(t5,vy5,'-sk'); pvy6 = plot(t6,vy6,'-dk');
pvz1 = plot(t1,vz1,'-oc');  pvz2= plot(t2,vz2,'-xc'); pvz3 = plot(t3,vz3,'-.c'); 
pvz4 = plot(t4,vz4,'-*c'); pvz5 = plot(t5,vz5,'-sc'); pvz6 = plot(t6,vz6,'-dc');
xl = xlabel('$t$','Interpreter','LaTeX');
yl = ylabel('$v(t) [km/s]$','Interpreter','LaTeX');
ll = legend([pvx1,pvy1,pvz1],{'$v_x(t)$','$v_y(t)$','$v_z(t)$'},'Location','NorthEast');
set(xl,'FontSize',18);
set(yl,'FontSize',18);
set(ll,'FontSize',18,'Interpreter','LaTeX');
set(gca,'FontSize',16,'FontName','Times');
title('Chaser Velocities')
grid on;
print -dpng debrisPickupState.png

figure(2)
pp = plot(solution.phase(1).time,solution.phase(1).state(:,7),'-ok'); hold on;
pp2 = plot(solution.phase(2).time,solution.phase(2).state(:,7),'-xk');
pp3 = plot(solution.phase(3).time,solution.phase(3).state(:,7),'-.k');
pp4 = plot(solution.phase(4).time,solution.phase(4).state(:,7),'-*k');
pp5 = plot(solution.phase(5).time,solution.phase(5).state(:,7),'-sk');
pp6 = plot(solution.phase(6).time,solution.phase(6).state(:,7),'-dk');
xl = xlabel('$t$','Interpreter','LaTeX');
yl = ylabel('$m(t) [kg]$','Interpreter','LaTeX');
ll = legend('$m_1(t)$','$m_2(t)$','$m_3(t)$','$m_4(t)$','$m_5(t)$','Location','SouthEast');
set(pp,'LineWidth',1.25,'MarkerSize',8);
set(pp2,'LineWidth',1.25,'MarkerSize',8);
set(pp3,'LineWidth',1.25,'MarkerSize',8);
set(pp4,'LineWidth',1.25,'MarkerSize',8);
set(pp5,'LineWidth',1.25,'MarkerSize',8);
set(pp6,'LineWidth',1.25,'MarkerSize',8);
set(xl,'FontSize',18);
set(yl,'FontSize',18);
set(ll,'FontSize',18,'Interpreter','LaTeX');
set(gca,'FontSize',16,'FontName','Times');
title('Mass')
grid on
print -dpng debrisPickupMass.png

%% Control plot
figure(3)
pux1=plot(t1,ux1,'-ok'); hold on; pux2=plot(t2, ux2, '-xk'); pux3= plot(t3, ux3, '-.k'); 
pux4= plot(t4, ux4, '-*k'); pux5= plot(t5, ux5, '-sk'); pux6= plot(t6, ux6, '-dk');
puy1 = plot(t1,uy1,'-or'); puy2 = plot(t2,uy2,'-xr'); puy3= plot(t3, uy3, '-.r'); 
puy4= plot(t4, uy4, '-*r'); puy5= plot(t5, uy5, '-sr'); puy6= plot(t6, uy6, '-dr');
puz1 = plot(t1,uz1,'-og'); puz2 = plot(t2,uz2,'-xg'); puz3= plot(t3, uz3, '-.g'); 
puz4= plot(t4, uz4, '-*g'); puz5= plot(t5, uz5, '-sg'); puz6= plot(t6, uz6, '-dg');
xl = xlabel('$t$','Interpreter','LaTeX');
yl = ylabel('$u(t)$','Interpreter','LaTeX');
ll = legend([pux1,puy1,puz1],{'$u_1(t)$','$u_2(t)$','$u_3(t)$'},'Location','NorthEast');
set(xl,'FontSize',18);
set(yl,'FontSize',18);
set(ll,'FontSize',18,'Interpreter','LaTeX');
set(gca,'FontSize',16,'FontName','Times');
ylim([-1 1]);
grid on
print -dpng debrisPickupControl.png

%% 3d motion
figure(4)
set(gcf, 'Position', [100, 100, 1000, 600])
pp=plot3(x1,y1,z1,'-ok');
hold on;
pp2=plot3(x2,y2,z2,'-xg'); pp3 = plot3(x3,y3,z3,'-.k');
pp4 = plot3(x4,y4,z4,'-*b'); pp5 = plot3(x5,y5,z5,'-sb'); pp6 = plot3(x6,y6,z6,'-dc');
xl = xlabel('$x(t) [km]$','Interpreter','LaTeX');
yl = ylabel('$y(t) [km]$','Interpreter','LaTeX');
zl = zlabel('$z(t) [km]$','Interpreter','LaTeX');
set(pp,'LineWidth',1.25,'MarkerSize',8);
set(pp2,'LineWidth',1.25,'MarkerSize',8);
set(pp3,'LineWidth',1.25,'MarkerSize',8);
set(pp4,'LineWidth',1.25,'MarkerSize',8);
set(pp5,'LineWidth',1.25,'MarkerSize',8);
set(pp6,'LineWidth',1.25,'MarkerSize',8);
set(xl,'FontSize',18);
set(yl,'FontSize',18);
set(zl,'FontSize',18);
set(ll,'FontSize',18,'Interpreter','LaTeX');
set(gca,'FontSize',16,'FontName','Times');
grid on
print -dpng debrisPickupXvYvZ.png

%% Animation
x = solution.phase(1).state(:,1);
minx1 = min(x); maxx1 = max(x);
y = solution.phase(1).state(:,2);
miny1 = min(y); maxy1 = max(y);
z = solution.phase(1).state(:,3);
minz1 = min(z); maxz1 = max(z);
tspan = solution.phase(1).time;

x2 = solution.phase(2).state(:,1);
minx2 = min(x2); maxx2 = max(x2);
y2 = solution.phase(2).state(:,2);
miny2 = min(y2); maxy2 = max(y2);
z2 = solution.phase(2).state(:,3);
minz2 = min(z2); maxz2 = max(z2);
tspan2 = solution.phase(2).time;

x3 = solution.phase(3).state(:,1);
minx3 = min(x3); maxx3 = max(x3);
y3 = solution.phase(3).state(:,2);
miny3 = min(y3); maxy3 = max(y3);
z3 = solution.phase(3).state(:,3);
minz3 = min(z3); maxz3 = max(z3);
tspan3 = solution.phase(3).time;

x4 = solution.phase(4).state(:,1);
minx4 = min(x4); maxx4 = max(x4);
y4 = solution.phase(4).state(:,2);
miny4 = min(y4); maxy4 = max(y4);
z4 = solution.phase(4).state(:,3);
minz4 = min(z4); maxz4 = max(z4);
tspan4 = solution.phase(4).time;

x5 = solution.phase(5).state(:,1);
minx5 = min(x5); maxx5 = max(x5);
y5 = solution.phase(5).state(:,2);
miny5 = min(y5); maxy5 = max(y5);
z5 = solution.phase(5).state(:,3);
minz5 = min(z5); maxz5 = max(z5);
tspan5 = solution.phase(5).time;

x6 = solution.phase(6).state(:,1);
minx6 = min(x6); maxx6 = max(x6);
y6 = solution.phase(6).state(:,2);
miny6 = min(y6); maxy6 = max(y6);
z6 = solution.phase(6).state(:,3);
minz6 = min(z6); maxz6 = max(z6);
tspan6 = solution.phase(6).time;

minx = min([minx1, minx2, minx3, minx4, minx5, minx6]);
maxx = max([maxx1, maxx2, maxx3, maxx4, maxx5, maxx6]);
miny = min([miny1, miny2, miny3, miny4, miny5, miny6]);
maxy = max([maxy1, maxy2, maxy3, maxy4, maxy5, maxy6]);
minz = min([minz1, minz2, minz3, minz4, minz5, minz6]);
maxz = max([maxz1, maxz2, maxz3, maxz4, maxz5, maxz6]);

figure
set(gcf, 'Position', [100, 100, 1000, 600])
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
l = 5;%2.5;
%chaser = patch([x(1)-5 x(1)],[y(1)-5 y(1)], [z(1)-5 z(1)], 'r');
%chaser = patch([x(1)-5 x(1)-5 x(1) x(1)],[y(1)-5 y(1) y(1) y(1)-5],'r');
chaser = patch([x(1)-l x(1)-l x(1)+l x(1)+l],[y(1)-l y(1)+l y(1)+l y(1)-l],[z(1)-l z(1)+l z(1)+l z(1)-l], 'r');
target = patch([x(end)-l x(end)-l x(end)+l x(end)+l],[y(end)-l y(end)+l y(end)+l y(end)-l],[z(end)-l z(end)+l z(end)+l z(end)-l], 'g');
target2 = patch([x3(end)-l x3(end)-l x3(end)+l x3(end)+l],[y3(end)-l y3(end)+l y3(end)+l y3(end)-l],[z3(end)-l z3(end)+l z3(end)+l z3(end)-l], 'b');
target3 = patch([x5(end)-l x5(end)-l x5(end)+l x5(end)+l],[y5(end)-l y5(end)+l y5(end)+l y5(end)-l],[z5(end)-l z5(end)+l z5(end)+l z5(end)-l], 'c');
txt = '\leftarrow Target 1';
txt2 = '\leftarrow Target 2';
txt3 = '\leftarrow Target 3';
text(x(end),y(end),z(end),txt);
text(x3(end),y3(end),z3(end),txt2);
text(x5(end),y5(end),z5(end),txt3);
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
    plot3(x2(i), y2(i), z2(i), 'g.');
    drawnow;
end

r = length(x3);
for i=1:r
    chaser.XData=([x3(i)-l x3(i)-l x3(i)+l x3(i)+l]);
    chaser.YData=([y3(i)-l y3(i)+l y3(i)+l y3(i)-l]);
    chaser.ZData=([z3(i)-l z3(i)+l z3(i)+l z3(i)-l]);
    hold on;
    plot3(x3(i), y3(i), z3(i), 'k.');
    drawnow;
end

q = length(x4);
for i=1:q
    chaser.XData=([x4(i)-l x4(i)-l x4(i)+l x4(i)+l]);
    chaser.YData=([y4(i)-l y4(i)+l y4(i)+l y4(i)-l]);
    chaser.ZData=([z4(i)-l z4(i)+l z4(i)+l z4(i)-l]);
    hold on;
    plot3(x4(i), y4(i), z4(i), 'b.');
    drawnow;
end

q = length(x5);
for i=1:q
    chaser.XData=([x5(i)-l x5(i)-l x5(i)+l x5(i)+l]);
    chaser.YData=([y5(i)-l y5(i)+l y5(i)+l y5(i)-l]);
    chaser.ZData=([z5(i)-l z5(i)+l z5(i)+l z5(i)-l]);
    hold on;
    plot3(x5(i), y5(i), z5(i), 'k.');
    drawnow;
end

r = length(x6);
for i=1:r
    chaser.XData=([x6(i)-l x6(i)-l x6(i)+l x6(i)+l]);
    chaser.YData=([y6(i)-l y6(i)+l y6(i)+l y6(i)-l]);
    chaser.ZData=([z6(i)-l z6(i)+l z6(i)+l z6(i)-l]);
    hold on;
    plot3(x6(i), y6(i), z6(i), 'c.');
    drawnow;
end

