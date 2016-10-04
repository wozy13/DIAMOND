function configplttl(iaxes,inds)
%   Name: configplttl
%
%   Usage: configplttl
%
%   Description: Configures the plot tool to reflect the 
%      characteristics of the DISPLAY data
%   'iaxes' and 'inds' describe the default axes and plot line
%     for the plottool
%    
%     
%  Global Variables:
%   DISPLAY
%
%  Version SWD970807
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

global DISPLAY HANDLES iaxesvec indsvec

hplttl = HANDLES.hplttl;

%  Configure the Upper/Lower plot selector

naxes = length(iaxesvec);  % Number of plot axes visible

if naxes == 2,
   
    set(hplttl(24),'visible','on')
    set(hplttl(24),'value',iaxes)
    
else
    
   set(hplttl(24),'visible','off')
  
end

%  Configure the display function

set(hplttl(17:20),'visible','off')

switch DISPLAY{iaxes}.displayfun{inds},
   case 'SISO', set(hplttl(16),'value',1), set(hplttl(17:20),'visible','on')
   case 'CMIF', set(hplttl(16),'value',2),    
   case 'MIF', set(hplttl(16),'value',3)
   case 'APS', set(hplttl(16),'value',4)
   case 'MvMIF', set(hplttl(16),'value',5)
end   
   
%  Configure the spectral function popup

switch DISPLAY{iaxes}.specfun{inds},
   case 'FRF', set(hplttl(25),'value',1)
   case 'Coherence', set(hplttl(25),'value',2)
   case 'CPS', set(hplttl(25),'value',3)
   case 'PSD Resp', set(hplttl(25),'value',4), set(hplttl(19:20),'visible','off')
   case 'PSD Ref', set(hplttl(25),'value',5), set(hplttl(17:18),'visible','off')
   case 'Time History', set(hplttl(25),'value',6)
end
   
%  Configure iyscale and iylog

switch DISPLAY{iaxes}.iyscale,
case 'MAG', set(hplttl(14),'value',1)
case 'PHASE', set(hplttl(14),'value',2)
case 'REAL', set(hplttl(14),'value',3)
case 'IMAG', set(hplttl(14),'value',4)
end

set(hplttl(15),'value',DISPLAY{iaxes}.iylog)

%  Configure iresp and iref

set(hplttl(18),'string',num2str(DISPLAY{iaxes}.iresp{inds}) )
set(hplttl(20),'string',num2str(DISPLAY{iaxes}.iref{inds}) )

%  Configure the plot x- and y- limits

set(hplttl(3),'string',num2str(DISPLAY{iaxes}.xlim(1)))
set(hplttl(5),'string',num2str(DISPLAY{iaxes}.xlim(2)))
set(hplttl(7),'string',sprintf('%6.3e',DISPLAY{iaxes}.ylim(1)))
set(hplttl(9),'string',sprintf('%6.3e',DISPLAY{iaxes}.ylim(2)))

%  Configure the line labels, colors, styles, and markers

lnlab = DISPLAY{iaxes}.lnlab{1};

for itnds = 2:length(indsvec),
   lnlab = [lnlab,'|',DISPLAY{iaxes}.lnlab{itnds}];
end

set(hplttl(11),'string',lnlab)  % Set popup menu strings with line labels 
set(hplttl(11),'value',inds)    % Set popup menu value

switch DISPLAY{iaxes}.lnst{inds}
   case '- ', set(hplttl(12),'value',1)
   case '--', set(hplttl(12),'value',2)
   case ': ', set(hplttl(12),'value',3)   
   case 'none', set(hplttl(12),'value',4)
end  

switch DISPLAY{iaxes}.lnco{inds}
   case 'y', set(hplttl(13),'value',1)
   case 'b', set(hplttl(13),'value',2)
   case 'r', set(hplttl(13),'value',3)
   case 'g', set(hplttl(13),'value',4)
end  

switch DISPLAY{iaxes}.marker{inds}
   case 'none', set(hplttl(26),'value',1)
   case 'o', set(hplttl(26),'value',2)
   case '.', set(hplttl(26),'value',3)
   case '+', set(hplttl(26),'value',4)
   case '*', set(hplttl(26),'value',5)
end  

%
%  Configure ensemble number
%

set(hplttl(28),'string',num2str(DISPLAY{iaxes}.iavg{inds}))

%
%  ALL DONE
%

return