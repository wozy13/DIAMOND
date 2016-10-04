
%
%  Name:   lddammo
%
%  Usage:  lddammo
%
%  Loads the undamaged and damaged modes for the damage ID
%  algorithms
%
%  The following variable must be defined prior to calling
%   this script:
%  
%   damsuf = '_u' or '_d' to define whether the modes
%            should be placed in the undamaged or damaged
% 	     modal sets
%

%  Version SWD970623
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


eval(['load ',[pathname,filename]]);

if exist('filename') == 1,

   eval([' filename',damsuf,' = filename;'])
   eval([' pathname',damsuf,' = pathname;'])

   clear filename

end


if exist('Freq')==1,

  eval([' Freq',damsuf,' = Freq;'])
  
  clear Freq

end

if exist('Damp') == 1,

      eval([' Damp',damsuf,' = Damp;'])
      clear damp

end


if exist('phir_resp'),

  eval([' phir_resp',damsuf,' = phir_resp;'])
  nmod_tot = size(phir_resp,2);
   clear phir_resp

end

if exist('phir_ref'),

  eval([' phir_ref',damsuf,' = phir_ref;'])
  nmod_tot = size(phir_ref,2);
   clear phir_ref

end

if exist('respDOF'),

  eval([' respDOF',damsuf,' = respDOF;'])
   clear respDOF

end

if exist('refDOF'),

  eval([' refDOF',damsuf,' = refDOF;'])
   clear refDOF

end

clear phic_resp phic_ref

