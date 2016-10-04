function damscale(haxes,DImat)
%
%  Name: damscale
% 
%  Usage: 
%
% 
%  Description:
%     Plot legend of DI values corresponding
%     to shading colors for damage indicator plots
%
%  Inputs:
%
%  haxes   = Handle of axes for legend plot
%  DImat = matrix of Damage indicator values

%  Version SWD970703
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

axes(haxes)
cla

%  Define the colors from the colormap

map = colormap;

%  Set the number of segments

nsegtot = size(map,1);
nseg = 8;

%  Compute full range of DI

dimin = min(min(min(DImat)));
dimax = max(max(max(DImat)));

distep = (dimax - dimin) / nseg;

%  Loop over the number of segments

for iseg = 1:nseg
   
%  Determine the color of the segment;
   
   segcolor = map(round(iseg/nseg*nsegtot),:);
   
   %  Draw the line segment of appropriate color
   
   p1 = dimin + (iseg-1) * distep;
   p2 = dimin + iseg * distep;
   
   h = line([p1 p2],[0 0]);
      
   set(h,'linewidth',8,'color',segcolor)
   
end

set(haxes,'yticklabel','')

title('Damage Indicator Scale')

return


