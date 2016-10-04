function loaddata(pathname,filename,indf)
%
%  Name:   loaddata
%
%  Usage:  loaddata(pathname,filename,indf)
%
%  Loads the datafile variables into the 
%  global variable DATA
%
%  indf = index in DATA to store data from datafile

%  Version SWD970731
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

global DATA HANDLES

eval(['load ',[pathname,filename]]);

if exist('DATA_STORE') == 1,
   
   DATA{indf} = DATA_STORE;
   DATA{indf}.filename = filename;
   DATA{indf}.pathname = pathname;   
   
else
   
   if exist('filename') == 1,
      
      DATA{indf}.filename = filename;
      DATA{indf}.pathname = pathname;
   
   end


   if exist('G')==1,
   
      nresp = size(G,1)/nlines;
      nref = size(G,2);
      
      for iref = 1:nref,
      
         for iresp = 1:nresp,
         
            DATA{indf}.G(:,iresp,iref,:) = G((iresp-1)*nlines+1 : iresp*nlines,iref,:);
         
         end
      end

   end

   if exist('Coh') == 1,
   
      for iref = 1:nref,
      
         for iresp = 1:nresp,
         
            DATA{indf}.Coh(:,iresp,iref,:) = Coh((iresp-1)*nlines+1 : iresp*nlines,iref,:);
         
         end
      end
   end


   if exist('Gxy'),
      for iref = 1:nref,
         
         for iresp = 1:nresp,
         
            DATA{indf}.Gxy(:,iresp,iref,:) = Gxy((iresp-1)*nlines+1 : iresp*nlines,iref,:);
         
         end
      end
      
   end

   if exist('Gxx') == 1,
      
      for iref = 1:nref,
      
         DATA{indf}.Gxx(:,iref,:) = Gxx(:,iref,:);
         
      end
   end

   if exist('Gyy') == 1,
        
      for iresp = 1:nresp,
         
         DATA{indf}.Gyy(:,iresp,:) = Gyy((iresp-1)*nlines+1 : iresp*nlines,:);
        
      end

   end
   
   if exist('navg') == 1,
      
      DATA{indf}.navg = navg;
   
   end
   
   if exist('cf') == 1,
      
      DATA{indf}.cf = cf;
   
   end

   if exist('nlines') == 1,
      
      DATA{indf}.nlines = nlines;
   
   end

   if exist('sp') == 1,
      
      DATA{indf}.sp = sp;
   
   end

   if exist('test_type') == 1,
      
      DATA{indf}.test_type = test_type;
   
   end

   if exist('domain') == 1,
      
      DATA{indf}.domain = domain;
   
   end

   if exist('refDOF') == 1,
      
      DATA{indf}.refDOF = refDOF;
   
   end

   if exist('respDOF') == 1,
      
      DATA{indf}.respDOF = respDOF;
   
   end

   if exist('t0') == 1,
      
      DATA{indf}.t0 = t0;
   
   end

   if exist('t1') == 1,
      
      DATA{indf}.t1 = t1;
   
   end 
   
   if exist('thist') == 1,
      
      DATA{indf}.thist = thist;
   
   end       
  
end
   
%set(HANDLES.hmmenu{4}(1),'enable','on')
%set(HANDLES.hmmenu{5}(1),'enable','on')
%set(HANDLES.hmmenu{17}(1),'enable','on')

return