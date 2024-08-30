function draw_linee(params,mat)

p.P1 = [[0;0;-params.d1;1] [0;0;0;1] [params.a1;0;0;1]];
p.P2 = [[0;0;0;1] [params.a2;0;0;1]];
p.P3 = [[0;0;0;1] [params.a3;0;0;1]];
p.P4 = [0;0;0;1];
p.P5 = [0;0;0;1];
p.P6 = [[0;0;0;1] [params.a6;0;0;1]];
p.P8 = [[0;0;0;1] [params.a8;0;0;1]];
p.P9 = [[0;0;0;1] [0;0;params.Ltool;1]];

P1w = mat.T1w*p.P1;
P2w = mat.T2w*p.P2;
P3w = mat.T3w*p.P3;
P4w = mat.T4w*p.P4;
P5w = mat.T5w*p.P5;
P6w = mat.T6w*p.P6;
P8w = mat.T8w*p.P8;
P9w = mat.T9w*p.P9;

Pw = [P1w P2w P3w P4w P5w P6w P8w P9w];

line(Pw(1,:),Pw(2,:),Pw(3,:),'linestyle','--','color','b','linewidth',1)
end