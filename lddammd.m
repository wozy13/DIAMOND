function lddammd(pathname,filename)
%
%  Name:   lddammd
%
%  Usage:  lddammd
%
%  Loads the damaged modes for the Damage ID analysis
%

%  Version SWD970828
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

global DAMAGEID

eval(['load ',[pathname,filename]]);

if exist('MODES_STORE') == 1,
   
   DAMAGEID.dammode = MODES_STORE.modalvector;
   DAMAGEID.damFreq = MODES_STORE.Freq;
   DAMAGEID.damfile = filename;
   DAMAGEID.dampath = pathname;
   DAMAGEID.respDOF = MODES_STORE.respDOF;
   
else
   
   if exist('filename') == 1,
      
      DAMAGEID.damfile = filename;
      DAMAGEID.dampath = pathname;
      
   end
   
   if exist('Freq') == 1,
      
      DAMAGEID.damFreq = num2cell(Freq);
   
   end
   
   if exist('phir_resp') == 1,
            
      for i = 1:size(phir_resp,2),
         DAMAGEID.dammode{i} = phir_resp(:,i)';
      end

   end
   
   if exist('respDOF') == 1,
      
      DAMAGEID.respDOF = respDOF;

   end   
   
end

return