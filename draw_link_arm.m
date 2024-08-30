function draw_link_arm(mat,link,color)
%disegno links del braccio, esclusa la base del robot
%link1
P1w=mat.T1w*link(1).P;
hp1=patch('faces',link(1).faces,'Vertices',P1w(1:3,:)','facecolor',color,'edgecolor','none','facealpha',0.65);


%link2
P2w=mat.T2w*link(2).P;
hp2=patch('faces',link(2).faces,'Vertices',P2w(1:3,:)','facecolor',color,'edgecolor','none','facealpha',0.65);


%link3
P3w=mat.T3w*link(3).P;
hp3=patch('faces',link(3).faces,'Vertices',P3w(1:3,:)','facecolor',color,'edgecolor','none','facealpha',0.65);


%link4
P4w=mat.T4w*link(4).P;
hp4=patch('faces',link(4).faces,'Vertices',P4w(1:3,:)','facecolor',color,'edgecolor','none','facealpha',0.65);


%link5
P5w=mat.T5w*link(5).P;
hp5=patch('faces',link(5).faces,'Vertices',P5w(1:3,:)','facecolor',color,'edgecolor','none','facealpha',0.65);


%link6
P6w=mat.T6w*link(6).P;
hp6=patch('faces',link(6).faces,'Vertices',P6w(1:3,:)','facecolor',color,'edgecolor','none','facealpha',0.65);


%link7
P7w=mat.T7w*link(7).P;
hp7=patch('faces',link(7).faces,'Vertices',P7w(1:3,:)','facecolor',color,'edgecolor','none','facealpha',0.65);


%link8
P8w=mat.T8w*link(8).P;
hp8=patch('faces',link(8).faces,'Vertices',P8w(1:3,:)','facecolor',color,'edgecolor','none','facealpha',0.65);


%link9
P9w=mat.T9w*link(9).P;
hp9=patch('faces',link(9).faces,'Vertices',P9w(1:3,:)','facecolor',color,'edgecolor','none','facealpha',0.65);

end