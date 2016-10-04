function drawbars(Bars,Nodes,labflg,ax,rgb,style,nfontsz)
%
%  Name: drawbars
% 
%  Usage: drawbars(Bars,Nodes,labflg,ax,rgb,style,nfontsz)
% 
%   Description:
%      Draws lines to represent
%      the bar connectivity in 'Bars'
%      'Nodes' is the node list
%      'ax' is axis handle
%      'rgb' is color vector
%      'labflg' flag controls display of labels
%      'style' is linestyle string

%  Version SWD970805
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

if ~exist('nfontsz'), nfontsz=14; end

axes(ax)

for i = 1:size(Bars,1),

   n1 = Bars(i,2);
   n2 = Bars(i,3);

%  Find locations of end-nodes in Node list

   in1 = find(Nodes(:,1) == n1);
   in2 = find(Nodes(:,1) == n2);

   if isempty(in1) | isempty(in2), disp('ERROR: DRAWBARS -- Node Label is in Bars but not in Nodes'), end

   h = line([Nodes(in1,2) Nodes(in2,2)], [Nodes(in1,3) Nodes(in2,3)], [Nodes(in1,4) Nodes(in2,4)] );

   set(h,'Color',rgb)
   set(h,'LineStyle',style)
   set(h,'linewidth',1)

   if labflg,
	tx = (Nodes(in2,2) + Nodes(in1,2))/2;
	ty = (Nodes(in2,3) + Nodes(in1,3))/2;
	tz = (Nodes(in2,4) + Nodes(in1,4))/2;
	ht = text(tx,ty,tz,num2str(Bars(i,1)));
	set(ht,'FontSize',nfontsz)
	set(ht,'FontWeight','bold')
	set(ht,'VerticalAlignment','bottom')
	set(ht,'Color',rgb)
   end
end

return
