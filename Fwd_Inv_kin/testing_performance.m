load qtest.mat
load qgen.mat
load p_read.mat
load p_fwd.mat

qtest = qtest(:,1:30);
qgen = qgen(:,1:30);
p_read = p_read(:,1:30);
p_fwd = p_fwd(:,1:30);

qdiff = qgen-qtest;
pdiff = p_read- p_fwd;


for i=1:length(qdiff)
    figure(1)
    plot(i, qgen(1,i)-qtest(1,i),'xr','LineWidth',2);
    hold on
    plot(i, qgen(2,i)-qtest(2,i),'xg','LineWidth',2);
    hold on
    plot(i, qgen(3,i)-qtest(3,i),'xb','LineWidth',2);
    grid on
    axis([0 length(qdiff) -5 5])
    legend('q1diff','q2diff','q3diff')
    title('Difference between generated joint angles and Invkin joint angles')
    xlabel('Trial numbers')
    ylabel('q difference')
end

for i=1:length(pdiff)
    figure(2)
    plot(i, p_read(1,i)-p_fwd(1,i),'xr','LineWidth',2);
    hold on
    plot(i, p_read(2,i)-p_fwd(3,i),'xg','LineWidth',2);
    hold on
    plot(i, p_read(3,i)-p_fwd(3,i),'xb','LineWidth',2);
    grid on
    axis([0 length(pdiff) -10 10])
    legend('xdiff','ydiff','zdiff')
    title('Difference between fwdKin end effector position and Dobot end effector position')
    xlabel('Trial numbers')
    ylabel('p difference(mm)')
end