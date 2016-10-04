function [filename,pathname,error] = loadfile(nfiletype,cdir)
%
%  Name:  loadfile
% 
%  Usage: loadfile(nfiletype,cdir)
% 
%   Description:
%      Opens a dialog box and applies
%      the appropriate file suffix filter
%      'nfiletype' is numeric file type:
%     0 = Data File
%  	1 = Modes File
%		2 = Geometry File
%		3 = Damage Analysis File
%		4 = Universal File
%
%      'cdir' is the directory to start in

%  Version SWD970904
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This matlab source code was originally     %
% developed as part of "DIAMOND" at          %
% Los Alamos National Laboratory. It may     %
% be copied, modified, and distributed in    %
% any form, provided:                        %
%  a) This notice accompanies the files and  %
%     appears near the top of all source     %
%     code files.                            %
%  b) No payment or commercial services are  %
%     received in exchange for the code.     %
%                                            %
% Original copyright is reserved by the      %
% Regents of the University of California,   %
% in addition to Scott W. Doebling, Phillip  %
% J. Cornwell, Erik G. Straser, and Charles  %
% R. Farrar.                                 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%
%  Set file suffix filter
%

if nfiletype == 0,
%   csuf = '*_data.mat';
   csuf = '*.mat';
elseif nfiletype == 1,
%   csuf = '*_modes.mat';
   csuf = '*.mat';
elseif nfiletype == 2,
%   csuf = '*_geom.mat';
   csuf = '*.mat';
elseif nfiletype == 3,
%   csuf = '*_dam.mat';
   csuf = '*.mat';
elseif nfiletype == 4,
   csuf = '*.unv; *.uff';
else
   disp('ERROR: LOADFILES -- Numeric File type is invalid')
end

%csuf = '*.*';

%
%  Append directory to filter
%

if isunix,
  if cdir(length(cdir)) ~= '/',
    cdir = [cdir,'/'];
  end
else
   if cdir(length(cdir)) ~= '\',
    cdir = [cdir,'\'];
  end
end

cfilt = [cdir,csuf];

%
%  Call the gui file open function
%


[filename,pathname] = uigetfile(cfilt,'DIAMOND: LoadFile',150,150);

if filename == 0 | isempty(filename),
   error = 1;
else
   error = 0;
end

return
