function defdisplay(iaxes)
%
%   Name: defdisplay
%
%   Usage: defdisplay(iaxes) 
%
%   Description: Defines the plot vectors into the DISPLAY
%     global variable from the DATA global variable
%     
%   Global Variables:
%      DISPLAY
%      DATA
%
%   Arguments:
%      iaxes = ordinal number of current axes
%      inds  = number of this plot in the plot order
%
%
%   Version SWD970726
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

%   Access required Global Variables

global DISPLAY HANDLES indsvec

for inds = indsvec,
   
%   Apply the appropriate display function to the data
switch DISPLAY{iaxes}.displayfun{inds}
   case 'SISO', % SISO data - slice off the appropriate display vector
   iresp = DISPLAY{iaxes}.iresp{inds};
   iref = DISPLAY{iaxes}.iref{inds};
   switch DISPLAY{iaxes}.specfun{inds}
      case {'FRF','CPS'}, datavec = DISPLAY{iaxes}.specdatavec{inds}(:,iresp,iref); 
      case 'Coherence', datavec = DISPLAY{iaxes}.specdatavec{inds}(:,iresp,iref);  DISPLAY{iaxes}.iyscale = 'REAL';
      case 'PSD Resp', datavec = DISPLAY{iaxes}.specdatavec{inds}(:,iresp);  DISPLAY{iaxes}.iyscale = 'MAG';
      case 'PSD Ref', datavec = DISPLAY{iaxes}.specdatavec{inds}(:,iref);  DISPLAY{iaxes}.iyscale = 'MAG';
      case 'Time History', datavec = DISPLAY{iaxes}.specdatavec{inds}(:,iresp,iref); DISPLAY{iaxes}.iyscale = 'REAL';
   end
   case 'CMIF', datavec = cmif(DISPLAY{iaxes}.specdatavec{inds});   DISPLAY{iaxes}.iyscale = 'MAG';
   case 'MIF', datavec = mif(DISPLAY{iaxes}.specdatavec{inds});     DISPLAY{iaxes}.iyscale = 'REAL';
   case 'APS', datavec = aps(DISPLAY{iaxes}.specdatavec{inds});     DISPLAY{iaxes}.iyscale = 'REAL';
   case 'MvMIF', datavec = mvmif(DISPLAY{iaxes}.specdatavec{inds});  DISPLAY{iaxes}.iyscale = 'REAL';
end

%  Apply the proper complex data function to the data

switch DISPLAY{iaxes}.iyscale
   case 'MAG',   datavec = abs(datavec);  DISPLAY{iaxes}.iylog = 1;
   case 'PHASE', datavec = angle(datavec); DISPLAY{iaxes}.iylog = 0;
   case 'REAL',  datavec = real(datavec); DISPLAY{iaxes}.iylog = 0;
   case 'IMAG',  datavec = imag(datavec); DISPLAY{iaxes}.iylog = 0;
end

%  Store the data in the DISPLAY vector

DISPLAY{iaxes}.displayvec{inds} = datavec;

end

%
%   ALL DONE
%

return