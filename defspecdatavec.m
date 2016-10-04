function defspecdatavec(iaxes)
%
%    Name: defspecdatavec
%
%    Usage: defspecdatavec(iaxes)
%
%    Defines the fields 'specdatavec' in the global
%    variable DISPLAY
%
%    iaxes = index of current axes
%
%

%   Version SWD970819
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

global DISPLAY DATA MODES indsvec

j = sqrt(-1);

%   Procedure for defining each specdatavec:
%   Extract the number of the datafile that contains this data
%   Extract the ensemble average number of the data to display
%   Extract the appropriate data function from the DATA variable


switch DISPLAY{iaxes}.ioverlay,
case 0,  %  No Overlay 
   indsvec = 1;
   inds = 1;
   iavg = DISPLAY{iaxes}.iavg{inds};
   idf = DISPLAY{iaxes}.idatafile{inds};
   switch DISPLAY{iaxes}.specfun{inds}
   case 'FRF', DISPLAY{iaxes}.specdatavec{inds} = DATA{idf}.G(:,:,:,iavg);    %FRF
   case 'Coherence', DISPLAY{iaxes}.specdatavec{inds} = DATA{idf}.Coh(:,:,:,iavg); DISPLAY{iaxes}.displayfun{inds} = 'SISO'; %COH
   case 'CPS', DISPLAY{iaxes}.specdatavec{inds} = DATA{idf}.Gxy(:,:,:,iavg);  %CPS
   case 'PSD Resp', DISPLAY{iaxes}.specdatavec{inds} = DATA{idf}.Gyy(:,:,iavg);   DISPLAY{iaxes}.displayfun{inds} = 'SISO';     %PSD Resp
   case 'PSD Ref', DISPLAY{iaxes}.specdatavec{inds} = DATA{idf}.Gxx(:,:,iavg);     DISPLAY{iaxes}.displayfun{inds} = 'SISO';    %PSD Ref
   case 'Time History', DISPLAY{iaxes}.specdatavec{inds} = DATA{idf}.thist(:,:,:,iavg);    %Time History
   end
case 1,  %  Secondary data Overlay
   indsvec = [1 2];
   for inds = indsvec,
      iavg = DISPLAY{iaxes}.iavg{inds};
      idf = DISPLAY{iaxes}.idatafile{inds};
      switch DISPLAY{iaxes}.specfun{inds}
      case 'FRF', DISPLAY{iaxes}.specdatavec{inds} = DATA{idf}.G(:,:,:,iavg);    %FRF
      case 'Coherence', DISPLAY{iaxes}.specdatavec{inds} = DATA{idf}.Coh(:,:,:); DISPLAY{iaxes}.displayfun{inds} = 'SISO'; %COH
      case 'CPS', DISPLAY{iaxes}.specdatavec{inds} = DATA{idf}.Gxy(:,:,:,iavg);  %CPS
      case 'PSD Resp', DISPLAY{iaxes}.specdatavec{inds} = DATA{idf}.Gyy(:,:,iavg);   DISPLAY{iaxes}.displayfun{inds} = 'SISO';     %PSD Resp
      case 'PSD Ref', DISPLAY{iaxes}.specdatavec{inds} = DATA{idf}.Gxx(:,:,iavg);     DISPLAY{iaxes}.displayfun{inds} = 'SISO';    %PSD Ref
      case 'Time History', DISPLAY{iaxes}.specdatavec{inds} = DATA{idf}.thist(:,:,:,iavg);    %Time History
      end
   end
   inds = 1;
