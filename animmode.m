function modemovie = animmode
%
%  Name: animmode
% 
%  Usage: animmode
%
%  Description:
%	   Animates displaced mode shape of mode number 'nmod'

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

global HANDLES MODES imode

%
% Define parameters
%

nframes = 16;
T=1/MODES.Freq{imode};
omega=2*pi/T;

dtime=T/nframes;
time=0;

%
%  Set up the Drawing information text
%

htext = uicontrol('style','text',...
	'units','normal',...
	'pos',[.75 .66 .25 .04],...
   'string','Drawing Status');
    
    
set(HANDLES.hviewm(2),'xlimmode','auto','ylimmode','auto','zlimmode','auto')

%
%  Loop over each increment in the cycle
%

for istep = 1:nframes,
   
   time=dtime*(istep-1);
   %
   %  Display the drawing status
   %

   set(htext,'string',['Drawing Frame ',num2str(istep),' of ',num2str(nframes)])

   if istep == 2,
      set(HANDLES.hviewm(2),'xlimmode','manual','ylimmode','manual','zlimmode','manual')
   end

   drawmode(omega*time)

   %
   %  Capture the movie image
   %

   if istep==1,
      modemovie = moviein(nframes,HANDLES.hviewm(2));
   end

   modemovie(:,istep) = getframe(HANDLES.hviewm(2));
   
end

set(htext,'visible','off')

return
