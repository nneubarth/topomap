function varargout = listenUpdateGrid(varargin)
%when grid moves get grid position
global gtest
global gridplot
global rfplot
global progmanagerglobal
global gridinfo
pos = gtest.gridPosition;
xloc = gtest.xGrid(pos-1);
yloc = gtest.yGrid(pos-1);
%show stage progress on gridgui
hold(gridplot);
plot(gridplot,xloc,yloc,'ro',...
    'MarkerSize'      , 10, ...
    'MarkerEdgeColor' , [1 0 0]  , ...
    'MarkerFaceColor' , [1 0 0]  );
hold(gridplot);
%binds acquisition numbers to grid and saves in appropriate folder
acqnum = str2num(progmanagerglobal.programs.xsg.xsg.variables.acquisitionNumber) - 1;
gridinfo.acqNum(pos-1) = acqnum;
if (pos-1) == length(gtest.xGrid(:))
    formatOut = 'yymmdd';
    fldr = datestr(now,formatOut);
    if exist(['\\research.files.med.harvard.edu\neurobio\GintyLab\Neubarth\ephus_data\' fldr],'dir') == 0
        mkdir(['\\research.files.med.harvard.edu\neurobio\GintyLab\Neubarth\ephus_data\' fldr])
    end
    savedirectory = ['\\research.files.med.harvard.edu\neurobio\GintyLab\Neubarth\ephus_data\' fldr];
    number = num2str(length(dir([savedirectory '\*.mat'])));
    fname = fullfile(savedirectory,['gridinfo' number]);
    save(fname,'gridinfo')
    hmvalues = RFmap;
    imagesc(hmvalues,'Parent',rfplot)

end
%str = num2str(rto.OutputPort(1).Data);
%get a handle to the GUI's 'current state' window
%statestxt = findobj('Tag','curState');
%update the gui
%set(statestxt,'string',str);

end