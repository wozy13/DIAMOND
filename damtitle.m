function damtitstr = damtitle(analysis_type,pathname_u,filename_u,pathname_d,filename_d,detail_string)
%
%  Name:   damtitle
%
%  Usage:  damtitstr = damtitle(analysis_type,pathname_u,filename_u,pathname_d,filename_d,detail_string)

%
%

%  Version SWD970703
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

%  Build the Analysis Type string

%anstr = ['{\it\bfAnalysis Type:} ',analysis_type];
anstr = ['Analysis Type: ',analysis_type];

%  Build analysis detail string

andetstr = ['|Analysis Details: ',detail_string];

%  Build the undamaged file and pathname

ufilestr = ['|Undamaged Data:  ',pathname_u,filename_u];

%  Build the Damaged file and pathname

dfilestr = ['|Damaged Data: ',pathname_d,filename_d];

%  Build the title string

damtitstr = sprintf('%s%s%s%s',anstr,andetstr,ufilestr,dfilestr);

return