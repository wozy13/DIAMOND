function inpokhand

global sys HANDLES

if sys.input.n==1
   sys.input.ran.T=str2num(get(HANDLES.siminpdef.edt(1),'string'));
   sys.input.ran.nt=str2num(get(HANDLES.siminpdef.edt(2),'string'));
   sys.input.ran.frsd=str2num(get(HANDLES.siminpdef.edt(3),'string'));
   [sys.input.x,sys.input.t]=...
      ransiggen(1,sys.input.ran.nt,sys.input.ran.T,sys.input.ran.frsd);
end

if sys.input.n==2
   sys.input.har.T=str2num(get(HANDLES.siminpdef.edt(1),'string'));
   sys.input.har.nt=str2num(get(HANDLES.siminpdef.edt(2),'string'));
   sys.input.har.nc=str2num(get(HANDLES.siminpdef.edt(3),'string'));
   sys.input.har.fr=str2num(get(HANDLES.siminpdef.edt(4),'string'));
   sys.input.har.amp=str2num(get(HANDLES.siminpdef.edt(5),'string'));
   sys.input.har.strt=str2num(get(HANDLES.siminpdef.edt(6),'string'));
   sys.input.har.stop=str2num(get(HANDLES.siminpdef.edt(7),'string'));
   [sys.input.x,sys.input.t]=...
      harm(sys.input.har.nc, sys.input.har.nt, sys.input.har.T,...
      sys.input.har.fr, [sys.input.har.strt' sys.input.har.stop'],...
      sys.input.har.amp);
end
   
if sys.input.n==3
   sys.input.imp.T=str2num(get(HANDLES.siminpdef.edt(1),'string'));
   sys.input.imp.nt=str2num(get(HANDLES.siminpdef.edt(2),'string'));
   sys.input.imp.t=str2num(get(HANDLES.siminpdef.edt(3),'string'));
   sys.input.imp.td=str2num(get(HANDLES.siminpdef.edt(4),'string'));
   sys.input.har.f=str2num(get(HANDLES.siminpdef.edt(5),'string'));
   [sys.input.x,sys.input.t]=...
      impsig(sys.input.imp.T, sys.input.imp.t, sys.input.imp.T,...
      sys.input.imp.td, sys.input.imp.nt);
end

if sys.input.n==4;
   sys.input.t=evalin('base',get(HANDLES.siminpdef.edt(1),'string'));
   sys.input.x=evalin('base',get(HANDLES.siminpdef.edt(2),'string'));
   sys.input.T=max(sys.input.t);
else
   sys.input.T=str2num(get(HANDLES.siminpdef.edt(1),'string'));
end


hideallbtns
set(HANDLES.hmmenu{20}(3),'enable','on')
set(HANDLES.hmmenu{20}(4),'enable','on')