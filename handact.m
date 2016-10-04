function onHndlVector=handact(offHndlVector,hndlMatrix,ihndl)
%
%  Name:   handact
%
%  Usage:  onHndlVector=handact(offHndlVector,hndlMatrix,ihndl)
%
%  this function to turn off handles and turn on new ones
%
%   ihndl=1:  Plot buttons
%   ihndl=2:  Peak picking buttons
%   ihndl=3:  Rational Polynomial buttons
%   ihndl=4:  ERA buttons
%   ihndl=5:  Damage index methods buttons
%
%  Version SWD960625
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

if exist('offHndlVector')~=1,
    offHndlVector=hndlMatrix(1,:);
    offHndlVector(find(offHndlVector==0))=[];
end
onHndlVector=hndlMatrix(ihndl,:);
onHndlVector(find(onHndlVector==0))=[];
for i=1:length(offHndlVector) 
   if ishandle(offHndlVector(i))==1      
        hideall(offHndlVector(i))
   end;
end;

for i=1:length(onHndlVector) 
   if ishandle(onHndlVector(i))==1
	showall(onHndlVector(i))
   end;
end;
