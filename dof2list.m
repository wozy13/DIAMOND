function [xfp,yfp,DI,xlist,ylist] = dof2list(DOFvec,Nodes,pltvec)
%
%  Name:   dof2list
%
%  Usage:  [xfp,yfp,DI,xlist,ylist] = dof2list(DOFvec,Nodes,pltvec)
%
%  Converts vector of indicator variables 'pltvec' to matrix 'DI'
%	according to list of DOF in 'DOFvec' and list of nodal locations
%	in 'Nodes'. 'xlist' and 'ylist' are sorted lists of nodal x and y locations,
%	'xfp' and 'yfp' are corresponding plaid matrices.
%  

%  Version SWD970117
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

%  Generate xfp,yfp,DI
%

xlist = [];
ylist = [];

for i = 1:length(DOFvec),

	nnode = find( Nodes(:,1) == DOFvec(i,1));

       	if isempty(find(xlist == Nodes(nnode,2))),
		xlist = [xlist;Nodes(nnode,2)];
	end

	if isempty(find(ylist == Nodes(nnode,3))),
		ylist = [ylist;Nodes(nnode,3)];
	end

end

xlist = sort(xlist);
ylist = sort(ylist);

[xfp,yfp] = meshgrid(xlist,ylist);
DI = zeros(size(xfp));


for i = 1:size(xfp,1),
	for j = 1:size(xfp,2),
		nnode = find(Nodes(:,2) == xfp(i,j) & Nodes(:,3) == yfp(i,j));
		DI(i,j) = pltvec(nnode);
	end
end

