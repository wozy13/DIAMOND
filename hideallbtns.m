function hideallbtns
%
%  Name:   hideallbtns
%
%  Usage:  hideallbtns
%
%  Hides all the DIAMOND buttons
%

%
%
%  Version SWD970807
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

global HANDLES

%%===============================
%%  call each *btns function
%%===============================

hideall(HANDLES.hplotb)
hideall(HANDLES.hopshapeb)
hideall(HANDLES.hratpb)
hideall(HANDLES.herab)
hideall(HANDLES.hceb)
hideall(HANDLES.hanalmodb)
hideall(HANDLES.hmacdam)
hideall(HANDLES.hpdff)

hideall(HANDLES.hsemb)
hideall(HANDLES.hflexb)

hideall(HANDLES.hmseb)
hideall(HANDLES.hmrptb)
hideall(HANDLES.simsysdef);
hideall(HANDLES.simsysmassdef);
hideall(HANDLES.simsysstdef);
hideall(HANDLES.simsysdampdef);
hideall(HANDLES.simsyszetadef);
hideall(HANDLES.siminpdef.imp);
hideall(HANDLES.siminpdef.ran);
hideall(HANDLES.siminpdef.har);
hideall(HANDLES.siminpdef.comm);
hideall(HANDLES.siminpdef.edt);
hideall(HANDLES.siminpdef.oth);
hideall(HANDLES.wininpdef.oth);
hideall(HANDLES.wininpdef.edt);
hideall(HANDLES.wininpdef.exp);
hideall(HANDLES.wininpdef.comm);
hideall(HANDLES.runinpdef.comm);
hideall(HANDLES.runinpdef.edt);
hideall(HANDLES.outinpdef.edt);
hideall(HANDLES.outinpdef.comm);
return
