function drawcursor
%
%  Name:   drawcursor
%
%  Usage:  drawcursor
%
%  Draws the cursor line on the frequency domain plot.
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
%

global DISPLAY iaxes inds

haxes = DISPLAY{iaxes}.haxes;

% Determine the proper y limit (in case data has zeros on log plot)

ylim = get(haxes,'ylim');

if strcmp(get(haxes,'yscale'),'log'),
   % plot is logarithmic
   % In this case, set ymin to smallest nonzero entry in the plot data
   ylim(1) = min(DISPLAY{iaxes}.displayvec{inds}(find(DISPLAY{iaxes}.displayvec{inds} > 0)));
end

% Draw the cursors and set the colors

axes(haxes)

for icurs = 1:length(DISPLAY{iaxes}.hcursor),
   
   DISPLAY{iaxes}.hcursor{icurs} =line([DISPLAY{iaxes}.cursfreq{icurs},DISPLAY{iaxes}.cursfreq{icurs}],ylim);
   set(DISPLAY{iaxes}.hcursor{icurs},'Color',DISPLAY{iaxes}.curslnco{icurs})

   % Draw cursor marker where cursor crosses data

   i1 = find( DISPLAY{iaxes}.xvec == DISPLAY{iaxes}.cursfreq{icurs} );

   DISPLAY{iaxes}.hcursmark{icurs} = plot(DISPLAY{iaxes}.cursfreq{icurs},DISPLAY{iaxes}.displayvec{inds}(i1),'o');
   set(DISPLAY{iaxes}.hcursmark{icurs},'color','w')
   
end

return