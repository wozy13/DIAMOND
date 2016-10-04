function Nodes = addnodes(Nodes,inode,ixnode,iynode,iznode)
%
%  Name: addnodes
% 
%  Usage:  Nodes = addnodes(Nodes,inode,ixnode,iynode,iznode)
% 
%   Description:
%     Updates Nodes list -- called
%     from GUI geometry definition function 
%     'generategeom'

%  Version SWD960321

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


if ~isempty(Nodes),

  rinode = find(Nodes(:,1) == inode);

else

  rinode = [];

end

if isempty(rinode),

%   This is a new node

   Nodes = [Nodes; inode, ixnode, iynode, iznode];

else

%   Replace an existing node

   Nodes(rinode,:) = [inode, ixnode, iynode, iznode];

end

return


