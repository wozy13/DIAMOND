function listgeom
%
%  Name: listgeom
%
%  Usage: listgeom
%
%  Lists the selected geometry item descriptions to the editgeom listbox
%

%
%  Version SWD970806
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

global EDITGEOM GEOM HANDLES


switch  EDITGEOM.nselsw
case 1, 
   EDITGEOM.titlestr = sprintf('%5s%9s%9s%9s%1s','Label','X','Y','Z','|');
   bodystr = EDITGEOM.titlestr;
   for i=1:size(GEOM.Nodes,1)
      bodystr= [bodystr, sprintf('%5.0f%9.2f%9.2f%9.2f%1s',GEOM.Nodes(i,:),'|')];
   end
case 2,
   EDITGEOM.titlestr = sprintf('%5s%9s%9s%1s','Label','Node 1','Node 2','|');
   bodystr = EDITGEOM.titlestr;
   for i=1:size(GEOM.Bars,1)
      bodystr= [bodystr, sprintf('%5.0f%9.0f%9.0f%1s',GEOM.Bars(i,:),'|')];
   end
case 3,
   EDITGEOM.titlestr = sprintf('%15s','Label    Nodes|');
   bodystr = EDITGEOM.titlestr;
   for i=1:length(GEOM.SEMbeams),
      bodystr= [bodystr,sprintf('%-6.0f',GEOM.SEMbeams{i}(1)),sprintf('%5.0f',GEOM.SEMbeams{i}(2:end)),'|'];
   end
case 4,
   EDITGEOM.titlestr = sprintf('%15s','Label    Nodes|');
   bodystr = EDITGEOM.titlestr;
   for i=1:length(GEOM.SEMquads),
      bodystr= [bodystr,sprintf('%-6.0f',GEOM.SEMquads{i}(1)),sprintf('%5.0f',GEOM.SEMquads{i}(2:end)),'|'];
   end
case 5,
   EDITGEOM.titlestr = sprintf('%5s%9s%9s%9s%9s%1s','Label','Node 1','Node 2','Node 3','Node 4','|');
   bodystr = EDITGEOM.titlestr;
   for i=1:size(GEOM.Shells,1)
      bodystr= [bodystr, sprintf('%5.0f%9.0f%9.0f%9.0f%9.0f%1s',GEOM.Shells(i,:),'|')];
   end   
case 6,
   EDITGEOM.titlestr = sprintf('%5s%9s%9s%1s','Label','Node 1','Node 2','|');
   bodystr = EDITGEOM.titlestr;
   for i=1:size(GEOM.Tracelines,1)
      bodystr= [bodystr, sprintf('%5.0f%9.0f%9.0f%1s',GEOM.Tracelines(i,:),'|')];
   end
end

set(HANDLES.heditgeom(4),'string',bodystr)

return