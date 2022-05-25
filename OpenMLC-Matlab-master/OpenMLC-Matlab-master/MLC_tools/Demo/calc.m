function u(block)
% Level-2 MATLAB file S-Function for times two demo.

%   Copyright 1990-2009 The MathWorks, Inc.

setup(block);

%endfunction

function setup(block)

%% Register number of input and output ports
block.NumInputPorts  = 2;
block.NumOutputPorts = 1;

%% Setup functional port properties to dynamically
%% inherited.
block.SetPreCompInpPortInfoToDynamic;
block.SetPreCompOutPortInfoToDynamic;

block.InputPort(1).DirectFeedthrough = true;
block.InputPort(2).DirectFeedthrough = true;


%% Set block sample time to inherited
block.SampleTimes = [-1 0];

%% Set the block simStateCompliance to default (i.e., same as a built-in block)
block.SimStateCompliance = 'DefaultSimState';

%% Run accelerator on TLC
block.SetAccelRunOnTLC(true);

%% Register methods
block.RegBlockMethod('Outputs',                 @Output);

%endfunction

function Output(block)
if toc>20
crash
end 
func=evalin('base','m');
Nfunk=eval(['@(S0,S1) '  func]);
block.OutputPort(1).Data =Nfunk(block.InputPort(1).Data,block.InputPort(2).Data);

%endfunction

