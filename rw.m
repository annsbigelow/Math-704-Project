clear
%Pearson's Random Walk
%A mosquito moves a fixed length with random angle
N=1000;
% length of the walk steps
a=0.1;
% store all x-y coords of locations
% Matlab's rand() creates a matrix storing random numbers uniformly
% distributed between 0 and 1.
angles=2*pi*rand(N,1);
steps=a*[cos(angles),sin(angles)];
walk=cumsum(steps,1);

% plot the locations
plot(walk(:,1),walk(:,2),"Color","blue","LineStyle","-")
hold on;
plot(walk(1,1),walk(1,2),"go",MarkerFaceColor="g")
plot(walk(end,1),walk(end,2),"ro",MarkerFaceColor="r")
title("A 2-D RW with step length $a=0.1$","Interpreter","latex");
hold off;
%Make a histogram estimating the distribution of the final position of many walkers
trials=10000;
R=zeros(N,1);
for k=1:trials
    % Do one walk
    angles=2*pi*rand(N,1);
    steps=a*[cos(angles),sin(angles)];
    walk=cumsum(steps,1);
    R(k)=norm(walk(end,:));
end

histogram(R,'Normalization','pdf');
hold on;
% Compare with Rayleigh's result
P=@(r)(2.*r./(N*a^2)).*exp(-r.^2./(N*a^2));
x=linspace(0,10,1000);
plot(x,P(x),"LineStyle","-","Color","red",'LineWidth',1.5);
axis([0,10,0,0.3]);
title("Approximation of Rayleigh's Result");
xlabel("$R$","Interpreter","latex");
ylabel("Frequency Density");
hold off;
%Sample the steps from a normal distribution
R=zeros(trials,1);
for k=1:trials
    % Do one walk with standard normally distributed steps
    % I can take the variance of the steps to be 1
    steps=randn(N,2);
    walk=cumsum(steps,1);
    R(k)=norm(walk(end,:));
end

histogram(R,'Normalization','pdf');
hold on;
% Compare with Rayleigh's result
% a^2 is now <r^2> where r is the length of the steps
lengths=zeros(N,1);
for i=1:N
    lengths(i)=norm(steps(i,:));
end
a=sqrt(mean(lengths.^2));
P=@(X)(2.*X./(N*a^2)).*exp(-X.^2./(N*a^2));
x=linspace(0,90,1000);
plot(x,P(x),"LineStyle","-","Color","red",'LineWidth',1.5);
axis([0,90,0,0.04]);
title("Normal Steps");
xlabel("$R$","Interpreter","latex");
ylabel("Frequency Density");
hold off;
