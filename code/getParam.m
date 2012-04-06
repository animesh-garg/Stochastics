function [ State_space, Y, T, P, lambda] = getParam(Y1,Y2, obs_type )
% Assign parameters acc. to observation type.


switch obs_type
    case 1
        State_space = [1; 2 ; 3 ; 4];
        T = size(Y1,1);
        P = [0.98   0.02    0   0
            0   0.9 0.08    0.02
            0   0   0.8 0.2
            0   0   0   1];
        lambda = [1/3 1/4 1/5 1/6];
        Y = Y1;
    case 2
        State_space = [1; 2 ; 3 ; 4];
        T = size(Y2,1);
        P = [0.98   0.02    0   0
            0   0.9 0.08    0.02
            0   0   0.8 0.2
            0   0   0   1];
        lambda = [1/2 1/4 1/6 1/8];
        Y = Y2;
end

end

