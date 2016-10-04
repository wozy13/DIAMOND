function textin=DItext(xfp,yfp,DI,diropt,filtopt,DImin,islop)
%
%  Name: DItext
% 
%  Usage: textin=DItext(xfp,yfp,DI,diropt)
% 
%   Description:
%     -makes textin for DIresults.m
%   inputs:
%	
%
%  Version PJC960530
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

clear temp1
if islop==2
   xlist=xfp(:);
   ylist=yfp(:);
   zlist=DI(:);
else,
  if diropt==2
    xlist=xfp(:);
    ylist=(yfp*ones(1,size(xfp,1)))';
    ylist=ylist(:);
    zlist=DI(:);
  else,
    ylist=xfp(:);
    xlist=(yfp*ones(1,size(xfp,1)))';
    xlist=xlist(:);
    zlist=DI(:);
  end,
end,
if filtopt==1,
   for i=1:length(xlist);
     temp1(i,:)=sprintf('%8.2f   %8.2f   %7.4f ',xlist(i),ylist(i),zlist(i));
   end;
else,
   filtindex=find(abs(zlist)>DImin);
   for i=1:length(filtindex);
     temp1(i,:)=sprintf('%8.2f   %8.2f   %7.4f ',xlist(filtindex(i)),ylist(filtindex(i)),zlist(filtindex(i)));
   end;
end;
temp=('    x          y          DI');
textin=str2mat(temp,temp1);
