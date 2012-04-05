lamda=1;
nsamples =50000;
c = 10;
x = zeros(5*nsamples,5);
%initialize with exponential variables
x(1,:)  =  [exprnd(lamda) exprnd(lamda) exprnd(lamda) exprnd(lamda) exprnd(lamda)];
k=1;
for i = 1: nsamples-1    
    for j = 1:5
        x(k+1,:) = x(k,:);
        if ((sum(x(k,:))- x(k,j))>c)
            x(k+1,j) = exprnd(lamda);
        else
            x(k+1,j)=(c- sum(x(k,:))+ x(k,j))+ exprnd(lamda);
        end
        k = k+1;
    end   
end

X_max = max(x,[],2);
X_min = min(x,[],2);

Cum_X_max = cumsum(X_max);
Cum_X_min = cumsum(X_min);
Axis_X = [1:1:(5*nsamples)]';
Erg_max_X =(Cum_X_max)./Axis_X;
Erg_min_X =(Cum_X_min)./Axis_X;

plot (Axis_X, Erg_max_X)
figure
plot (Axis_X, Erg_min_X)




