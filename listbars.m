%
%  Name: listbars.m
%
%  Usage: 
%
%  This m-file lists the bars in 'Bars' in the geometry editor listbox

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
%  Generate list of bars
%

bartstr = sprintf('%5s%9s%9s%1s','Label','Node 1','Node 2','|');
barstr = bartstr;

for i=1:size(Bars,1)
  barstr = [barstr, sprintf('%5.0f%9.0f%9.0f%1s',Bars(i,:),'|')];
end

%
%  Assign list to listbox
%

set(hlistbox,'string',barstr)