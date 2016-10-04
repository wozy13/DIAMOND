function ldmodelmt(pathname,filename)
%
%  Name:   ldmodelmt
%
%  Usage:  ldmodelmt
%
%  Loads the model matrices for the model correlation analysis
%

%  Version SWD970915
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

global MODELCOR

eval(['load ',[pathname,filename]]);


if exist('filename') == 1,
   
   MODELCOR.modelmatfile = filename;
   MODELCOR.modelmatpath = pathname;
   
end

if exist('matrixDOF') == 1,
   
   MODELCOR.modelmatrixDOF = matrixDOF;
   
end

if exist('K') == 1,
   
   MODELCOR.modelK = K;
   
end

if exist('M') == 1,
   
   MODELCOR.modelM = M;
   
end

return