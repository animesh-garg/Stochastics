mu = [0 0]; 
sigma = [1 .9; .9 1]; 
delta = 0.5;
nsamples = 1000;
accept = 0;
x = zeros (nsamples,2);
sum = zeros (nsamples);
i =2;%vector counter

for j = 2:nsamples
    x(i,1) = x(i-1, 1) + rand*2*delta-delta;
    x(i,2) = x(i-1, 2) + rand*2*delta-delta;
    pi_i=  mvnpdf(x(i-1,:),mu,sigma);
    pi_j = mvnpdf(x(i,:),mu,sigma);
    alpha_ij = min(1, pi_j/pi_i);
    if (rand<= alpha_ij)
        accept = accept +1;
        sum (i) = (sum(i-1) + x(i,1) +x(i,2))/accept;
        i = i+1;
    end
    %disp(sum(i))
end

acc_prob = accept/nsamples;
disp(acc_prob)
plot (x(1:accept,1))
figure
plot (x(2:accept,1))
figure
plot (sum(1:accept))