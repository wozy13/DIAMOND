function loadmodes(pathname,filename)
%
%  Name:   loadmodes
%
%  Usage:  loadmodes
%
%  Loads the mode variables into their proper variablenames
%

%  Version SWD970805
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

global MODES

eval(['load ',[pathname,filename]]);

if exist('MODES_STORE') == 1,
    
   MODES = MODES_STORE;
   MODES.filename = filename;
   MODES.pathname = pathname;  
   
else
   
   if exist('filename') == 1,
      
      MODES.filename = filename;
      MODES.pathname = pathname;
   
   end
   
   if exist('Freq') == 1,
      
      MODES.Freq = num2cell(Freq);
      
   end
   
   if exist('Damp') == 1,
      
      MODES.Damp = num2cell(Damp);
      
   end
   
   if exist('phic_resp') == 1,
      
      for i = 1:size(phic_resp,2),
         
         MODES.residue{i} = phic_resp(:,i).';
         
      end
      
   end
   
   if exist('phir_resp') == 1,
      
      for i = 1:size(phir_resp,2),
         
         MODES.modalvector{i} = phir_resp(:,i).';
         
      end
      
   end
   
   if exist('phir_ref') == 1,
      
      for i = 1:size(phir_ref,2),
         
         MODES.mpf{i} = phir_ref(:,i).';
         
      end
      
   end
   
   if exist('respDOF') == 1,
               
      MODES.respDOF = respDOF;         
      
   end
      
   if exist('refDOF') == 1,
               
      MODES.refDOF = refDOF;
               
   end
   
end

return
