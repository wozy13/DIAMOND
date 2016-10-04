function haxes = bar3D(xfp,yfp,DI,xlab,ylab,zlab,cutoff,haxes)
%
%  Name: bar3D
% 
%  Usage: haxes = bar3D(xfp,yfp,DI,xlab,ylab,zlab,cutoff,haxes)
%
% 
%   Description:
%     Draws a 3D bar chart of the variable DI
%
%   inputs:
%	yfp(j,i) = y coordinate of the (j,i) element of DI
%	xfp(j,i) = x coordinate of the (j,i) element of DI
%	DI(j,i)  = Value of the function at x=xfp(j,i) and y=yfp(j,i)
%	haxes    = handle of the axes to use to make the chart
%	xlab, ylab, zlab = label strings for axes x, y, z
%	cutoff   = 'critical' value of DI -- bars where DI > cutoff 
%		    will be colored red (only used when cutoff > 0)

%  Version SWD970108
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

if ~exist('xfpcount'),
	xfpcount = size(DI,1)*ones(1,size(DI,2));
end

axes(haxes);

cla

dx=abs((xfp(1,1)-xfp(1,2)))*.4;
dy=abs((yfp(1,1)-yfp(2,1)))*.4;
numdivy=size(DI,1);
numdivx=size(DI,2);

for i=1:numdivx
   for j=1:numdivy 
    	
	x1=xfp(j,i)+dx;
	x2=xfp(j,i)-dx;
	y1=yfp(j,i)-dy;
	y2=yfp(j,i)+dy;

	z=DI(j,i);
	tx11=[x1,x1,x1,x1];
	tx22=[x2,x2,x2,x2];
	ty11=[y1,y1,y1,y1];
	ty22=[y2,y2,y2,y2];
	tx12=[x1 x2 x2 x1];
	ty12=[y1 y2 y2 y1];
	ty1122=[y1 y1 y2 y2];
	tz=[z z 0 0];
	tzz=[z z z z];
	t00=[0 0 0 0];

	if cutoff > 0,
	  if abs(z)<cutoff
		color='r';
	  else,
		color='r';
	  end;
	else
      color='r';	
   end

   fill3(tx11,ty12,tz,color,tx12,ty22,tz,color,tx22,ty12,tz,color,tx12,...
      ty11,tz,color,tx12,ty1122,tzz,color,tx12,ty1122,t00,color,'edgecolor','b');
	set(haxes,'nextplot','add')

    end
end

set(haxes,'nextplot','replace','box','on')
 
if exist('xlab'),
   xlabel(xlab),ylabel(ylab),zlabel(zlab)
end

return