
clear all
close all
 %% Read Data and Get Parameter
[Y1,Y2, X] = getData(); 
% The last parameter of getParam specifies 1 or 2 depending on which set of
% data you use for getting parameters.
[State_space,Y,T,P,lambda] = getParam(Y1,Y2, 2);
Q = P; %this is an assumption
%% For iteration t

% initial prediction
P_p = zeros (T+1,size(State_space));
P_f = zeros (T+1,size(State_space));
P_p(1,:) = [1 0 0 0];
P_f(1,:) = [1 0 0 0];

for t = 2: T
    % Filter at t
     % Predict for t+1
    for k = 1:  size(State_space);
        for j = 1:  size(State_space);
            P_p (t, k) =  P_p (t, k)+ Q(j,k)*P_f(t-1, j);
        end
    end
    
    % Get likelihood- Poisson in our case.
    for i = 1: size(State_space);
        lkhd(i) = poisspdf(Y(t), 1/lambda(i));
    end

    for i = 1:  size(State_space);
        P_f(t, i) = lkhd (i)* P_p(t-1, i);
    end

    %normalize filter update
    nu = sum (P_f(t,:));
    P_f(t,:) = P_f(t,:)./nu;
end


%% Smooth
P_s = zeros (T+1,size(State_space));
P_s (T,:) = P_f (T,:);

for t = T-1:-1: 2
    % Smooth at t=T
     % Predict for t+1
    for k = 1:  size(State_space);
        for j = 1:  size(State_space);
            P_s (t, k) =  P_s (t, k)+ (Q(k,j)*P_f(t,k)*P_s(t+1, j))/P_p(t+1,j);
        end
    end 
end

%% Use Chapman-Kolmogorov for calculating the actual transitions

X1 = [1 0 0 0];
P_ij = zeros(T, size(State_space));
for i =  2: T
    P_ij (i,:) = X1*(Q^i);
end

