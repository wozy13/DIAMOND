function listdof
%
%  Name: listdof.m
%
%  Usage: 
%
%  This m-file lists the dof in 'EDITDOF.respDOF' in the DOF editor listbox

%
%  Version SWD970806
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

global HANDLES EDITDOF

%
%  Generate list of nodes
%

EDITDOF.titlestr = sprintf('%9s%9s%9s%1s','Channel','Node','DOF','|');
bodystr = EDITDOF.titlestr ;

for i=1:size(EDITDOF.respDOF,1)
  bodystr = [bodystr, sprintf('%9.2f%9.2f%9.2f%1s',i,EDITDOF.respDOF(i,:),'|')];
end

%
%  Assign list to listbox
%

set(HANDLES.hmakedof(6),'string',bodystr)

return