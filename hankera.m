function H = hankera(k);
%
%  hankera
%
%  H = hankera(k);
%
%  forms the Hankel matrix w.r.t. time-step k  
%

%  Version SWD970904
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

global MODES DATA

nresp = size(DATA{1}.respDOF,1);
nref = size(DATA{1}.refDOF,1);

H = zeros(MODES.eraparam.q*nresp,MODES.eraparam.d*nref);

for nr = 1:MODES.eraparam.q,
   
   nrvec = [ ((nr-1)*nresp + 1) : (nr*nresp) ];
   
   for nc = 1:MODES.eraparam.d,
      
      ncvec = [ ((nc-1)*nref + 1) : (nc*nref) ];
      
      yb = k + nr + nc ;
      
      %yrvec = [ ((yb-1)*nresp + 1): (yb*nresp) ];
      
      H(nrvec,ncvec) = shiftdim(MODES.eraparam.Y(yb,:,:),1);
      
   end
   
end

return
