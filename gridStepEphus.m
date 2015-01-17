function [ output_args ] = gridStepEphus(varargin)
%GRIDSTEPEPHUS: to be called from ephus userFcns GUI by
%the xsg:Save event. 
evalin('base',['gridStep(stest,gtest)']); %change stest and gtest to your stage and grid names, respectively
end

