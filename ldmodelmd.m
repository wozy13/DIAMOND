function ldmodelmd(pathname,filename)
%
%  Name:   ldmodelmd
%
%  Usage:  ldmodelmd
%
%  Loads the model modes for the model correlation analysis
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

if exist('MODES_STORE') == 1,
   
   MODELCOR.modelmode = MODES_STORE.modalvector;
   MODELCOR.modelFreq = MODES_STORE.Freq;
   MODELCOR.modelmodefile = filename;
   MODELCOR.modelmodepath = pathname;
   MODELCOR.modelmoderespDOF = MODES_STORE.respDOF;
   
else
   
   if exist('filename') == 1,
      
   MODELCOR.modelmodefile = filename;
   MODELCOR.modelmodepath = pathname;
      
   end
   
   if exist('Freq') == 1,
      
   MODELCOR.modelFreq = num2cell(Freq);
   
   end
   
   if exist('phir_resp') == 1,
      for i = 1:size(phir_resp,2),
         MODELCOR.modelmode{i} = phir_resp(:,i)';
      end
   end
   
   if exist('respDOF') == 1,
      
      MODELCOR.modelmoderespDOF = respDOF;

   end   
   
end

return