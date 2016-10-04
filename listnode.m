%
%  Name: listnode.m
%
%  Usage: 
%
%  This m-file lists the nodes in 'Nodes' in the geometry editor listbox

%
%  Version SWD970405
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

%
%  Generate list of nodes
%

nodetstr = sprintf('%5s%9s%9s%9s%1s','Label','X','Y','Z','|');
nodestr = nodetstr;

for i=1:size(Nodes,1)
  nodestr = [nodestr, sprintf('%5.0f%9.2f%9.2f%9.2f%1s',Nodes(i,:),'|')];
end

%
%  Assign list to listbox
%

set(hlistbox,'string',nodestr)