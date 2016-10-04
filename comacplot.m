function comacplot(haxes,realmodes1,realmodes2,lab1,lab2)
%
%  Name: comacplot
% 
%  Usage: comacplot(haxes,realmodes1,realmodes2,lab1,lab2)
%
%
% 
%   Description:
%     Plots the COMAC of modal sets realmodes1 and realmodes2
%
%	

%  Version SWD970916
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

global GEOM DAMAGEID

ndof = length(realmodes1{1});
nmodes1 = length(realmodes1);
nmodes2 = length(realmodes2);

Phi1 = zeros(ndof,nmodes1);
Phi2 = zeros(ndof,nmodes2);

for i = 1:nmodes1,
   Phi1(:,i) = realmodes1{i}' / max(realmodes1{i});
end

for i = 1:nmodes2,
   Phi2(:,i) = realmodes2{i}' / max(realmodes2{i});
end

DAMAGEID.mode_anal = [1:min(nmodes1,nmodes2)];

%
%  Compute the COMAC
%

CM = comac(Phi2,Phi1);


%
%  Plot the COMAC as a nodal damage indicator
%

inodal = 1; % Damage Indicator is Nodal quantity

colormap cool

if ~isempty(GEOM.Bars),
   ngrad = 4; % Number of increments for color gradient shading
   ptdambar(GEOM.Nodes,GEOM.Bars,CM,DAMAGEID.haxes,inodal,ngrad);
elseif ~isempty(GEOM.Shells),
   ngrad = 4;  % Number of divisions in each direction for shell elements
   ptdamshl(GEOM.Nodes,GEOM.Shells,CM,DAMAGEID.haxes,inodal,ngrad);
else
   errordlg('ERROR: No Bar or Shell Geometry Defined')
end

damscale(DAMAGEID.hlegax,CM);

axes(DAMAGEID.haxes)
DAMAGEID.damtitstr = damtitle(['COMAC Method'],DAMAGEID.undampath,DAMAGEID.undamfile,...
   DAMAGEID.dampath,DAMAGEID.damfile,['Modes: ',num2str(DAMAGEID.mode_anal)]);
title(['COMAC Method'])



return
