%
%  Name: DIAMOND
%
%  this sets up the main menu structure for analyzing
%  dynamic data to attempt to located damage
%
%  Version SWD980224
%
%
%  Copyright (c) 1996-1998, The Regents of the University
%       of California. This software was produced under
%       a U.S. Government contract (W-7405-ENG-36) by 
%       Los Alamos National Laboratory, which is operated
%       by the University of California for the U.S.
%       Department of Energy. The U.S. Government is 
%       licensed to use, reproduce, and distribute this
%       software. Permission is granted to the public to
%       copy and use this software without charge, provided
%       that this Notice and any statement of authorship
%       are reproduced on all copies. Neither the Government
%       nor the University makes any warranty, express or
%       implied, or assumes any liability or responsibility
%       for the use of this software.
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
% SET GLOBAL WORKSPACE DEFAULTS
%
set(0,'DefaultUIcontrolUnits','normal')

colordef none

%
% Define GLOBAL VARIABLES
%

global DATA DISPLAY HANDLES MODES GEOM VIEWMODES EDITGEOM EDITDOF DAMAGEID MODELCOR
global iaxesvec indsvec iaxes inds imode pathname sys simplot

diamondsetup
