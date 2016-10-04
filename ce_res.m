function [residue] = ce_res (Y,G,nlines,this_lambda)

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

this_size = length(this_lambda);
nresp  = size(G,1) / nlines;
nref   = size(G,2);

%  Compose V matrix
V = zeros(this_size,this_size);
for n = 1:this_size
  V(n,:) = (this_lambda.^(n-1))';
end

% Solve for residues
fprintf(1,'Solving for residues ...');
residue = zeros(nref*nresp,this_size);
for p  = 1:nref
  for k = 1:nresp
    % Solve for 2 residues for each DOF for each lambda
    H = Y(k:nresp:k+nresp*(this_size - 1),p);
    residue(k+(p-1)*nresp,:) = (V\H)';
  end
end

return