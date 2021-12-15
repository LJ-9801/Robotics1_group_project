function dobot = inv_kin(dobot)
    ex=[1;0;0]; ey=[0;1;0]; ez=[0;0;1]; zv=[0;0;0];
    p01 = dobot.P(:, 1); p12 = dobot.P(:, 2); p23 = dobot.P(:, 3); p34 = dobot.P(:, 4); p4T = dobot.P(:, 5);
    h1 = dobot.H(:, 1); h2 = dobot.H(:, 2);h3 = dobot.H(:, 3); h4 = dobot.H(:, 4);

    p0T = dobot.T(1:3, 4);
    q1sol=subprob4(-ez,ey,p0T-p01,ey'*(p23+p34+p4T));

    for i=1:2
        q3sol(:,i)=subprob3(ey,-p34,p23,norm(rot(h1,-q1sol(i))*(p0T-p01)-p4T));
        for j=1:2
            q2sol(j,i)=subprob1(ey,p23+rot(h3,q3sol(j,i))*p34 ...
                ,rot(h1,-q1sol(i))*(p0T-p01)-p4T);
        end
    end

    qsol=[q1sol(1) q1sol(1) q1sol(2) q1sol(2);
        q2sol(1,1) q2sol(2,1) q2sol(1,2) q2sol(2,2)
        q3sol(1,1) + q2sol(1,1), q3sol(2,1) + q2sol(2,1), q3sol(1,2) + q2sol(1,2), q3sol(2,2) + q2sol(2,2)];
    dobot.q = which_angles(dobot, qsol);
end