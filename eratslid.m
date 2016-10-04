function newhandle=ERAtslid(ax,textin,oldhandle,slidhndl)
%
%  Name:   ERAtslid
%
%  Usage: ERAtslid
%
%  This m-file creates a large text box with slider for
%	ERA 
%
%  Version PJC960412
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

if exist('oldhandle')~=1,oldhandle=[];end;
if ishandle(oldhandle)==1,delete(oldhandle);end;

% Determine the number of rows and columns
[m,n] = size(textin);


% Draw the first column
axis([1 m 1 n]);
drawnow
tmp = text(.5,.5,'t');
ext = get(tmp,'Extent');
dy = ext(4);  % Height
wch = ext(3); % Width of a single character.
fw = 7;       % Column width.  Each column can have up to 
              % 8-digits in it.
wc = 7*wch;   % Width of 8 digit column
dwc = .5*wch;  % Distance between columns
dx = wc+dwc;  % Step used for columns
x = 1;        % Location of first column
delete(tmp)

%
%  the first column (index)
%

x=1;
y=1;
for j=1:m  %row
   y=y+abs(dy);   %location of row
   t(j)=text(x,y,textin(j,:));
   set(t(j),'color','k','FontSize',10,'HorizontalAlignment','left', ...
	'FontName','courier');
end
newhandle=t;
% Fix up the axes
axis([1-dwc/2 1+4*dx-dwc/2 1 1+20*abs(dy)])

% Add a vertical slider

set(slidhndl,'min',-m,'userdata',[dy,ax]);
