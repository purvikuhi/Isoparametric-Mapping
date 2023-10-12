	clear all;
    close all;
    clc;
	%Example 1
% 	xcoor = [0 2 4 4 4 2 0 0];
% 	ycoor = [0 0 0 1 2 2 2 1];

	%Example 2
	xcoor = [2 4 8 7.24264 5.65685 3.03553 1.41421 1.81066];
	ycoor = [0 0 0 3.24264 5.65685 3.03553 1.41421 0.81066];
	
	%Example 3
% 	a = 7.071067811865476;
% 	b = 10;
% 	xcoor = [-a 0 a b a 0 -a -b];
% 	ycoor = [-a -b -a 0 a b a 0];

% 	------------------Important--------------%
% 	       eta
% 	       ^
% 	       |
% 	       |
% 	       |
% 	7------6------5
% 	|             |
% 	|             |
% 	8             4------> xi
% 	|             |
% 	|             |
% 	1------2------3
% 	
% 	Coordinate of 8 node in parent element in paramteric coordinate system
% 	1(-1,-1)
% 	2(0,-1)
% 	3(1,-1)
% 	4(1,0)
% 	5(1,1)
% 	6(0,1)
% 	7(-1,1)
% 	8(-1,0)

	xi = sym('xi');
	eta = sym('eta');
	% 8 noded  Serendipity Elements Shape Function
	N1 = -0.25*(1-xi)*(1-eta)*(1+xi+eta);
	N2 = 0.5*(1-xi)*(1+xi)*(1-eta);
	N3 = -0.25*(1+xi)*(1-eta)*(1-xi+eta);
	N4 = 0.5*(1+xi)*(1+eta)*(1-eta);
	N5 = -0.25*(1+xi)*(1+eta)*(1-xi-eta);
	N6 = 0.5*(1-xi)*(1+xi)*(1+eta);
	N7 = -0.25*(1-xi)*(1+eta)*(1+xi-eta);
	N8 = 0.5*(1-xi)*(1+eta)*(1-eta);

	%Shape Function Verfication
	N = [subs(N1,{xi,eta},{-1,-1})
	subs(N2,{xi,eta},{0,-1})
	subs(N3,{xi,eta},{1,-1})
	subs(N4,{xi,eta},{1,0})
	subs(N5,{xi,eta},{1,1})
	subs(N6,{xi,eta},{0,1})
	subs(N7,{xi,eta},{-1,1})
	subs(N8,{xi,eta},{-1,0})]'

	x = xcoor*[N1;N2;N3;N4;N5;N6;N7;N8];
	y = ycoor*[N1;N2;N3;N4;N5;N6;N7;N8];

	points = length([-1:0.1:1]);
	x1 = zeros(points,1);
	y1 = zeros(points,1);
	%line 1
	counter = 1;
	for i=-1:0.1:1
		x1(counter) = subs(x,{xi,eta},{i,-1});
		y1(counter) = subs(y,{xi,eta},{i,-1});
		counter = counter + 1;
	end
	%line 2
	x2 = zeros(points,1);
	y2 = zeros(points,1);
	counter = 1;
	for i=-1:0.1:1
		x2(counter) = subs(x,{xi,eta},{1,i});
		y2(counter) = subs(y,{xi,eta},{1,i});
		counter = counter + 1;
	end
	%line 3
	x3 = zeros(points,1);
	y3 = zeros(points,1);
	counter = 1;
	for i=-1:0.1:1
		x3(counter) = subs(x,{xi,eta},{i,1});
		y3(counter) = subs(y,{xi,eta},{i,1});
		counter = counter + 1;
	end

	%line 4
	x4 = zeros(points,1);
	y4 = zeros(points,1);
	counter = 1;

	for i=-1:0.1:1
		x4(counter) = subs(x,{xi,eta},{-1,i});
		y4(counter) = subs(y,{xi,eta},{-1,i});
		counter = counter + 1;
	end

	[x1 y1];
	[x2 y2];
	[x3 y3];
	[x4 y4];
	figure
	plot(x1,y1,'-r*');
	hold on;
	plot(x2,y2,'-r*');
	hold on
	plot(x3,y3,'-r*');
	hold on
	plot(x4,y4,'-r*');
	hold on
    for i=1:length(xcoor)
    text(xcoor(i),ycoor(i),num2str(i,'%d'),'Color', 'b','FontSize', 18);
    end
    hold off
    xlabel('x');
    ylabel('y');
    
    if(~exist('plots','dir'))
    mkdir('plots')
    end
    
    saveas(gcf,fullfile(pwd,'plots','8 noded xy geometry'),'fig');
    saveas(gcf,fullfile(pwd,'plots','8 noded xy geometry'),'epsc');
    saveas(gcf,fullfile(pwd,'plots','8 noded xy geometry'),'jpg');
    saveas(gcf,fullfile(pwd,'plots','8 noded xy geometry'),'pdf');
	%--------------Program End----------------%