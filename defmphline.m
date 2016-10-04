%   name: defmphline
%
%   Defines matrix of handles 'hline' for
%   plot tools (customized for gridplot (mplot1.m)
% 
%  Version SWD970703
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

hline = [];

clear temp

for i = 1:length(haxes),
   temp{i} = flipud(get(haxes(i),'child'));
end

%
%  Check to make sure all items in hline are actually lines
%

p = 1;

for i = 1:length(temp),
   tt = temp{i};
   for j = 1:length(tt),
      if strcmp(get(tt(j),'type'),'line'),
         hline = [hline,tt(j)];
      end
      
   end
   
end


if exist('iptline')~=1,
 iptline =1;
end

h = size(hline,2);

if ishandle(hlegax), 
   temp = flipud(get(hlegax,'child'));

   p=1;

   for i = 1:length(temp),

 	if strcmp(get(temp(i),'type'),'line'),
		hline(p,h+1)=temp(i);
		p = p+1;
	end

   end

end

