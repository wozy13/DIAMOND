%
%  Name: listSEMquads.m
%
%  Usage: 
%

%
%  Version SWD970707
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
%  Generate list of shells
%

sqtstr = sprintf('%15s','Label    Nodes|');
sqstr = sqtstr;

for i=1:length(SEMquads),
   sqstr = [sqstr,sprintf('%-6.0f',SEMquads{i}(1)),sprintf('%5.0f',SEMquads{i}(2:end)),'|'];
end

%
%  Assign list to listbox
%

set(hlistbox,'string',sqstr)