function diamondsetup
%  
%  diamondsetup
%
%  Sets up the diamond splash screen and runs other setup routines
%

%
%  Version SWD971030
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


%%===================================
%%  For the SPLASH SCREEN
%%===================================

global HANDLES pathname

HANDLES.hfspl = figure('numbertitle','off','name','DIAMOND: STARTUP',...
		'menubar','none','resize','on','units','pixels','position',[150 20 700 500]);

haspl = axes('visible','off');

hspl(1) = text(0.5,0.8,'DIAMOND');

set(hspl(1),'fontname','times','fontsize',72,'Color','r','HorizontalAlignment','Center','Fontangle','italic','fontweight','bold')

hspl(7) = text(0.5,0.65,'Damage Identification and Modal Analysis of Data');
set(hspl(7),'horiz','center','fontsize',12,'fontname','times','fontangle','italic')

hspl(6) = text(0.5,0.575,'VERSION: SWDFINAL');
set(hspl(6),'HorizontalAlignment','Center','fontsize',10)

hspl(2) = text(0.5,0.45,'Created by Scott Doebling, Phil Cornwell, Erik Straser, Matt Bement, and Chuck Farrar');
set(hspl(2),'fontname','times','fontsize',12,'HorizontalAlignment','Center')

hspl(3) = text(0.5,0.35,'Created at Los Alamos National Laboratory');
set(hspl(3),'HorizontalAlignment','Center')

hspl(4) = text(0.5,0.30,'Under the Auspices of the US Department of Energy');
set(hspl(4),'HorizontalAlignment','Center')

hspl(5) = text(0.5,0.25,'Source code may be copied, modified and distributed subject to stated conditions');
set(hspl(5),'HorizontalAlignment','Center')

hspl(8) = text(0.5, 0.10, 'DIAMOND IS STARTING UP...');
set(hspl(8),'HorizontalAlignment','Center')


drawnow

hdmspl = uicontrol('style','pushbutton','string','START','visible','off',...
	'units','normal',...
	'position',[0.4 0.07 0.2 0.05],...
	'callback',['delete(HANDLES.hfspl),',...
			'set(HANDLES.hfigdmnd,''visible'',''on''),']);

HANDLES.hfigdmnd=figure( ...
    'Name','Diamond - Modal Analysis', ...
    'NumberTitle','off', ...
    'Resize','on', ...
    'units','normal',...
    'visible','off',...
    'Position',[0.05 0.05 0.9 0.9],...
    'menubar','none',...
    'closerequestfcn','errordlg(''Do not attempt to close DIAMOND windows improperly'')');


axes
set(gca,'Position',[0 0 1 1]);
axis off

%
%  Define global variables
% 

if isunix,
   pathname='~';
else
   pathname='C:';
end

%=======================================
% Set up initial menus
%=======================================

filemenu
modmenu
htmenu

%=======================================
% Set up DIAMOND buttons
%=======================================

%  Modal Analysis

plotbtns
opshapebtns
ratpbtns
erabtns
eraconvsetup
figure(HANDLES.hfigdmnd)
set(HANDLES.hfigdmnd,'visible','off')
cebtns
anmodbtns
pdffbtns

%  Damage ID

sembbtns
flexbtns
macbtns

%  Model Updating

msebtns
mrptbtns

%  Test simulation

simsysdefbtns
siminpdefbtns
simwindefbtns
simrundefbtns
simoutdefbtns
%
%  Set up the plottools
%

plottool

%
%  Set up the mode selection window
%

mdselwin

%
%  Set up the monte carlo tool palette
%

mctool

%
%  Set up the viewport figure and info figure
%

vpsetup
vpinfosetup

%
%  Set up viewmodes
%

viewmodesetup

%
%  Set up editgeom and editdof
%

editgeomsetup
makedofsetup

%
%  SETUP IS COMPLETE -- READY TO START DIAMOND
%


set(hspl(8),'string','Diamond is Ready. Push the Button.')
set(hdmspl,'visible','on')

return