function m = fwdkinDaVinci_arms(q,p,i)

% cinematica diretta del DaVinci:

alpha0 = 0+i*90;

% trasformazioni relative:

m.T10 = transDH(0,p.a0,alpha0,q(1));
m.T21 = transDH(0,p.a1,q(2),p.d2);
m.T32 = transDH(0,p.a2,q(3),p.d3);
m.T43 = transDH(0,p.a3,q(4),p.d4);
m.T54 = transDH(p.alpha4,0,q(5),p.d5);
m.T65 = transDH(p.alpha5,0,q(6),0);
m.T76 = transDH(0,p.a6,q(7),0);
m.T87 = transDH(0,p.a7,q(8),0);
m.T98 = transDH(p.alpha8,p.a8,0,p.d9+q(9));

% trasformazioni assolute:

m.T1w = p.T0w*m.T10;
m.T2w = m.T1w*m.T21;
m.T3w = m.T2w*m.T32;
m.T4w = m.T3w*m.T43;
m.T5w = m.T4w*m.T54;
m.T6w = m.T5w*m.T65;
m.T7w = m.T6w*m.T76;
m.T8w = m.T7w*m.T87;  
m.T9w = m.T8w*m.T98;

% trasformazione tool/world Ttw:

m.Ttw=m.T9w*p.Ttn;

end
