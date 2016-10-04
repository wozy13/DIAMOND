% Script: CEwindow.m
% 
% Usage: CEwindow
% 
% Description:
%    Puts Frequency and Damping into a matrix
%    Freq is a column vector of frequencies
%    Dampings a column vector of damping
%
%
% Version SWD970603
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

% Assign correct handle vector
   onHndlVector=handact(onHndlVector,hndlMatrix,9);

% Default master(plotted) response and reference
iresp=1;
iref=1;

nds = 1;
nn=1;
mm=1;

% Set up the frequency parameters
fmin=cf-sp/2;
fmax=cf+sp/2;
fs = 2*fmax;
fminm=fmin;
fmaxm=fmax;
f1=(fmaxm-fminm)*.25;
f2=(fmaxm-fminm)*.75;
df=sp/(nlines-1);
numbins=(fmax-fmin)/df;
i1=numbins*.25;
i2=numbins*.75;
freq=fminm:df:fmaxm;

% Axes handles
haxes = onHndlVector(16);   
hlegax = [];

%
%  Set various ui parameters correctly
%

%  Low Frequency Slider parameters

set(onHndlVector(6),'max',fmax);
set(onHndlVector(6),'min',fmin);
set(onHndlVector(6),'value',f1);
set(onHndlVector(6),'userdata',freq);
set(onHndlVector(6),'sliderstep',[df/(fmax - fmin) 0.1]);

%  Low Frequency text box parameters

set(onHndlVector(8),'string',f1);

%  High Frequency slider parameters

set(onHndlVector(9),'max',fmax);
set(onHndlVector(9),'min',fmin);
set(onHndlVector(9),'value',f2);
set(onHndlVector(9),'userdata',freq);
set(onHndlVector(9),'sliderstep',[df/(fmax - fmin) 0.1]);

%  High Frequency text box parameters

set(onHndlVector(11),'string',f2);

% Draw the f1 and f2 sliders correctly
set(onHndlVector(6),'pos',[.13 .01 .2 0.04]);
set(onHndlVector(9),'pos',[.55 .01 .2 0.04]);

%  Make the Initial Plot
set(hplttl(16),'string','Magnitude CMIF')
eval(get(hplttl(16),'call'))

lnst = ['- ';'- ';'- '];
lnco = ['y';'r';'b'];
set(hplttl(11),'string','Primary Data|Low Cursor|High Cursor')

%  Set the variables for Plottools
flim = get(haxes(1),'xlim');
ylim = get(haxes(1),'ylim');
set(hplttl(3),'string',num2str(flim(1)))
set(hplttl(5),'string',num2str(flim(2)))
set(hplttl(7),'string',num2str(ylim(1)))
set(hplttl(9),'string',num2str(ylim(2)))
yminm = ylim(1);
ymaxm = ylim(2);

defhline

% Set up the cursors
onHndlVector(12:13) = plotline(onHndlVector(12:13),...
			onHndlVector(16),f1,ymaxm,yminm,lnst(2,:),lnco(2,:));
onHndlVector(14:15) = plotline(onHndlVector(14:15),...
			onHndlVector(16),f2,ymaxm,yminm,lnst(3,:),lnco(3,:));

hline = [hline;onHndlVector(12);onHndlVector(14)];



