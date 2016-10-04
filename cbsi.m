function [phi_resp,phi_ref,Freq,Damp] = cbsi(Am,Bm,Cm,dc,dppair)
%
%  Name: cbsi
%
%  Usage: [phi_resp,phi_ref,Freq,Damp] = cbsi(Am,Bm,Cm,dc,dppair)
%
%  Description:
%     Uses CBSI-LS technique (See Alvin, 1993) to
%     mass-normalize the measured modes 
%     from one or more driving point DOF pairs
%
%	Input model must be in McMillan Normal Form
%
%	dc are the continuous damped (complex) poles

%  Version SWD960718
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

nx = size(Am,1);

nm = nx/2;

Vi = zeros(size(Am));

sig = real(dc);
omeg = imag(dc);

%  Define the transformation

for i = 1:nm,

    si = sig(i);

    oi = omeg(i);

    bi1 = Bm( (i-1)*2 + 1, :)';

    bi2 = Bm( i*2, :)';

    bi1dp = bi1(dppair(2));
    bi2dp = bi2(dppair(2));

    ci1 = Cm( : , (i-1)*2 + 1);

    ci2 = Cm( : , i*2);

    ci1dp = ci1(dppair(1));
    ci2dp = ci2(dppair(1));
        
    S11 = bi1' * bi1;

    S12 = bi1' * bi2;

    S22 = bi2' * bi2;

    ad = 4 * si^2 * S22 - 4 * si * (si^2 + oi^2) * S12 +...
		(si^2 + oi^2)^2 * S11;

    bd = 2 * si * S22 - (si^2 + oi^2) * S12;

    ae = bd * S22 - ad * S12;

    be = S22^2 - ad*S11;
  
    ce = S12 * S22 - bd*S11;

    e = (- be + sqrt(be^2 - 4*ae*ce)) / 2*ae;

    d = sqrt((ci1dp + e*(2*si*ci1dp + (si^2 + oi^2)*ci2dp))/...
		((1+2*si*e+(si^2 + oi^2)*e^2)*(bi2dp+e*(2*si*bi2dp-(si^2 + oi^2)*bi1dp))));

    Vi(((i-1)*2 + 1):(i*2),((i-1)*2 + 1):(i*2)) = ...
	d * [ 1, e ; -e*(si^2 + oi^2), 1 + 2* si * e];

end

%  Apply the transformation to the Mcmillan Normal Form model

V = inv(Vi);

Acb = Vi * Am * V;
Bcb = Vi * Bm;
Ccb = Cm * V;

%
%  Form modal vectors and frequencies
%

dvec = [2:2:nm*2];

Freq = zeros(nm,1);
Damp = zeros(nm,1);
phi_resp = zeros(size(Cm,1),nm);
phi_ref  = zeros(size(Bm,2),nm);

Ccb
pause

for i = 1:nm,

    Freq(i) = sqrt(-Acb(dvec(i),dvec(i)-1))/2/pi;

    Damp(i) = Acb(dvec(i),dvec(i))/2/(Freq(i) * 2 * pi);

    phi_resp(:,i) = Ccb(:,dvec(i)-1);

    phi_ref(:,i) = Bcb(dvec(i),:)';

end

return

