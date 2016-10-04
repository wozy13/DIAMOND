function [mag1sig,phs1sig,coh1sig,cps1sig] = genstat(G,Gxy,Coh,navg)
%
%  Name:   genstat
%
%  Usage:	[mag1sig,phs1sig,coh1sig,cps1sig] = genstat(G,Gxy,Coh,navg)
%
%  Purpose:  Generate the statistical (1 sigma) error bounds on the
%	spectral estimates from a modal test:
%
%	Inputs:
%		G = measured FRF estimate
%		Gxy = measured CPS estimate
%		Coh = measured coherence estimate
%		navg = number of experimental averages
%
%	Outputs:
%		mag1sig = 1 sigma std for FRF magnitude
%		phs1sig = 1 sigma std for FRF phase
%		coh1sig = 1 sigma std for coherence function
%		cps1sig = 1 sigma std for CPS magnitude
%

%  Version SWD970730
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

%
%  Interpolate points in Coherence where the value is zero
%

[zpveci,zpvecj] = find(Coh == 0);

for i = 1:length(zpveci),

   Coh(zpveci(i),zpvecj(i)) = (Coh(zpveci(i)+1,zpvecj(i)) + Coh(zpveci(i)-1,zpvecj(i)))/2;

end


%
%   FRF magnitude
%

mag1sig = sqrt(1 - Coh) ./ sqrt(Coh * 2 * navg) .* abs(G);

%
%   FRF phase
%

%phs1sig = 0.5 * sqrt(1 - Coh) ./ sqrt(Coh * 2 * navg) .* angle(G);

ephs = sqrt(1 - Coh) ./ sqrt(Coh * 2 * navg);

%
%   Make sure argument for asin is always <=1

[gt1i,gt1j] = find(ephs>1);

for i = 1:length(gt1i),
   ephs(gt1i(i),gt1j(i))=1;
end

phs1sig = asin(ephs);

%
%   Coherence
%

coh1sig = sqrt(2) * (1 - Coh) ./ sqrt(Coh * navg) .* Coh;

%
%   Cross-Power Spectrum
%

cps1sig = 1 ./ sqrt(Coh * navg) .* Gxy;

%
%   Compute bounds on FRF based on mag and phase bounds
%

%gmag = abs(G);
%gph = angle(G);
%sgph = sin(gph);
%cgph = cos(gph);

%real1sig = sqrt( (cgph .* mag1sig).^2 + (gmag .* sgph .* phs1sig).^2 ); 

%imag1sig = sqrt( (sgph .* mag1sig).^2 + (gmag .* cgph .* phs1sig).^2 ); 

return