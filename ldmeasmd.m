function ldmeasmd(pathname,filename)
%
%  Name:   ldmeasmd
%
%  Usage:  ldmeasmd
%
%  Loads the measured modes for the model correlation analysis
%

%  Version SWD980701
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
   
   MODELCOR.measmode = MODES_STORE.modalvector;
   MODELCOR.measFreq = MODES_STORE.Freq;
   MODELCOR.measmodefile = filename;
   MODELCOR.measmodepath = pathname;
   MODELCOR.measmoderespDOF = MODES_STORE.respDOF;
   
else
   
   if exist('filename') == 1,
      
   MODELCOR.measmodefile = filename;
   MODELCOR.measmodepath = pathname;
      
   end
   
   if exist('Freq') == 1,
      
   MODELCOR.measFreq = num2cell(Freq);
   
   end
   
   if exist('phir_resp') == 1,
            
      for i = 1:size(phir_resp,2),
         MODELCOR.measmode{i} = phir_resp(:,i)';
      end

   end
   
   if exist('respDOF') == 1,
      
      MODELCOR.measmoderespDOF = respDOF;

   end   
   
end

return