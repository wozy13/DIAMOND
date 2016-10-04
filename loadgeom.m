function loadgeom(pathname,filename)
%
%  Name:   loadgeom
%
%  Usage:  loadgeom
%
%  Loads the geometry variables into their proper variablenames
%

%  Version SWD970804
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

global GEOM

eval(['load ',[pathname,filename]]);

if exist('GEOM_STORE') == 1,
    
   GEOM = GEOM_STORE;
   GEOM.filename = filename;
   GEOM.pathname = pathname;  
   
else
   
   if exist('filename') == 1,
      
      GEOM.filename = filename;
      GEOM.pathname = pathname;
   
   end
   
   if exist('Nodes') == 1,
      GEOM.Nodes = Nodes;
   else
      GEOM.Nodes = [];
      warndlg('WARNING: No Nodes defined in this geometry file')
   end
   
   if exist('Bars') == 1,
      GEOM.Bars = Bars;
   else
      GEOM.Bars = [];
      warndlg('WARNING: No display connectivity (Bars) defined in this geometry file')
   end
   
   if exist('Shells') == 1,
      GEOM.Shells = Shells;
   else
      GEOM.Shells = [];
   end
   
   if exist('SEMbeams') == 1,
      GEOM.SEMbeams = SEMbeams;
   else
      GEOM.SEMbeams = {};
   end
   
   if exist('SEMquads') == 1,
      GEOM.SEMquads = SEMquads;
   else
      GEOM.SEMquads = {};
   end
      
end

return