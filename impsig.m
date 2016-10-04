% Generate an user-specified impulse function
%
%This routine will generate a user specified, half sine wave impulse. The
function [x,time]=impsig(T,td,f,t,nt);


%user will specify %the pulse duration, t, the peak amplitude, F, the time
%delay, td,  for the start of the %pulse, and the number of points used to
%describe the impulse, nt, and the total length of the signal,T.  Since
%the signal is equally spaced, be sure to choose a large enough number
%of points to capture the impulse.  The signal is designed to be 
%equally spaced to allow simulation.


%round delay time and duration time to nearest dt
dt=T/nt;
tdn=round(td/dt)*dt;
tn=round(t/dt)*dt;

%define the impulse
ttemp=linspace(0,tn,round(t/dt));
fr=1/(2*tn);
sig=f*sin(2*pi*fr*ttemp);


%insert the impulse in the correct position in the signal
x=zeros(1,nt);
x(round(td/dt)+1:round(td/dt)+round(t/dt))=sig;
time=linspace(0,T,nt);