case 2,  %  Statistical overlay
   indsvec = [1 2 3];
   inds = 1;
   idf = DISPLAY{iaxes}.idatafile{1};
   iavg = DISPLAY{iaxes}.iavg{1};
   inumsig = DISPLAY{iaxes}.inumsig;
   coh1sig = DATA{idf}.coh1sig;
   cps1sig = DATA{idf}.cps1sig; 
   switch DISPLAY{iaxes}.specfun{1},
      %  Define Mean, (mean + confidence interval), and (mean - confidence interval)
   case 'FRF',           
      mag1sig = DATA{idf}.mag1sig;
      phs1sig = DATA{idf}.phs1sig;
      mag = abs(DATA{idf}.G(:,:,:,iavg));
      phs = angle(DATA{idf}.G(:,:,:,iavg));
      j = sqrt(-1);
      DISPLAY{iaxes}.specdatavec{1} = DATA{idf}.G(:,:,:,iavg);
      DISPLAY{iaxes}.specdatavec{2}= (mag + inumsig*mag1sig) .* exp(j*phs + inumsig*phs1sig);
      DISPLAY{iaxes}.specdatavec{3} = (mag - inumsig*mag1sig) .* exp(j*phs - inumsig*phs1sig); 
   case 'Coherence',
      coh1sig = DATA{idf}.coh1sig;
      DISPLAY{iaxes}.specdatavec{1} = DATA{idf}.Coh(:,:,:); 
      DISPLAY{iaxes}.specdatavec{2} = DATA{idf}.Coh(:,:,:) + inumsig*coh1sig; 
      DISPLAY{iaxes}.specdatavec{3} = DATA{idf}.Coh(:,:,:) - inumsig*coh1sig; 
      DISPLAY{iaxes}.displayfun{inds} = 'SISO';
   case 'CPS', 
      cps1sig = DATA{idf}.cps1sig;
      DISPLAY{iaxes}.specdatavec{1} = DATA{idf}.Gxy(:,:,:,iavg);
      DISPLAY{iaxes}.specdatavec{2} = DATA{idf}.Gxy(:,:,:,iavg) + inumsig*cps1sig;
      DISPLAY{iaxes}.specdatavec{3} = DATA{idf}.Gxy(:,:,:,iavg) - inumsig*cps1sig;     
   case 'PSD Resp', DISPLAY{iaxes}.specdatavec{1} = DATA{idf}.Gyy(:,:,iavg); indsvec = 1; DISPLAY{iaxes}.displayfun{inds} = 'SISO';     %PSD Resp
   case 'PSD Ref', DISPLAY{iaxes}.specdatavec{1} = DATA{idf}.Gxx(:,:,iavg); indsvec = 1; DISPLAY{iaxes}.displayfun{inds} = 'SISO';    %PSD Ref
   case 'Time History', DISPLAY{iaxes}.specdatavec{inds} = DATA{idf}.thist(:,:,:,iavg);    %Time History
   end
case 3, %  Overlay synthesized FRF
   indsvec = [1 2];
   inds = 1;
   idf = DISPLAY{iaxes}.idatafile{1};
   iavg = DISPLAY{iaxes}.iavg{inds};
   switch DISPLAY{iaxes}.specfun{1},
   case 'FRF',
      DISPLAY{iaxes}.specdatavec{1} = DATA{idf}.G(:,:,:,iavg);
      DISPLAY{iaxes}.specdatavec{2} = zeros(size(DISPLAY{iaxes}.specdatavec{1}));
      for imode = 1:MODES.nmodes,
         pole = -MODES.Damp{imode} * 2*pi*MODES.Freq{imode} + ...
            j * 2*pi*MODES.Freq{imode} * sqrt(1-MODES.Damp{imode}^2);
         for iref = 1:size(MODES.residue{imode},1),
            for iresp = 1:size(MODES.residue{imode},2),
               DISPLAY{iaxes}.specdatavec{2}(:,iresp,iref) = DISPLAY{iaxes}.specdatavec{2}(:,iresp,iref) + ...
                  (MODES.residue{imode}(iref,iresp)./(j*DISPLAY{iaxes}.xvec.'*2*pi - pole) + ...
                  conj(MODES.residue{imode}(iref,iresp))./(j*DISPLAY{iaxes}.xvec.'*2*pi - conj(pole))) .* (DISPLAY{iaxes}.xvec.'*2*pi).^2;
               %/ 9.81^2; % ASSUMES ACCEL FRFs
            end
         end
      end
   case 'Coherence',
      DISPLAY{iaxes}.specdatavec{1} = DATA{idf}.Coh(:,:,:); 
      %  DISPLAY{iaxes}.specdatavec{2} = 
      DISPLAY{iaxes}.displayfun{inds} = 'SISO';
   case 'CPS', 
      DISPLAY{iaxes}.specdatavec{1} = DATA{idf}.Gxy(:,:,:,iavg);
      %  DISPLAY{iaxes}.specdatavec{2} = 
   case 'PSD Resp', 
      DISPLAY{iaxes}.specdatavec{1} = DATA{idf}.Gyy(:,:,iavg); 
      %  DISPLAY{iaxes}.specdatavec{2} = 
      DISPLAY{iaxes}.displayfun{inds} = 'SISO';
   case 'PSD Ref', 
      DISPLAY{iaxes}.specdatavec{1} = DATA{idf}.Gxx(:,:,iavg); 
      %  DISPLAY{iaxes}.specdatavec{2} = 
      DISPLAY{iaxes}.displayfun{inds} = 'SISO';
   end
end

%   Define the vector of x-coordinates for the display data

idf = DISPLAY{iaxes}.idatafile{inds};

switch DISPLAY{iaxes}.specfun{1},
case 'Time History',
   t0 = DATA{idf}.t0;
   t1 = DATA{idf}.t1;   
   ntim = size(DATA{idf}.thist,1);
   DISPLAY{iaxes}.xvec = linspace(t0,t1 - (t1-t0)/ntim,ntim);   
otherwise
   cf = DATA{idf}.cf;
   sp = DATA{idf}.sp;
   nlines = DATA{idf}.nlines;
   DISPLAY{iaxes}.xvec = linspace(cf-sp/2,cf+sp/2,nlines);
end

return