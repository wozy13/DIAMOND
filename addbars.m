function Bars = addbars(Bars,ibar,inode1,inode2)
%
%  Name: addbars
% 
%  Usage: Bars = addbars(Bars,ibar,inode1,inode2)
% 
%   Description:
%     Updates Bars list -- called
%     from GUI geometry definition function 
%     'generategeom'

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

if ~isempty(Bars),

  ribar = find(Bars(:,1) == ibar);

else

  ribar = [];

end

if isempty(ribar),

%   This is a new bar element

   Bars= [Bars; ibar, inode1, inode2];

else

%   Replace an existing bar element

   Bars(ribar,:) = [ibar, inode1, inode2];

end

return
