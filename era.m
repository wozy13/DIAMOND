function [A,B,C,emac_era,msv_era] = era
%
%  ERA
%
%  [A,B,C,emac_era,msv_era] = era
%
%  Applies the Eigensystem Realization Algorithm (ERA) to the 
%  impulse response from the FRF matrix 'G'
%
%  nx is the number of states to use (2 states per mode)
%  q and d are the ERA Hankel parameters
%
%  Returns the state-space model matrics 'A,B,C,D' and the
%   'revised' sample rate fs_out (due to zero-padding)
%
%  Also returns the observability matrix 'V' and the
%   controllability matrix 'W'
%
%  If nx < 0, will plot Hankel singular values and
%   prompt for a cut-off

%  Reference for ERA: "An Eigensystem Realization Algorithm for
%    Modal Parameter Identification and Model Reduction," 
%    Juang, J-N, and Pappa, R.S., Journal of Guidance, Control, and
%    Dynamics, Vol. 8, No. 5, pp. 620-627, 1985.

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

global MODES DATA

%  Define variables and allocate space for matrices

fprintf(1,' Xinjun Forming Hankel matrices...')
   makehank_Xinjun
fprintf(1,'done\n')

nresp = size(DATA{1}.respDOF,1);
nref = size(DATA{1}.refDOF,1);
nx = MODES.eraparam.nx;

U0N = MODES.eraparam.U0(:,1:nx);
S0N = MODES.eraparam.S0(1:nx,1:nx);
V0N = MODES.eraparam.V0(:,1:nx);

%  Form A, B, C, D, V, W

disp('Forming A,B,C,D...')
SNsqrt = sqrt(S0N);
SNinv = sqrt(inv(S0N));

A = SNinv * U0N' * MODES.eraparam.H1 * V0N * SNinv;
B = SNsqrt * V0N(1:nref,:)';
C = U0N(1:nresp,:) * SNsqrt;
D = shiftdim(MODES.eraparam.Y(1,:,:),1);

V = U0N * SNsqrt;
W = SNsqrt *  V0N';

if nargout > 3, 

  disp('Computing EMAC...')
  
  [emac_era,msv_era] = emaccomp(A,V,W,MODES.eraparam.q,MODES.eraparam.d,MODES.eraparam.fs_out);

end

return
