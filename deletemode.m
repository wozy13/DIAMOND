function deletemode(idelmode)
%
%   Name: deletemode
%
%   Usage: 
%
%   Deletes mode # 'idelmode' from all fields in MODES
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

global MODES

fnames = fieldnames(MODES);
nmodes = MODES.nmodes;

for ifield = 1:length(fnames),  %  Loop over all the fields in MODES
   %  If this field is a cell array of length nmodes, remove idelmode'th component
   temp = getfield(MODES,fnames{ifield});
   if iscell(temp) & length(temp) == nmodes,
      iassign = [1:idelmode-1,idelmode+1:nmodes];
      clear temp2
      if length(iassign) > 0,
         for ia = 1:length(iassign);
            temp2{ia} = temp{iassign(ia)};
         end
      else
         temp2 = {};
      end
      eval(['MODES.',fnames{ifield},' = temp2;']);
   end
end

MODES.nmodes = nmodes - 1;

return