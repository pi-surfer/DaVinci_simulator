function q = invkinDaVinci(Ttw,p,lefty)
                                    
A = invT(p.T0w)*Ttw*invT(p.Ttn);

% centro flangia
x = A(1,4);
y = A(2,4);
z = A(3,4);

% parametri DH
a1 = p.a1;
a2 = p.a2;

% traslazione asse 3
q3 = p.d1 + p.d2 - p.d30 - z;

%verifica di raggiungibilità in z
if q3<0 | q3>p.q3max
    q = -1;
    return
end

%verifica di raggiungibilità in xy
distOP = sqrt(x^2+y^2);
if distOP > a1+a2
    q = -1;
    return
end

%verifica asse z
if abs(A(3,3)+1) > 1e-6
    q = -1;
    return
end

% traslazione asse 3
q3 = p.d1+p.d2-p.d30-z;

% angolo di gomito (in gradi)
q2 =((-1)^lefty)* acosd((x^2+y^2-a1^2-a2^2)/(2*a1*a2));

% il parametro lefty controlla la configurazione, ossia se si vuole braccio
% destro o sinistro. Esso assume valori 1 (braccio dx), 0 (braccio sx).

% angolo di spalla
beta = acosd((a1+a2*cosd(q2))/sqrt(x^2+y^2));
q1 = atan2d(y,x) - ((-1)^lefty)*beta;

% angolo flangia
q4 = q1+q2-atan2d(A(2,1),A(1,1));

% ricalcolo angoli [+/- 180°]
q1 = atan2d(sind(q1),cosd(q1));
q2 = atan2d(sind(q2),cosd(q2));
q4 = atan2d(sind(q4),cosd(q4));

% punto robot
q = [q1,q2,q3,q4]


