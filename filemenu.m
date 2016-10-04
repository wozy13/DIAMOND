function filemenu
%
%  Name: filemenu.m
% 
%  Usage: filemenu
% 
%  Description:
%    Initializes the DIAMOND file menu
%

%  Version SWD970904
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

global HANDLES

%=======================================
% File menu
%=======================================

HANDLES.hmmenu{1}(1) = uimenu(HANDLES.hfigdmnd,'Label','File','enable','on');
HANDLES.hmmenu{1}(2) = uimenu(HANDLES.hmmenu{1}(1),'Label','Print');
   HANDLES.hmmenu{1}(3) = uimenu(HANDLES.hmmenu{1}(2),'Label','Windows');
      uimenu(HANDLES.hmmenu{1}(3),'label','Color','callback','print -dwinc -noui') 
      uimenu(HANDLES.hmmenu{1}(3),'label','Monochrome','callback','print -dwin -noui')
      uimenu(HANDLES.hmmenu{1}(2),'label','Unix','callback','print')
      uimenu(HANDLES.hmmenu{1}(1),'label','Copy to Clipboard (Windows)','callback','print -noui -dmeta');

HANDLES.hmmenu{1}(4) = uimenu(HANDLES.hmmenu{1}(1),'label','Import');
   HANDLES.hmmenu{1}(7) = uimenu(HANDLES.hmmenu{1}(4),'label','Universal File');
   uimenu(HANDLES.hmmenu{1}(7),'label','Type 58 Data','callback',...
      ['[filename,pathname,error]=loadfile(4,pathname);', ...
         'if error==0,',...
         '  disp(''Loading Type 58 Data...''),',...
         '  uffin_data(pathname,filename);',...
         '  disp(''Done Loading Type 58 Data''),',...
         'end']);
   uimenu(HANDLES.hmmenu{1}(4),'label','Create Bootstrap Data','callback','makeboot')
   uimenu(HANDLES.hmmenu{1}(4),'label','Create Averaged Data','callback','makeavgd')
   uimenu(HANDLES.hmmenu{1}(4),'label','Create Multi-Ref Data','callback','makemref')
   
HANDLES.hmmenu{1}(5) = uimenu(HANDLES.hmmenu{1}(1),'label','Export');
   uimenu(HANDLES.hmmenu{1}(5),'label','Universal File','callback','uffout')
   HANDLES.hmmenu{1}(6) = uimenu(HANDLES.hmmenu{1}(5),'label','ASCII File');
      uimenu(HANDLES.hmmenu{1}(6),'label','Modes','callback','modes2ascii')
   
   uimenu(HANDLES.hmmenu{1}(1),'Label','Exit Diamond','separator','on','Callback',...
   'set(findobj(''type'',''figure''),''closerequestfcn'',''closereq''),close all');
uimenu(HANDLES.hmmenu{1}(1),'Label','Quit Matlab','Callback',...
   'set(findobj(''type'',''figure''),''closerequestfcn'',''closereq''),quit');

return