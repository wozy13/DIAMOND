function hideall(handle)
%
%  Name:   hideall
%
%  Usage:  hideall(handle)
%
%  Purpose: Hides the object in 'Handle' and all 
%	of its children
%
%  Version SWD970804
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

for j = 1:length(handle),
   
   if ishandle(handle(j)),
      
      %  Hide parent
      set(handle(j),'visible','off')
      %  If it's an axis, hide the title

      if strcmp(get(handle(j),'type'),'axes')
         ht = get(handle(j),'title');
         if ~isempty(ht),
            if ishandle(ht),  set(ht,'visible','off'), end
         end

         %  Get vector of children's handles

         chand = get(handle(j),'children');

         if ~isempty(chand),

            for i = 1:length(chand),
            
               set(chand(i),'visible','off')

            end

         end

      end
   
   end
   
end

return