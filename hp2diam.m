%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%
% Script:   hp2diam.m
% Path:     C:\Diamond or C:\Scripts
% Purpose:  To convert the hp translated matlab files into Diamond
%           format.
% Input:    6 Files: coherence.mat crosspow.mat freqresp.mat
%           inputpow.mat insttime.mat outputpo.mat
% Output:   Diamond compatible file *_data.mat (8 char basename)
% Author:   Erik Gregory Straser (modified by S. W. Doebling)
% Version:  1.6
% Date:     August 6, 1996 (modified June 6, 1998)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
clear;

[null, path] = uigetfile('*.mat', 'Choose a file in the new directory');

eval(['cd ', path]);

[dest_file, dest_path] = uigetfile('*.mat', 'Destination file:');

temp = input('Enter the reference DOF Number: (Default = 32)  ');
if isempty(temp)
  refDOF(1,1) = 32;
else
  refDOF(:,1) = temp;
end

temp = input('Enter the direction of the reference channel: (X=1,Y=2,Z=3 Default=3)  ');
if isempty(temp)
  refDOF(1,2) = 3;
else
  refDOF(:,2) = temp;
end

max_channel = input('Enter the maximum channel number: (Default = 32)  ');
if isempty(max_channel)
  max_channel = 32;
end

%Making G Matrix
load freqresp.mat
nlines = size (eval(['o1i',int2str(refDOF(1,1))]),1);
x0 = eval(['o1i',int2str(refDOF(1,1)),'x0']);
xi = eval(['o1i',int2str(refDOF(1,1)),'xi']);
sp = xi*(nlines-1);
cf = (x0 + sp)/2;
domain = 'Frequency Domain';
index = 1;
respDOF = zeros(max_channel - size(refDOF,1),1);
G = zeros(nlines * (max_channel - size(refDOF,1)),1);

for i = 1:max_channel
  if i ~= refDOF(1,1)
    file_index =  ['o',int2str(i),'i',int2str(refDOF(1,1))];
    filename = [file_index];
    if exist (filename)
      G( (index-1)*nlines+1 : index*nlines,1) = eval([filename]);
      respDOF(index,1) = i;
      respDOF(index,2) = 3;
      index = index + 1;
      eval(['clear ' filename]);
      eval(['clear ', filename,'x0']);
      eval(['clear ', filename,'xi']);
      eval(['clear ', filename,'xl']);
      DATA_STORE.G(:,index,1,:) = G((index-1)*nlines+1 : index*nlines,1,:);
    end
  end
end

%Making Coh Matrix

if exist('coherenc.mat') == 2,

load coherenc.mat
index = 1;
Coh = zeros(nlines*(max_channel - size(refDOF,1)),1);
for i = 1:max_channel
  if i ~= refDOF(1,1)
    file_index =  ['o',int2str(i),'i',int2str(refDOF(1,1))];
    filename = [file_index];
    if exist (filename)
      Coh((index-1)*nlines+1 : index*nlines,1) = eval([filename]);
      index = index + 1;
      eval(['clear ' filename]);
      eval(['clear ', filename,'x0']);
      eval(['clear ', filename,'xi']);
      eval(['clear ', filename,'xl']);
      DATA_STORE.Coh(:,index,1,:) = Coh((index-1)*nlines+1 : index*nlines,1,:);
    end
  end
end

end

%Making Gxy Matrix
load crosspow.mat
index = 1;
Gxy = zeros(nlines*(max_channel - size(refDOF,1)),1);
for i = 1:max_channel
  if i ~= refDOF(1,1)
    file_index =  ['o',int2str(i),'i',int2str(refDOF(1,1))];
    filename = [file_index];
    if exist (filename)
      Gxy((index-1)*nlines+1 : index*nlines,1) = eval([filename]);
      index = index + 1;
      eval(['clear ' filename]);
      eval(['clear ', filename,'x0']);
      eval(['clear ', filename,'xi']);
      eval(['clear ', filename,'xl']);
      DATA_STORE.Gxy(:,index,1,:) = Gxy((index-1)*nlines+1 : index*nlines,1,:);
    end
  end
end

%Making Gxx Matrix
load inputpow.mat
Gxx = zeros(nlines*size(refDOF,1),1);
index = 1;
for i = 1:max_channel
  file_index =  ['c',int2str(i)];
  filename = [file_index];
  if exist (filename)
    Gxx((index-1)*nlines+1 : index*nlines,1) = eval([filename]);
    index = index + 1;
    eval(['clear ' filename]);
    eval(['clear ', filename,'x0']);
    eval(['clear ', filename,'xi']);
    eval(['clear ', filename,'xl']);
    DATA_STORE.Gxx(:,1,:) = Gxx(:,1,:);
  end
end

% Making Gyy Matrix
load outputpo.mat
Gyy = zeros(nlines*(max_channel - size(refDOF,1)),1);
index = 1;
for i = 1:max_channel
  if i ~= refDOF(1,1)
    file_index =  ['c',int2str(i)];
    filename = [file_index];
    if exist (filename)
      Gyy((index-1)*nlines+1 : index*nlines,1) = eval([filename]); 
      index = index + 1;
      eval(['clear ' filename]);
      eval(['clear ', filename,'x0']);
      eval(['clear ', filename,'xi']);
      eval(['clear ', filename,'xl']);
      DATA_STORE.Gyy(:,index,:) = Gyy((index-1)*nlines+1 : index*nlines,:);
    end
  end
end

%Making thist Matrix
load insttime.mat
t0 = c1x0;
t1 = c1x0 + (c1xi*size(c1,1));
thist = zeros(size(c1,1),max_channel - size(refDOF,1));
index = 1;
for i = 1:max_channel
  file_index =  ['c',int2str(i)];
  filename = [file_index];
  if exist (filename)
    thist(:,index) = eval([filename]);
    index = index + 1;
    eval(['clear ' filename]);
    eval(['clear ', filename,'x0']);
    eval(['clear ', filename,'xi']);
    eval(['clear ', filename,'xl']);
    DATA_STORE.thist(:,index) = thist(:,index);
  end
end

% Other DIAMOND Variables

DATA_STORE.navg = navg;
DATA_STORE.cf = cf;
DATA_STORE.nlines = nlines;
DATA_STORE.sp = sp;
DATA_STORE.test_type = test_type;
DATA_STORE.domain = domain;
DATA_STORE.refDOF = refDOF;
DATA_STORE.respDOF = respDOF;      
DATA_STORE.t0 = t0;
DATA_STORE.t1 = t1;


% Save the file with the correct Diamond variables
eval(['save ',this_path,this_file,' DATA_STORE']);

fprintf(1,'\n***  Diamond compatible data is in %s%s.mat  ***\n\n',this_path,this_file);

clear;
return;
