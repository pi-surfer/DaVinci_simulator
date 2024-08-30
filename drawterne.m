function drawterne(params,mat)

L=70;
disframe(params.T0w,L,'s')  % base robot
disframe(mat.T1w,L)         % terna 1  
disframe(mat.T2w,L)         % terna 2
disframe(mat.T3w,L)         % terna 3
disframe(mat.T4w,L)         % terna 4
disframe(mat.T5w,L)         % terna 5
disframe(mat.T6w,L)         % terna 6
disframe(mat.T7w,L)         % terna 7
disframe(mat.T8w,L)         % terna 8
disframe(mat.T9w,L)         % terna 9
disframe(mat.Ttw,L,'.')     % terna tool

end