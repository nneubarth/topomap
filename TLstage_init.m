
function TLstage_init
%ThorLabs apt dc servo controller and linear motorized stage
%ActiveX Matlab GUI
%initialization and stage homing

global h_control;
global h_stage_X;
global h_stage_Y;

figure_pos    = get(0,'DefaultFigurePosition'); 
figure_pos(3) = 540; % window size width
figure_pos(4) = 750; % height
 
f = figure('Position', figure_pos,...
           'Menu','None',...
           'Name','APT GUI');

h_control = actxcontrol('MG17SYSTEM.MG17SystemCtrl.1',[0 30 540 750 ], f);
 
h_control.StartCtrl;

user_data.h_control = h_control;
set(f, 'UserData', user_data);

[~, num_stage] = h_control.GetNumHWUnits(6, 0);
if num_stage ~= 2
    fprintf(['Check the number of connected stages (Found' num2str(num_stage) ')!\n']);
    return
end

% Get the serial numbers
SN_stage = cell(1,2);
for count = 1 : num_stage
    [~, SN_stage{count}] = h_control.GetHWSerialNum(6, count - 1, 0); % Get the serial number of the devices
end

h_stage_X = actxcontrol('MGMOTOR.MGMotorCtrl.1', [0 390 540 360], f);
SetMotor(h_stage_X, SN_stage{1});

h_stage_Y = actxcontrol('MGMOTOR.MGMotorCtrl.1', [0 30 540 360], f);
SetMotor(h_stage_Y, SN_stage{2});

user_data.h_stage_X = h_stage_X;
user_data.h_stage_Y = h_stage_Y;

set(f, 'UserData', user_data);
% Home the stage. First 0 is the channel ID (channel 1)
% second 0 is to move immediately
h_stage_X.MoveHome(0,0);
h_stage_Y.MoveHome(0,0);

h_stage_X.registerevent({'MoveComplete' 'MoveCompleteHandler'});
h_stage_Y.registerevent({'MoveComplete' 'MoveCompleteHandler'});

end

