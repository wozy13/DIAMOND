function eratext
%
%  Name: eratext
% 
%  Usage: eratext
% 
%  Description:
%    Displays the ERA results in the ERA results window
%

%  Version SWD970908
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

global MODES HANDLES

textin = sprintf('%5s%9s%9s%9s%9s%9s%1s','No.','Freq(Hz)','Damp(%)','EMAC','MPC','CMI','|');

for i=1:MODES.nmodes,
  textin = [textin, sprintf('%5.0f%9.2f%9.2f%9.2f%9.2f%9.2f%1s',i,MODES.Freq{i},MODES.Damp{i}*100,MODES.emac{i},MODES.mpc{i},MODES.cmi{i},'|')];
end

set(HANDLES.herab(24),'string',textin)

return