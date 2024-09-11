%% ESERCITAZIONE 2022 07/12/2022

close all
clear
clc


%% Load dati DaVinci

load('DaVinci_mod.mat');
params.name='DaVinci';

[bed] = load('roboCouch.mat');

%% Dati robot

params.a0 = dati.ai(1);             %[mm]
params.a1 = dati.ai(2);             %[mm]
params.a2 = dati.ai(3);             %[mm]
params.a3 = dati.ai(4);             %[mm]
params.a4 = dati.ai(5);             %[mm]
params.a5 = dati.ai(6);             %[mm]
params.a6 = dati.ai(7);             %[mm]
params.a7 = dati.ai(8);             %[mm]
params.a8 = dati.ai(9);             %[mm]

params.d1 = dati.di(1);             %[mm]
params.d2 = dati.di(2);             %[mm]
params.d3 = dati.di(3);             %[mm]
params.d4 = dati.di(4);             %[mm]
params.d5 = dati.di(5);             %[mm]
params.d6 = dati.di(6);             %[mm]
params.d7 = dati.di(7);             %[mm]
params.d8 = dati.di(8);             %[mm]
params.d9 = dati.di(9);             %[mm]

params.alpha4 = dati.alphai(5);     %[°]
params.alpha5 = dati.alphai(6);     %[°]
params.alpha8 = dati.alphai(9);     %[°]

params.Ltool = dati.Ltool;          %[mm]

params.T0w = transE(0,0,0,0,0,0);
params.Ttn = transP(0,0,params.Ltool);
params.Tbw = transP(800,-800,500);


%% Cinematica diretta di posizione

q_closed = [params.d1*1.4 35 190 30 270 50 190 60 0];

q0 = [0 75 230 -30 240 50 190 60 0];        %arm0 
q0(1) = params.d1*1.4;

q1 = [0 -10 290 -110 200 50 190 60 0];       %arm1
q1(1) = params.d1*1.4;

q2 = [0 95 50+360 -70 340 10 220 60 0];         %arm2 
q2(1) = params.d1*1.4;

q3 = [0 60 80+360 -170 300 50 190 60 0];         %arm3 
q3(1) = params.d1*1.4;

% Calcolo delle matrici di trasformazione:

mat0 = fwdkinDaVinci_arms(q0,params,0);
mat1 = fwdkinDaVinci_arms(q1,params,1);
mat2 = fwdkinDaVinci_arms(q2,params,2);
mat3 = fwdkinDaVinci_arms(q3,params,3);


%% Visualizzazione dello schema del robot

hf = figure(1);
hf.Position = [70 40 1300 800];
clf
%hf.MenuBar = 'none';
hf.Name = sprintf('MODELLO DH ROBOT %s', params.name);
hf.NumberTitle = 'off';
hf.Color = 'w';
axis equal
view(30,20)
grid on
rotate3d on
xlabel 'x[mm]'
ylabel 'y[mm]'
zlabel 'z[mm]'
xlim(4000*[-0.5 0.5])
ylim(4000*[-0.5 0.5])
zlim(2500*[-0.05 0.8])

hold on 

% terne di riferimento:

disframe(eye(4),140,'o')    % world
drawterne(params,mat0)      % arm0
drawterne(params,mat1)      % arm1
drawterne(params,mat2)      % arm2
drawterne(params,mat3)      % arm3

% linee DH:

draw_linee(params,mat0)
draw_linee(params,mat1)
draw_linee(params,mat2)
draw_linee(params,mat3)


%% Visualizzazione del robot

