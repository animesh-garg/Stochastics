clear all
%parameters
N = 10;%no. of servers
c = 10; %no. of customers
nsamples =15000;

%initilize variables
x = ones(nsamples, c);
x(1,:) = 1;

%calculate lambda_i
lambda = ones(N,1); %Since symmentric cyclic chain.
for i = 1:N
    mu(i)= 1/((0.5*i)+5);
    nu(i) = lambda(i)/mu(i);
end


for j = 2: nsamples    
    
    %Generate 
    for i = 1: c-1
        domain_x = c - sum(x(j,1:c-1))+ x(j,i);
        
        %calculate probability
        for ni = 1:(domain_x+1)
            Qi_ni(ni)= (nu(i)/nu(c))^(ni-1);
        end
        sum_prob = sum(Qi_ni);
        
        %cond prob
        for ni = 1:(domain_x+1)
            Prob_ni(ni) = Qi_ni(ni)/sum_prob;
        end
        
        temp = rand;
        cum_prob = cumsum(Prob_ni);
        
        set_flag=0;
        for ni = 1:(domain_x+1)
            if(temp<=cum_prob(ni) && set_flag ==0)
                x(j,i)= ni-1;     
                set_flag=1;
            end;
        end   
    end
    
    %update the 10th station
    x(j,c) = c-sum(x(j,1:c-1));
    
    %update next line
    if (j ~= nsamples)
        x(j+1,:)= x(j,:);
    end
end
   
Cum_X = cumsum(x);
Axis_X = [1:1:nsamples]';
for i = 1:c
    Erg_X(:,i) =(Cum_X(:,i))./Axis_X;    
end

variance_x = var(x,0,1);

plot(Erg_X,'DisplayName','Erg_X','YDataSource','Erg_X');figure(gcf)

disp('Expected value=')
disp(Erg_X(nsamples,:))
disp('Variances=')
disp(variance_x)

% 
% 
% figure
% subplot(2,2,1);plot (Axis_X, Erg_X_beta1)
% title('Beta\_1')
% subplot(2,2,2);plot (Axis_X, Erg_X_mu)
% title('Mu')
% subplot(2,2,3);plot (Axis_X, Erg_X_var_beta)
% title('Sigma\_beta')
% subplot(2,2,4);plot (Axis_X, Erg_X_var_eps)
% title('Sigma\_eps')



