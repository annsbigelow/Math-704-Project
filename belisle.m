clear
% Now we're interested in the distribution of the angle, 
% which should converge to the standard hyperbolic secant distribution as discussed.
N=10000;
% Make a histogram estimating the distribution of the final angle of many walkers
trials=1000;
T=zeros(trials,1);
R = zeros(N,2);
walk = zeros(N,1);
% Start away from the origin, with the first angle 0 
r0 = 0.5;
for k=1:trials
    % Do one walk
    % The first angle is 0, ensuring that the expectation of the angle distribution is 0
    walk(1) = r0;
    for i=1:N-1
        R(i+1,:) = R(i,:) + randn(1,2);
        % Convert the steps into complex numbers so MATLAB can get the
        % angular component of each step
        walk(i+1) = complex(R(i+1,1),R(i+1,2));
    end
    angles = angle(walk);
    angles = unwrap(angles);
    % Take the final (total) angle
    T(k)=angles(end);
end

% apply scaling 
X = (2/log(N))*T;

histogram(X,'Normalization','pdf','BinWidth',0.2);
hold on;
% Compare with Belisle's result
a = -5.5;
b = 5.5;
P=@(x)sech(pi*x/2)/2;

the=linspace(a,b,1000);
plot(the,P(the),"LineStyle","-","Color","red",'LineWidth',1.5);
axis([a,b,0,0.5]);
title("Approximation of Belisle's Result");
xlabel("$X$","Interpreter","latex");
ylabel("Frequency Density");
hold off;