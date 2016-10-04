function [x,t]=harm(numComponents,numPoints,lenT,freq,startStop,amp)
%
% [x,t]=harm(numComponents,numPoints,lenT,freq,startStop,amp)
% generates a signal, x, and associated time vector, t,
% consisting of the sum of harmonics of various durations, 
% amplitudes, and frequencies.  
%
% numComponents is the desired number of frequency components. 
% numPoints is the number of points desired to represent the signal.  
% lenT is the total desired time of the signal.  freq is a vector of length
% numComponents whose elements are the frequencies for each component.  
% startStop is a numComponents-by-2 matrix whose rows specify the start
% and stop times for each component. Amp is a vector of length 
% numComponents whose elements are the amplitude of each component.
%




t=linspace(0,lenT,numPoints);

start=startStop(:,1);
stop=startStop(:,2);


%round to nearest half cycle to minimize discontinuities
for i=1:numComponents
   dt=stop(i)-start(i);
   temp=round(dt*freq(i)*2);
   dt=temp/(2*freq(i));
   stop(i)=start(i)+dt;
end

%assemble components
for i=1:numComponents
   comp(i,:)=zeros(1,numPoints);
   startIndex=round(start(i)*(numPoints-1)/lenT+1);
   stopIndex=round(stop(i)*numPoints/lenT);
   comp(i,startIndex:stopIndex)=...
      amp(i)*sin(2*pi*freq(i)*...
      (t(startIndex:stopIndex)-t(startIndex)));
end

x=sum(comp,1);
