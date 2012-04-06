function [ obs_noise , obs_better, actual ] = getData( )

% Import data from spreadsheet
% Script for importing data from the following spreadsheet:
%
%    Workbook: /media/Personal/Cal_Study/IEOR263B-sp12/hw/hw10/hw10data.xls
%    Worksheet: observations Y(t)
%
% To extend the code to different selected data or a different spreadsheet,
% generate a function instead of a script.

% Auto-generated by MATLAB on 2012/04/05 16:40:46

%funtion [Y] = observations ()

%% Noisy Data
%Import the data
[~, ~, raw] = xlsread('../data/hw10data.xls','observations Y(t)');
raw = raw(3:end,:);

% Replace non-numeric cells with 0.0
R = cellfun(@(x) ~isnumeric(x) || isnan(x),raw); % Find non-numeric cells
raw(R) = {0.0}; % Replace non-numeric cells

% Create output variable
obs_noise = cell2mat(raw);
obs_noise = obs_noise(:,2);
% Clear temporary variables
clearvars raw R;

%% Better Observation
%Import the data
[~, ~, raw] = xlsread('../data/hw10data.xls','better observations y(t)');
raw = raw(3:end,:);

% Replace non-numeric cells with 0.0
R = cellfun(@(x) ~isnumeric(x) || isnan(x),raw); % Find non-numeric cells
raw(R) = {0.0}; % Replace non-numeric cells

% Create output variable
obs_better = cell2mat(raw);
obs_better = obs_better(:,2);
% Clear temporary variables
clearvars raw R;%% Import the data

%% Actual Data
%Import the data
[~, ~, raw] = xlsread('../data/hw10data.xls','hidden state x(t)');
raw = raw(3:end,:);

% Create output variable
actual = cell2mat(raw);
actual = actual(:,2);
% Clear temporary variables
clearvars raw;

end
