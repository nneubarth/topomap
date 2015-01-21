function varargout = listenUpdateGrid(varargin)
%when grid moves get grid position
global gtest
global gridplot
pos = gtest.gridPosition;
xloc = gtest.xGrid(pos-1);
yloc = gtest.yGrid(pos-1);
hold on
plot(gridplot,xloc,yloc,'ro',...
  'MarkerSize'      , 10, ...
  'MarkerEdgeColor' , [1 0 0]  , ...
  'MarkerFaceColor' , [1 0 0]  );
hold off
%str = num2str(rto.OutputPort(1).Data);
%get a handle to the GUI's 'current state' window
%statestxt = findobj('Tag','curState');
%update the gui
%set(statestxt,'string',str);

end