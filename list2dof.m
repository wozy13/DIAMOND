function pltvec = list2dof(DI,xfp,yfp,Nodes,nodevec)
%
%  Name:   list2dof
%
%  Usage:   pltvec = list2dof(DI,xfp,yfp,Nodes,nodevec)
%
%  Converts matrix DI into vector pltvec according to coordinate
%	matrices xfp and yfp and node ordering list 'nodevec'
%	'Nodes' is matrix of Node numbers and coordinates
%  

%  Version SWD970117
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

nr = size(DI,1);
nc = size(DI,2);

pltvec = zeros(nr*nc,1);

for i = 1:nr

   for j = 1:nc,

%  Find index of the node with these coordinates

    nrow = find(Nodes(:,2) == xfp(i,j) & Nodes(:,3) == yfp(i,j));

%  Locate this node in the nodevec ordering list

    nvrow = find(nodevec(:,1) == Nodes(nrow,1));

%  Assign the value from DI to the correct location in pltvec

    pltvec(nvrow,1) = DI(i,j);

   end

end

return
