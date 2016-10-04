function [emac_tot,msv] = emaccomp(A,V,W,q,d,fs)
%
%  emaccomp
%
%  [emac,msv] = emaccomp(A,V,W,q,d,fs)
%
%  Computes extended modal amplitude coherence (emac_tot)
%  for system with discrete-time state matrix A, and
%  discrete-time observability and controllability matrices
%  V and W
%
%  q and d are the ERA Hankel matrix block dimensions
% 
%  fs is the sampling frequency
%
%  (Assumes measurements are acceleration)

%  Reference: "Consistent-Mode Indicator for the Eigensystem
%    Realization Algorithm," Pappa, Elliott, Schenk, J. of 
%    Guidance, Control, and Dynamics, v. 16, No. 5, 1993.

%  Version SWD960207
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
%

nx = size(A,1);

nresp = size(V,1) / q;

nref = size(W,2) / d;

emac_tot_num = zeros(nx,1);
emac_tot_den = zeros(nx,1);

msv = zeros(nx,1);

%   Put model in discrete-time modal form

[vd,dd] = eig(A);

Vmo = V * vd / dd^2;
Wmo = inv(vd) * W;

%  Find continuous-time eigenvalues

s = log(diag(dd)) * fs;

%  Compute EMAC for each state

for i = 1:nx,

%   Do over every input-output pair

    for k = 1:nref,

%
%     Compute input EMAC for this state
%

          Wmo_sim = Wmo(i,k) * exp(s(i) * (d-1) / fs);

          Wmo_final = Wmo(i, (d-1)* nref + k);

          if abs(Wmo_sim) >= abs(Wmo_final),

             Rik = abs(Wmo_final)/abs(Wmo_sim);

          else

             Rik = abs(Wmo_sim)/abs(Wmo_final);

          end

          Pik = abs(angle(Wmo_final / Wmo_sim));

          if Pik <= pi/4,

             Wik = 1 - Pik * 4/pi;

          else

             Wik = 0;

          end

          emac_in = Rik * Wik;

 

     for j = 1:nresp,

%
%     Compute output EMAC for this state
%

          Vmo_sim = Vmo(j,i) * exp(s(i) * (q-1) / fs);

          Vmo_final = Vmo((q-1)* nresp + j , i);

          if abs(Vmo_sim) >= abs(Vmo_final),

             Rij = abs(Vmo_final)/abs(Vmo_sim);

          else

             Rij = abs(Vmo_sim)/abs(Vmo_final);

	  end

          Pij = abs(angle(Vmo_final / Vmo_sim));

          if Pij <= pi/4,

             Wij = 1 - Pij * 4/pi;

          else

             Wij = 0;

	  end

          emac_out = Rij * Wij;

      emac_tot_num(i) = emac_tot_num(i) + emac_out * emac_in * abs(Vmo(j,i))^2 * abs(Wmo(i,k))^2;

      emac_tot_den(i) = emac_tot_den(i) +  abs(Vmo(j,i))^2 * abs(Wmo(i,k))^2;

      end

     end

%  Compute msv for this state

    if i < nx

     msv(i) = norm(Vmo(:,i:i+1),'fro') + norm(Wmo(i,i:i+1),'fro');
    end


end


emac_tot = emac_tot_num ./ emac_tot_den;

msv = msv / max(msv);


return
