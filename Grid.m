classdef Grid < handle
    properties (Hidden)
        stepSize
        xSize
        ySize
        gridPosition
        xGrid
        yGrid
    end
    methods
        function G = Grid(stepSize,xSize,ySize)
            % generate grid object
            %jogstep is desired jog step size in mm, x and y are dimensions
            %of grid in mm
            %must position stage at upper lefthand corner of grid
            global h_stage_X;
            global h_stage_Y;
            
            startx = h_stage_X.GetPosition_Position(0); %returns absolute position in mm for x
            starty = h_stage_Y.GetPosition_Position(0);  % for y
            
            G.xSize = xSize;
            G.ySize = ySize; %x,y grid size in mm
            G.stepSize = stepSize;
            num_jogsx = floor(xSize/stepSize); %number of jogs per line
            num_jogsy = floor(ySize/stepSize);
            G.xGrid = repmat(-stepSize*(0:1:floor(xSize/stepSize)),num_jogsx+1,1)' + startx;
            G.yGrid = repmat(-stepSize*(0:1:(floor(ySize/stepSize))),num_jogsy+1,1) + starty;
            if sum(G.xGrid(:) < 0) > 0
                exception = MException('GridGenerator:OutOfBoundsX', ...
                    'Grid is out of bounds in x dimension. Change start position of stages or change grid size. ');
                throw(exception);
            else if sum(G.yGrid(:) < 0) > 0
                    exception = MException('GridGenerator:OutOfBoundsY', ...
                        'Grid is out of bounds in y dimension. Change start position of stages or change grid size. ');
                    throw(exception);
                end
            end
            G.gridPosition = 1; % start position
        end
        function incrementGrid(G,steps)
            G.gridPosition = G.gridPosition + steps;
        end
    end
end