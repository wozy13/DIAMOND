function era2mode(A,B,C,fs,emac_era,msv_era,respDOF,refDOF)
%
%  Function: era2mode
%
%  Usage: era2mode(A,B,C,fs,emac_era,msv_era,respDOF,refDOF)
%
%  Converts state-space model A,B,C from ERA
%  to complex modes, frequencies (Hz) and damping ratios (%)
%
%  (Assumes measurements are from accelerometers)
%
%  Author(s): Scott Doebling, doebling@lanl.gov
%             Phillip Cornwell, cornwell@lanl.gov
%             Erik Straser, estraser@lanl.gov
%
%  Version SWD980617
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

%  Convert to continuous-time
[Ac,Bc] = d2cmatt(A,B,1/fs);

%  Determine Damped Modal Realization
[vc,dc] = eig(Ac);
[vd,dd] = eig(A);

ddc = diag(dc);
ddd = diag(dd);

vci = inv(vc);

Ad = vci * Ac * vc;
Bd = vci * Bc;
%Cd = C * vc / dc^2 * 9.81;  % ASSUMES ACCELERATION DATA!
Cd = C * vc / dc^2;

%
%  Change signs of mode shapes based on sensor orientations
%

%for p = 1:size(respDOF,1),

%   Cd(p,:) = Cd(p,:) * sign(respDOF(p,2));

%end

%for p = 1:size(refDOF,1),

%   Bd(:,p) = Bd(:,p) * sign(refDOF(p,2));

%end



%  Put emac in same order as continuous poles

nx = length(ddc);

if length(emac_era) ~= 0,
   
   emac_sorted = zeros(nx,1);
   
   for i = 1:nx,
      
      [temp,imin] = min(abs(abs(ddc(i)) * ones(nx,1) - abs(log(ddd))*fs));
      
      emac_sorted(i) = emac_era(imin(1));
      
   end
   
else 
   
   emac_sorted = ones(nx,1);
   
end


%  Remove real poles, etc. (to get 'reduced' matrices)
[Adr,Bdr,Cdr,ddcr,vcr,emacr] = chkpoles(Ad,Bd,Cd,ddc,vc,emac_sorted);

%  Compute MPC
mpc_resp = mpc_comp(Cdr);
mpc_ref = mpc_comp(Bdr.');

%  Extract the frequencies
dvec = [1:2:length(ddcr)];
nm = length(dvec);

freq_unsort = zeros(nm,1);
damp_unsort = zeros(nm,1);

phic_resp_unsort = zeros(size(Cdr,1),nm);
phic_ref_unsort = zeros(size(Bdr',1),nm);

mpc_resp_unsort = mpc_resp(dvec);
mpc_ref_unsort = mpc_ref(dvec);

emac_unsort = emacr(dvec);

for i = 1:nm,
   
   freq_unsort(i) = abs(Adr(dvec(i),dvec(i)))/2/pi;
   
   damp_unsort(i) = real(Adr(dvec(i),dvec(i)))./(-2*pi* freq_unsort(i));
   
   %phic_resp_unsort(:,i) = Cdr(:,(dvec(i)+1))  * (2*sqrt(-1)*imag(Adr(dvec(i),dvec(i))));
   
   phic_ref_unsort(:,i) = Bdr((dvec(i)+1),:).';
   
   res_unsort(:,i) = Cdr(:,(dvec(i)+1)) * Bdr((dvec(i)+1),:).';
   
end

[freq, isort] = sort(freq_unsort);

damp = damp_unsort(isort);

phic_resp = phic_resp_unsort(:,isort);

phic_ref = phic_ref_unsort(:,isort);

mpc_resp = mpc_resp_unsort(isort);
mpc_ref = mpc_ref_unsort(isort);

emac = emac_unsort(isort);

res = res_unsort(:,isort);

cmi_resp = emac .* mpc_resp;
cmi_ref = emac .* mpc_ref;

%  Delete existing modes

if isfield(MODES,'nmodes'),
   if MODES.nmodes > 0,
      for i = MODES.nmodes:-1:1,
         deletemode(i)
      end
   end
end

%  Define entries in MODES

MODES.nmodes = length(freq);
MODES.respDOF = respDOF;
MODES.refDOF = refDOF;

for i = 1:MODES.nmodes,
   MODES.Freq{i} = freq(i);
   MODES.Damp{i} = damp(i);
   MODES.residue{i} = res(:,i).';
   MODES.emac{i} = emac(i);
   MODES.mpc{i} = mpc_resp(i);
   MODES.cmi{i} = cmi_resp(i);
end

residues2modes

return