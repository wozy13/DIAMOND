function [DImat,DIloc] = dishls(Nodes,SEMquads,phi_undam,phi_dam,respDOF,interpopt,numdiv,mode_anal,nu)
%
%  Name:
%
%  Usage:
%
%  This m-file calculates the damage index for each shell element
%    using the fractional strain energy technique (Cornwell, et. al.)
%
%   Inputs:	
%  	Nodes = List of nodes in DIAMOND geometry format
%     Shells  = List of shells in DIAMOND geometry format
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
%             (# rows = size(Bars,1))
%             (# columns = numdiv)
%

%  Version SWD970916
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


fprintf(1,'Calculating damage index for Shell elements...');

%
%  Allocate Variables
%

nquads = length(SEMquads);
nmod = length(mode_anal);

betanum = zeros(numdiv,numdiv);
betaden = zeros(numdiv,numdiv);

beta = zeros(nquads,numdiv,numdiv);

%
%  Define number of integration points per division (in each direction)
%

nn = 3;

%  Define total number of interpolated points per beam in each direction

numint = numdiv * nn + 1;

%  Loop over the SEM quads

for iquad = 1:nquads,
   
   thisquad = SEMquads{iquad}(2:end);
   
   nnodes = length(thisquad); % Nodes which define this quad
   
   %  Determine which nodes define this quad
   
   rnod = zeros(nnodes,1);
   
   for inod = 1:nnodes,
      
      rnod(inod) = find(Nodes(:,1) == thisquad(inod));
      
   end
   
   %
   %  ASSUME: quads lie in x-y plane, are oriented in x-y direction,
   %    and sensors are in +Z Direction
   
   %  Define which response DOF corresponds to each node
   
   resprow = zeros(nnodes,1);
   
   for iresp = 1:nnodes,
      
      resprow(iresp) = find(respDOF(:,1)==Nodes(rnod(iresp),1) & respDOF(:,2) == 3);
      
   end
   
   %
   %  Define interpolation points
   %
   
   %     Determine minimum and maximum x and y coordinate values
   
   xmin = min(Nodes(rnod,2));
   xmax = max(Nodes(rnod,2));
    
   ymin = min(Nodes(rnod,3));
   ymax = max(Nodes(rnod,3));
   
   %     Determine vectors of interpolated points

   xintvec = linspace(xmin,xmax,numint);
   yintvec = linspace(ymin,ymax,numint);
   
   dx = xintvec(2) - xintvec(1);
   dy = yintvec(2) - yintvec(1);
   
   %intlocs{iquad} = struct('xloc',xintvec,'yloc',yintvec);
   
   %     Build vectors of coordinates and mode shapes for existing points
   
   
   xvec = zeros(nnodes,1);
   yvec = zeros(nnodes,1);
   
   phiu_sort = zeros(nnodes,nmod);
   phid_sort = zeros(nnodes,nmod);
   
   for i = 1:nnodes,
      
      xvec(i) = Nodes(rnod(i),2);
      yvec(i) = Nodes(rnod(i),3);
      
      for j = 1:length(mode_anal),
         phiu_sort(i,j) = phi_undam{mode_anal(j)}(resprow(i));
         phid_sort(i,j) = phi_dam{mode_anal(j)}(resprow(i));
      end
      
   end
   
   %  Interpolate each mode shape to interior quad locations,
   %   and compute curvature along each interpolated quad
   
   phiu_int = zeros(numint,numint,nmod);
   phid_int = zeros(numint,numint,nmod);
   
   phiu_curv = zeros(numint,numint,nmod);
   phid_curv = zeros(numint,numint,nmod);
      
   for imod = 1:nmod,
      
      phiu_int(:,:,imod) = griddata(xvec,yvec,phiu_sort(:,imod),xintvec',yintvec,'cubic');
      phid_int(:,:,imod) = griddata(xvec,yvec,phid_sort(:,imod),xintvec',yintvec,'cubic');
      
      [px_u,py_u]=gradient(phiu_int(:,:,imod),dx,dy);
      [pxx_u,pxy_u]=gradient(px_u,dx,dy);
      [pyx_u,pyy_u]=gradient(py_u,dx,dy);
      
      [px_d,py_d]=gradient(phid_int(:,:,imod),dx,dy);
      [pxx_d,pxy_d]=gradient(px_d,dx,dy);
      [pyx_d,pyy_d]=gradient(py_d,dx,dy);
     
      %
      % Determine the integrand
      %
      
      fx_u=pxx_u.^2+pyy_u.^2+2*nu*pxx_u.*pyy_u+2*(1-nu)*pxy_u.^2;
      fx_d=pxx_d.^2+pyy_d.^2+2*nu*pxx_d.*pyy_d+2*(1-nu)*pxy_d.^2;
      
      
      %
      %  Do the integration
      %
      
      for i=1:numdiv
         
         for j=1:numdiv
            
            xvalues=xintvec((i-1)*nn+1:i*nn+1);
            yvalues=yintvec((j-1)*nn+1:j*nn+1);
            zvalues_u=fx_u((j-1)*nn+1:j*nn+1,(i-1)*nn+1:i*nn+1);
            zvalues_d=fx_d((j-1)*nn+1:j*nn+1,(i-1)*nn+1:i*nn+1);
            
            DIloc{iquad}.xloc{j,i} = xvalues([1 end]);
            DIloc{iquad}.yloc{j,i} = yvalues([1 end]);
            
            for k=1:nn+1
               
               temp_u(k)=trapz(yvalues,zvalues_u(:,k));
               temp_d(k)=trapz(yvalues,zvalues_d(:,k));

            end
            
            Efrac(j,i,imod)=trapz(xvalues,temp_u);
            Efracd(j,i,imod)=trapz(xvalues,temp_d);
            
         end
      end
            
      %  Sum the fractional energy over each mode
   
      Etot  = sum(Efrac(:));
      Etotd = sum(Efracd(:));
      
      %  Sum the betas
      
      betanum = betanum + (Efracd(:,:,imod)+Etotd)/Etotd;
      betaden = betaden + (Efrac(:,:,imod)+Etot)/Etot;
            
   end   % END of the integration over each mode shape
   
   beta(iquad,:,:) = betanum ./ betaden;
      
end   % END of the loop over each entry in SEMquad

avebeta=mean(beta(:));
stdbeta=std(beta(:));
DImat=(beta-avebeta)/stdbeta; 

disp('DONE with SEM computation for Quad elements')
      
return
