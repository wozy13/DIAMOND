function dellegend
%
%   Name: dellegend
%
%   Usage: dellegend
%
%   Deletes all existing legend text and legend lines
%

%
%  Version SWD970731
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

global DISPLAY

for id = 1:length(DISPLAY),
   
   delete(get(DISPLAY{id}.hlegax,'children'))
   
   %if ~isempty(find(strcmp(fieldnames(DISPLAY{id}),'hplttext')))
   %   if length(DISPLAY{id}.hplttext) > 2
   %      if ishandle(DISPLAY{id}.hplttext{3}),
   %         delete(DISPLAY{id}.hplttext{3})
   %         delete(DISPLAY{id}.hplttextln{3})
   %      end
   %   end
    %  if length(DISPLAY{id}.hplttext) > 1
     %    if ishandle(DISPLAY{id}.hplttext{2}),
      %     delete(DISPLAY{id}.hplttextln{2})
       %  end
     % end
     % if ishandle(DISPLAY{id}.hplttext{1}),
      %   delete(DISPLAY{id}.hplttext{1})
       %  delete(DISPLAY{id}.hplttextln{1})
     % end
  % end
   
end
