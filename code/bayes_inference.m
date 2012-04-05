%parameters
mu_0 = 8; var_0 = 9; %var_0 = sigma_0^2
a_beta = 89/4; b_beta = 765/4;
a_eps = 130; b_eps = 2064;
Nj = 5; Ni = 20;
Z = csvread('../data/hw4data.csv');
nsamples =5000;

%initilize variables
mu = normrnd(mu_0, var_0);
var_beta = invgamrnd(a_beta, b_beta);
var_eps = invgamrnd(a_eps, b_eps);
beta = zeros(Ni,1);

X = zeros(nsamples, Ni+3);
X(1,:) = [beta' mu var_beta var_eps];


for i = 2: nsamples    
    
    %Generate Beta
    mean_beta = (((var_beta)* sum (Z,2))/(Nj*var_beta + var_eps)) + (((mu*var_eps)/(Nj*var_beta +var_eps))*ones(Ni,1));
    tempvar_beta = ((var_eps*var_beta)*(eye(Ni))/(Nj*var_beta + var_eps));
    beta = mvnrnd(mean_beta, tempvar_beta);
    
    %Generate mu
    mean_sigma = ((var_beta*mu_0)+(var_0* sum(beta)))/(Ni*var_0 + var_beta);
    tempvar_sigma = (var_beta*var_0)/(Ni*var_0 + var_beta);
    mu = normrnd (mean_sigma, tempvar_sigma);
    
    %Generate sigma_beta
    tempa_beta = a_beta + Ni/2;
    tempb_beta = b_beta + sumsqr(beta-mu)/2;
    var_beta = invgamrnd(tempa_beta,tempb_beta);
    
    %Generate sigma_eps
    tempa_eps = a_eps + Nj*Ni/2;
    tempZ = zeros(Ni,Nj);
    
    for j = 1:Nj
        for k = 1:Ni
            tempZ(k,j) = Z(k,j) - beta(k);
        end
    end
    
    tempb_eps = b_eps + sumsqr(tempZ)/2;
    var_eps = invgamrnd(tempa_eps, tempb_eps);
    
    X(i,:) = [beta mu var_beta var_eps];
end

Cum_X_beta1 = cumsum(X(:,1));
Cum_X_mu = cumsum(X(:,21));
Cum_X_var_beta = cumsum(X(:,22));
Cum_X_var_eps = cumsum(X(:,23));

Axis_X = [1:1:nsamples]';
Erg_X_beta1 =(Cum_X_beta1)./Axis_X;
Erg_X_mu =(Cum_X_mu)./Axis_X;
Erg_X_var_beta =(Cum_X_var_beta)./Axis_X;
Erg_X_var_eps =(Cum_X_var_eps)./Axis_X;

disp (Erg_X_mu(nsamples))
disp (Erg_X_var_beta(nsamples))
disp (Erg_X_var_eps(nsamples))
for i = 1:Ni
    Est_Beta(i) = sum(X(:,i))/nsamples;
    disp (Est_Beta(i))
end


figure(1)
subplot(2,2,1);plot (Axis_X, Erg_X_beta1)
title('Beta\_1')
subplot(2,2,2);plot (Axis_X, Erg_X_mu)
title('Mu')
subplot(2,2,3);plot (Axis_X, Erg_X_var_beta)
title('Sigma\_beta')
subplot(2,2,4);plot (Axis_X, Erg_X_var_eps)
title('Sigma\_eps')



