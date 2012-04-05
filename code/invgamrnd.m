function [ X ] = invgamrnd( a, b)
%INVGAMMA Summary of this function goes here
%   Detailed explanation goes here
    X = 1/(gamrnd(a, 1/b));

end

