%% DaVinci GRUPPO 6

close all
clear
clc

%% Importazione modello 3D

load('DaVinci_mod.mat')
params.name = 'DaVinci';

%% dati robot

%ai
params.a0=dati.ai(1);
params.a1=dati.ai(2);
params.a2=dati.ai(3);
params.a3=dati.ai(4);
params.a4=dati.ai(5);
params.a5=dati.ai(6);
params.a6=dati.ai(7);
params.a7=dati.ai(8);
params.a8=dati.ai(9);
%di
params.d0=dati.di(1);
params.d1=dati.di(2);
params.d2=dati.di(3);
params.d3=dati.di(4);
params.d4=dati.di(5);
params.d5=dati.di(6);
params.d6=dati.di(7);
params.d7=dati.di(8);
params.d8=dati.di(9);
%alpha
params.alpha4=dati.alphai(5);
params.alpha5=dati.alphai(6);
params.alpha8=dati.alphai(9);
%Ltool
params.Ltool=dati.Ltool;

% posizione base robot rispetto a world (disegno)
params.T0w = transE(0,500,0,0,0,0);
% posizione tool rispetto a flangia
params.Ttn = transP(0,0,params.Ltool);
%posizione del lettino rispetto world
params.Tbedw = transP(600,200,500);

% coordinate libere
q =zeros(1,9);
%arm0
q0=q;
q0(1)=params.d0;  
q0(2:8)=0; 
q0(9)=0;
%arm1
q1=q;
q1(1)=params.d0;  
q1(2:8)=20; 
q1(9)=0;
%arm2
q2=q;
q2(1)=params.d0;  
q2(2:8)=10; 
q2(9)=0;
%arm3
q3=q;
q3(1)=params.d0;  
q3(2:8)=15; 
q3(9)=0;

%calcolo matrici di trasformazione
mat0=fwdkinDaVinci_arms(q0,params,0);
mat1=fwdkinDaVinci_arms(q1,params,1);
mat2=fwdkinDaVinci_arms(q2,params,2);
mat3=fwdkinDaVinci_arms(q3,params,3);

%% step 2
hf = figure(1);
clf
hf.MenuBar = 'none';
hf.Name = sprintf('MODELLO DH ROBOT %s',params.name);
hf.NumberTitle = 'off';
hf.Color = 'w';

% assi
axis equal
view(30,20)
grid on
rotate3d on
xlabel 'x[mm]'
ylabel 'y[mm]'
zlabel 'z[mm]'
hold on

% terne di riferimento
disframe(eye(4),140,'o') % world
drawterne(params,mat0)   %arm 0
drawterne(params,mat1)   %arm 1
drawterne(params,mat2)   %arm 2
drawterne(params,mat3)   %arm 3

%rappresento links
%base robot
Pbw=params.T0w*base.P;
hp0=patch('faces',base.faces,'Vertices',Pbw(1:3,:)','facecolor',0.95*[0 1 1],'edgecolor','none','facealpha',0.75);
draw_bed(params) %lettino

color0=0.95*[1 1 1];
color1=0.5*[1 1 0];
color2=0.25*[1 1 1];
color3=0.5*[0 0 1];

draw_link_arm(mat0,link,color0)
draw_link_arm(mat1,link,color1)
draw_link_arm(mat2,link,color2)
draw_link_arm(mat3,link,color3)

%linee DH
draw_linee(params,mat0)
draw_linee(params,mat1)
draw_linee(params,mat2)
draw_linee(params,mat3)

light