Pbw = params.T0w*base.P;
hp0 = patch('faces',base.faces,'Vertices',Pbw(1:3,:)','facecolor',0.7*[1 1 1],'edgecolor','none','facealpha',0.75);

color0 = [0 0.6 0.9];
color1 = [1 0.2 0];
color2 = [1 0.7 0.2];
color3 = [0.4 0.8 0];

draw_link_arm(mat0,link,color0);
draw_link_arm(mat1,link,color1);
draw_link_arm(mat2,link,color2);
draw_link_arm(mat3,link,color3);

% Aggiunta lettino:

L = 70;
Pbw = params.Tbw*bed.link(6).P;
hp_bed = patch('faces',bed.link(6).faces,'Vertices',Pbw(1:3,:)','facecolor',0.95*[1 1 1],'edgecolor','none','facealpha',0.8);
disframe(params.Tbw,L);

light


%% Pianificazione di traiettoria

% Punti iniziale e finale:

Ttwi = transE(400,300,200,0,180,180);
Ttwf = transE(500,300,250,0,180,180);

q0i = q_closed;
q1i = q_closed;
q2i = q_closed;
q3i = q_closed;

q0f = q0;
q1f = q1;
q2f = q2;
q3f = q3;

% parametri della legge di moto:

T = 4;          %[s]
dt = 0.08;      %[s]
t = 0:dt:T;
N = length(t);

% legge normalizzata:

tau = t/T;
sigma = 3*tau.^2 - 2*tau.^3;
sigmap = 6*tau - 6*tau.^2;
sigmapp = 6 - 12*tau;

% traiettorie dei giunti:

dq0 = q0f - q0i;
Q0 = sigma'*dq0 + repmat(q0i,N,1);
Qp0 = sigma'*dq0/T;
Qpp0 = sigma'*dq0/(T^2);

dq1 = q1f - q1i;
Q1 = sigma'*dq1 + repmat(q1i,N,1);
Qp1 = sigma'*dq1/T;
Qpp1 = sigma'*dq1/(T^2);

dq2 = q2f - q2i;
Q2 = sigma'*dq2 + repmat(q2i,N,1);
Qp2 = sigma'*dq2/T;
Qpp2 = sigma'*dq2/(T^2);

dq3 = q3f - q3i;
Q3 = sigma'*dq3 + repmat(q3i,N,1);
Qp3 = sigma'*dq3/T;
Qpp3 = sigma'*dq3/(T^2);


%% Simulazione

hf = figure(1);
hf.Position = [70 40 1300 800];
clf
hf.MenuBar = 'none';
hf.Name = sprintf('MODELLO DH ROBOT %s', params.name);
hf.NumberTitle = 'off';
hf.Color = 'w';
axis equal
view(50,20)
grid on
rotate3d on
xlabel 'x[mm]'
ylabel 'y[mm]'
zlabel 'z[mm]'
xlim(4000*[-0.5 0.5])
ylim(4000*[-0.5 0.5])
zlim(2500*[-0.05 0.8])


writerObj = VideoWriter('Simulazione DaVinci multibraccio Gruppo 6','MPEG-4');
writerObj.FrameRate = round((N-1)/T)*2;
writerObj.Quality = 100;    % [%]
writerObj.open

for nf = 1:N
    
    q0 = Q0(nf,:);
    mat0 = fwdkinDaVinci_arms(q0,params,0); 
    
    q1 = Q1(nf,:);
    mat1 = fwdkinDaVinci_arms(q1,params,1); 
    
    q2 = Q2(nf,:);
    mat2 = fwdkinDaVinci_arms(q2,params,2); 
    
    q3 = Q3(nf,:);
    mat3 = fwdkinDaVinci_arms(q3,params,3); 

    cla
    hold on
    
    L = 70;
    disframe(eye(4),140,'o')        % world
    drawterne(params,mat0)          % arm0
    drawterne(params,mat1)          % arm1
    drawterne(params,mat2)          % arm2
    drawterne(params,mat3)          % arm3
    disframe(Ttwi,L,'o')            % terna partenza
    disframe(Ttwf,L,'*')            % terna arrivo

    Pbw = params.T0w*base.P;
    hp0 = patch('faces',base.faces,'Vertices',Pbw(1:3,:)','facecolor',0.7*[1 1 1],'edgecolor','none','facealpha',0.75);

    draw_link_arm(mat0,link,color0);
    draw_link_arm(mat1,link,color1);
    draw_link_arm(mat2,link,color2);
    draw_link_arm(mat3,link,color3);
    
    L = 70;
    Pbw = params.Tbw*bed.link(6).P;
    hp_bed = patch('faces',bed.link(6).faces,'Vertices',Pbw(1:3,:)','facecolor',0.95*[1 1 1],'edgecolor','none','facealpha',0.8);
    disframe(params.Tbw,L);
    
    light
    drawnow
    
    IM = getframe(hf);
    writeVideo(writerObj,IM.cdata);
    
end

writerObj.close

