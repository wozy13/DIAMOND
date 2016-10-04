%
%  Name: listshls.m
%
%  Usage: 
%
%  This m-file lists the shells in 'Shells' in the geometry editor listbox

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
%  Generate list of shells
%

sbtstr = sprintf('%15s','Label    Nodes|');
sbstr = sbtstr;

for i=1:length(SEMbeams),
   sbstr = [sbstr,sprintf('%-6.0f',SEMbeams{i}(1)),sprintf('%5.0f',SEMbeams{i}(2:end)),'|'];
end

%
%  Assign list to listbox
%

set(hlistbox,'string',sbstr)