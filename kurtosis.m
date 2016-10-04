function ku = kurtosis(xn,xnmean,xn1sig)
%
%  Name: kurtosis
%
%  Usage: ku = kurtosis(xn,xnmean,xn1sig)
%
%  Computes kurtosis (4th moment) of distribution
%  (approaches zero for normal distribution)
%

%
%  Version SWD970422
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


if exist('xnmean') ~=1, xnmean = mean(xn); end
if exist('xn1sig') ~=1, xn1sig = std(xn); end

ku = mean(((xn - xnmean)/xn1sig).^4)-3;

return
