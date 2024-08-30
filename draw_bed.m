function draw_bed(params)
load('roboCouch.mat')
L=70;
Pbedw=params.Tbedw*link(6).P;
hp_bed=patch('faces',link(6).faces,'Vertices',Pbedw(1:3,:)','facecolor',0.95*[1 1 1],'edgecolor','none','facealpha',0.75);
disframe(params.Tbedw,L)
end
