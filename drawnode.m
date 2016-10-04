function drawnode(Nodes,labflg,ax,rgb,nfontsz)
%
%  Name: drawnode
% 
%  Usage: drawnode(Nodes,labflg,ax,rgb,nfontsz)
% 
%   Description:
%      Plots a circle
%      at each node in the node list
%      contained in 'Nodes'
%      The flag 'labflg' controls
%      plotting of the node labels
%      'ax' is axis handle
%      'rgb' is the color vector
%      'nhlght' is vector of node labels to highlight

%  Version SWD970620
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

axes(ax)

h = plot3(Nodes(:,2),Nodes(:,3),Nodes(:,4),'.');

set(h,'Color',rgb)

if labflg,
   for i = 1:size(Nodes,1),
      ht = text(Nodes(i,2),Nodes(i,3),Nodes(i,4),num2str(Nodes(i,1)));
      set(ht,'FontSize',nfontsz)
      set(ht,'VerticalAlignment','bottom')
      set(ht,'Color',rgb)
      
      %if ~isempty(nhlght),
      %   if ~isempty(find(Nodes(i,1) == nhlght)),
      %      set(ht,'FontWeight','bold')
      %      set(ht,'Color','r')
      %   end
      %end
   end
end

return
