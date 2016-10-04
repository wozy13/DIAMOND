%
%  Name: editdof.m
%
%  Usage: strout = editdof(strin)
%
%  Edits the DIAMOND DOF lists
%

%
%  Version SWD970521
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
%  Define uicontrols
%

hesfig = figure('Name','DIAMOND: EditDOF', ...
   'units','normal',...
	'NumberTitle','off', ...
   'menubar','none',...
   'Position',[0.25 0.4 0.5 0.25]);

hestitle = uicontrol('style','text',...
   'position',[0.02 0.90 0.96 0.10],...
   'horizontalalignment','left');

hesstr = uicontrol('style','edit',...
   'position',[0.02 0.15 0.96 0.75],...
   'horizontalalignment','left',...
   'max',2);

uicontrol('style','pushbutton',...
   'position',[0.80 0.01 0.15 0.14],...
   'string','Close',...
   'callback',[...
      ' temp = str2num(get(hesstr,''string'')); respDOF = temp(:,2:3); listdof,',...
      'delete(hesfig)']);

%
%  Set title string and editor string
%

titlestr = chantstr(1,1:end-1); 
bodystr = num2str([[1:size(respDOF,1)]' respDOF]);

set(hestitle,'string',titlestr)
set(hesstr,'string',bodystr)