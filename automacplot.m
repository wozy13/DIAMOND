function automacplot(haxes,realmodes)
%
%  Name: automacplot
% 
%  Usage: automacplot(haxes,realmodes)
%
% 
%   Description:
%     Plots the AUTOMAC of the current Modal Set
%
%	

%  Version SWD970805
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


ndof = length(realmodes{1});
nmodes = length(realmodes);

Phi = zeros(ndof,nmodes);

for i = 1:nmodes,
   Phi(:,i) = realmodes{i}';
end

%
%  Compute the MAC
%

MACPHI = mac(Phi,Phi);

%
%  Generate xfp and yfp
%

nmodplot=size(Phi,2);

xvalues = [1:nmodplot];
yvalues = [1:nmodplot];
 
xfp=ones(length(yvalues),1)*xvalues;
yfp=yvalues'*ones(1,length(xvalues));

%
%  Draw the plot
%

bar3D(xfp,yfp,MACPHI,'Mode Number','Mode Number','AUTOMAC',-1,haxes);

set(haxes,'XLim',[0 nmodplot+1],'Xtick',[1:nmodplot],'YLim',[0 nmodplot+1],...
   'Ytick',[1:nmodplot],'Zlim',[0 1])
set(haxes,'box','on')
rotate3d on

return
