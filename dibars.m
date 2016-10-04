function [DImat,intlocs] = dibars(Nodes,SEMbeams,phi_undam,phi_dam,respDOF,interpopt,numdiv,mode_anal)
%
%  Name: dibars
%
%  Usage: [DImat,intlocs] = dibars(Nodes,SEMbeams,phi_undam,phi_dam,respDOF,interpopt,numdiv,mode_anal)
%
%  This m-file calculates the damage index for each bar element
%    using the fractional strain energy technique (Stubbs, et. al.)
%
%   Inputs:	
%  	Nodes = List of nodes in DIAMOND geometry format
%     SEMbeams  = List of beam superelements with which to form SEM indices
%     phi_undam = matrix of mode shapes from undamaged structure
%     phi_dam = matrix of mode shapes from damaged structure
%     interpopt = 'linear','spline', or 'cubic'
%     numdiv = number of divisions for damage index computation
%     mode_anal = vector of modes to use in the analysis
%  	
%
%   Outputs:
%
%     DImat = Matrix of Normalized Damage Index values for
%             each interpolated element
%             (# rows = size(SEMbeams,1))
%             (# columns = numdiv)
%

%  Version SWD970830
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

fprintf(1,'Calculating damage index for Beam elements...');

%
%  Allocate variables
%

nbeams = length(SEMbeams);
nmod = length(mode_anal);

beta = zeros(nbeams,numdiv);

%  Define number of integration segments per division

nn=4;

%  Define total number of interpolated points per beam

numint = numdiv*nn + 1;

%  Loop over all of the SEM beams

for ibeam = 1:nbeams,
   
   thisbeam = SEMbeams{ibeam}(2:end);
   
   nbnodes = length(thisbeam); % number of measurement nodes describing this beam
   
   %  Determine which nodes lie along this beam
   
   rnod = zeros(nbnodes,1);
   
   for inod = 1:nbnodes,
      
      rnod(inod) = find(Nodes(:,1) == thisbeam(inod));
      
   end
   
   %
   %  ASSUME: beams lie in x-y plane, and sensors are in +Z direction
   %
   
   %  Define which response DOF corresponds to each node
   
   resprow = zeros(nbnodes,1);
   
   for iresp = 1:nbnodes,
      
      resprow(iresp) = find(respDOF(:,1) == Nodes(rnod(iresp),1) & respDOF(:,2) == 3);
      
   end

   %  Convert x and y coordinates to simple length coordinates (2D to 1D), and
   %    define mode shape vectors at those coordinates
   
   %    ASSUME: First and last node numbers in SEMbeam define endpoints
   
   beamlen = norm(Nodes(rnod(nbnodes),2:4) - Nodes(rnod(1),2:4));
   
   %  Now, define the desired coordinates of this beam to go from zero to "beamlen"
   %    These are the points at which the interpolated values will be computed
   %    (including both elemental divisions and integration segments)
   
   xvecinterp = linspace(0,beamlen,numint);
   
   %  Define the x and y-versions of the interpolated points, so that the damage
   %    indices can be correctly plotted
   
   xlocint = linspace(Nodes(rnod(1),2),Nodes(rnod(nbnodes),2),numdiv+1);
   ylocint = linspace(Nodes(rnod(1),3),Nodes(rnod(nbnodes),3),numdiv+1);
   zlocint = linspace(Nodes(rnod(1),4),Nodes(rnod(nbnodes),4),numdiv+1);
   
   intlocs{ibeam} = struct('xloc',xlocint,'yloc',ylocint,'zloc',zlocint);
   
   %  For the interpolation, we need the "new" coordinates of the measurement nodes
   %    These are the points that the interpolation will be based on
   %    Also, define the known mode shape values at each point
   
   xvec = zeros(nbnodes,1);
   phiu_sort = zeros(nbnodes,nmod);
   phid_sort = zeros(nbnodes,nmod);
   
   for i = 1:nbnodes,
      
      xvec(i) = norm(Nodes(rnod(i),2:4) - Nodes(rnod(1),2:4));
      for j = 1:nmod,
         phiu_sort(i,j) = phi_undam{mode_anal(j)}(resprow(i));
         phid_sort(i,j) = phi_dam{mode_anal(j)}(resprow(i));
      end
   end
   
   %  Interpolate each mode shape to interior beam locations, and
   %    compute curvature along each interpolated beam
   
   phiu_int = zeros(numint,nmod);
   phid_int = zeros(numint,nmod);
   phiu_curv = zeros(numint,nmod);
   phid_curv = zeros(numint,nmod);
   
   dxgrad = beamlen / (numint-1); % length of each integration segment
   
   for imod = 1:nmod,
      
      phiu_int(:,imod) = interp1(xvec,phiu_sort(:,imod),xvecinterp,interpopt)';
      phid_int(:,imod) = interp1(xvec,phid_sort(:,imod),xvecinterp,interpopt)';
      
      phiu_curv(:,imod) = gradient(gradient(phiu_int(:,imod),dxgrad),dxgrad);
      phid_curv(:,imod) = gradient(gradient(phid_int(:,imod),dxgrad),dxgrad);
      
   end
   
   %  Compute fractional strain energy over each beam segment
   
   Efrac = zeros(numdiv,nmod);
   Efracd = zeros(numdiv,nmod);
   
   for imod = 1:nmod
      
      for j = 1:numdiv
         
          xval = xvecinterp((j-1)*nn + 1 : j*nn + 1);
          phiu_val = phiu_curv((j-1)*nn+1 : j*nn + 1,imod).^2;
          phid_val = phid_curv((j-1)*nn+1 : j*nn + 1,imod).^2;
          
          Efrac(j,imod)=trapz(xval,phiu_val);
          Efracd(j,imod)=trapz(xval,phid_val);
      
       end
       
    end
    
    %  Compute Total strain energy (undamaged and damaged) for each mode

   Etot = sum(Efrac,1);
   Etotd = sum(Efracd,1);
   
   %  Compute Beta
   
   betanum = zeros(numdiv,nmod);
   betaden = zeros(numdiv,nmod);

   for imod = 1:nmod,

      for idiv = 1:numdiv,
  
         betanum(idiv,imod) = betanum(idiv,imod) + (Efracd(idiv,imod)+Etotd(imod))/Etotd(imod);
         betaden(idiv,imod) = betaden(idiv,imod) + (Efrac(idiv,imod)+Etot(imod))/Etot(imod);
         
      end
      
   end

   betanumt = sum(betanum,2);
   betadent = sum(betaden,2);
   
   
   beta(ibeam,:) = betanumt' ./ betadent';
   
end  % END loop over all SEMbeams

   
%  Normalize the damage index
   
avebeta = mean(beta(:));
stdbeta = std(beta(:));

DImat = (beta-avebeta)/stdbeta;

disp('DONE with SEM computation for Beam elements')

return