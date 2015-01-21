stagetools
=============
package for controlling two Thorlabs linear motorized stages 

**StageGUI:** class for creating, controlling, and tracking ThorLabs stages. 

**Grid:** class for creating a custom grid on which to move the stage. 

**moveComplete:** event handler for the MoveComplete event; can be used for triggering data acquisition. 

**gridStepEphus:** for use with ephus electrophysiology acquisition software

**gridgui:** GUI that creates Grid object according to user specifications and shows stage position in real-time

**listenUpdateGrid:** responds to IncrementGridPos event to update stage position on gridgui and saves acquisition numbers 
and grid coordinates to a .mat file for analysis 