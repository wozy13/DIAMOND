function defopshape(imode,i1)
%
% Function: defopshape
% 
% Usage: defopshape(imode,i1)
% 
% Description:
%    Defines the operating shape at frequency index 'i1'
%    into position 'imode' in the appropriate fields of MODES
%

%
% Version SWD970818
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

global MODES DATA DISPLAY iaxes

%  Define modal frequency

MODES.Freq{imode} = DISPLAY{iaxes}.cursfreq{1};

%  Define data function

switch MODES.ispecfunfit
case 'FRF'
   Gop =  DATA{1}.G(:,:,DISPLAY{iaxes}.iref{1},DISPLAY{iaxes}.iavg{1});
case 'CPS'
   Gop = DATA{1}.Gxy(:,:,DISPLAY{iaxes}.iref{1},DISPLAY{iaxes}.iavg{1});
end

%  Take FRF with highest magnitude at this peak to use for damping computation

[magpeak,imax] = max(abs(Gop(i1,:)));

magG = abs(Gop(:,imax));

freq = DISPLAY{iaxes}.xvec;

%  Compute modal damping using half-power method

foundupper = 0;
iup = i1+1;
while ~foundupper
   if magG(iup) < magpeak/sqrt(2) & magG(iup-1) > magpeak/sqrt(2),
      wa = 2*pi* interp1([magG(iup-1) magG(iup)],[freq(iup-1) freq(iup)],magpeak/sqrt(2),'linear');
      foundupper = 1;
   else
      iup = iup+1;
   end
end


foundlower = 0;
ilow = i1;
while ~foundlower
   if magG(ilow-1) < magpeak/sqrt(2) & magG(ilow) > magpeak/sqrt(2),
      wb = 2*pi* interp1([magG(ilow-1) magG(ilow)],[freq(ilow-1) freq(ilow)],magpeak/sqrt(2),'linear');
      foundlower = 1;
   else     
      ilow = ilow - 1;
   end
end

MODES.Damp{imode} = (wa^2 - wb^2)/(2*pi*MODES.Freq{imode})^2;

%  Define residues

MODES.residue{imode} = Gop(i1,:) * (MODES.Damp{imode} * (MODES.Freq{imode} * 2 * pi)) / (MODES.Freq{imode} * 2 * pi)^2 ; % The division by w^2 ASSUMES MEASUREMENTS ARE ACCELS

%  Compute mode shapes, mode participation factors, and modal scaling factors

residues2modes

%  Assign respDOF and refDOF, if this is the first mode

if imode == 1
   MODES.respDOF = DATA{1}.respDOF;
   MODES.refDOF = DATA{1}.refDOF;
end

MODES.timestamp{imode} = now;                % The time this mode was identified
MODES.methodstr{imode} = 'Operating Shape';  % The method used to identify this mode

return