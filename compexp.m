function [Y, this_lambda, freq_compexp, zeta_compexp, fs_out,err] = compexp(G,nlines,delta_f,fmin,fmax,fs,m,master_ref,master_resp)
%  
%  Usage: function [Y, this_lambda, freq, zeta, fs_out,err] = compexp(G,nlines,delta_f,fmin,fmax,fs,m,master_ref,master_resp)
%
%  Applies the Complex Exponential Time Domain Algorithm to the 
%  impulse response from the FRF data matrix [G]
%
%  Input:
%  G matrix is the frequency response functions in columns
%  nlines is the number of frequency bins in the FRF data matrix [G]
%  delta_f is the frequency resolution = 1/T
%  fmin andfmax are the freuquency range in Hertz of interest
%  fs is the twice the effective nyquist frequency
%  m is the number of poles (2*m+1 time steps) to fit (2 poles per mode)
%  master_ref and master_resp are the input/ouput pair from which the poles are
%  calculated and the residues later calculated from.
%
%  Output:
%  impulse response matrix(padded), poles found within fmin to fmax range,
%  frequencies and dampings found in the poles, and the 'revised' sample rate 
%  fs_out (due to zero-padding)
%  err is nonzero if no poles were found
%
%  The columns of lambda(size this_size by 1) are the continuous system
%  eigenvalues of a particular input/output pair.
%
%  Reference for Complex Exponential Method:
%  "Modal Testing:  Theory and Practice", D. J. Ewins, John Wiley and Sons,
%  Great Britian, 1984, Pages 180 - 186.
%  "Vibrations: Experimental Modal Analysis", Dr. Randall J. Allemang,
%  University of Cincinnati, UC-SDRL-CN-20-263-663/664, 1995, Chapter 6.
%
%  Version SWD970603
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

% Define variables and allocate space for matrices
nresp  = size(G,1) / nlines;
nref   = size(G,2);
padex  =  ceil(log(nlines)/log(2));
npad   = 2 * (2^padex - nlines ) + 1;
nlines_out = 2^(padex+1);
fs_out  = fs/((nlines-1) * 2) * nlines_out;
delta_t = 1/fs_out;
GBlk  = zeros(size(G));
Y = zeros(nresp*(nlines*2),nref);
err = 0;

% Convert G to Block form with Full Spectrum
fprintf(1,'Putting FRF in Block Form...');
for j = 1:nref,
  for i = 1:nresp,
    Gij =  G(((i-1)*nlines + 1):(i*nlines),j);
    GBlk(  i:nresp:(nlines_out-1)*nresp+i , j ) = [Gij;zeros(npad,1);conj(Gij((nlines-1):-1:1))];
  end
end
fprintf(1,' Done.\n');

% Convert GBlk to Block-Form Impulse Response 'Y'
fprintf(1,'Converting FRF to Impulse Response...');
for j = 1:nref,
  for i = 1:nresp,
    Y(i:nresp:(nlines_out-1)*nresp+i,j) = real(ifft(GBlk(i:nresp:(nlines_out-1)*nresp+i,j)));
  end
end
fprintf(1,' Done.\n');

% Compute Y master input/output pair
Y_master = Y(master_resp:nresp:(nlines_out-1)*nresp+master_resp,master_ref);

% Form Impulse Response Matrix(0 to m) * {Coefficients}={Impulse Response(m+1)}
fprintf(1,'Master Input/Output Pair Calculation ...\n');
fprintf(1,'Forming time step matrices T and S with order = %d...',m);
T = zeros(m,m);
S = zeros(m,1);
for k = 1:m
  for n = 1:m
    T(k,n) = Y_master(1+(k-1)+(n-1),1);
  end
  S(k) = Y_master(k+m,1);
end
fprintf(1,' Done.\n');

% Solve for coefficients, alpha[0] to alpha[m]
fprintf(1,'Solving for polynomial coefficients Alpha(i) ...');
Alpha = T \(-S);
fprintf(1,' Done.\n');

% Form companion matrix
fprintf(1,'Forming companion matrix ...');
C = diag(ones(m-1,1),-1);
C(1,:) = (-Alpha(m:-1:1))';
fprintf(1,' Done.\n');
 
% Solve for continuous system eigenvalues
fprintf(1,'Solving for continuous system eigenvalues ...');
Z = eig(C);
% Remove any zero real poles so log(Z) does not complain 
this_size = length(Z);
for n = 1:this_size
  if (real(Z(n)) == 0.0)
    reduce = [1:(n-1),(n+1):this_size];
    Z = Z(reduce,1);
  end
end
this_lambda = log(Z)/delta_t;
fprintf(1,' Done.\n');
    
% Reduce continuous time system
% Sort lambda in ascending order
[this_lambda,isort] = sort(this_lambda);

% Remove real poles and order conjugate pairs
n = 1;
this_size = length(this_lambda);
while n < this_size
  if (isreal(this_lambda(n)))
    % This is a real pole, remove it
    reduce = [1:(n-1),(n+1):this_size];
    this_lambda = this_lambda(reduce,1);
  elseif (imag(this_lambda(n)) < 0)
    % The pole with the negative imaginary part is first, switch them
    reduce = [1:(n-1),(n+1),n,(n+2):this_size];
    this_lambda=this_lambda(reduce,1);
    n = n + 2;
  else  
    % The pole pair is OK as is
    n = n + 2;
  end
  this_size = length(this_lambda);
end

% Check the last pole  
while( (isreal(this_lambda(this_size))) | ((this_lambda(this_size)) ~= conj(this_lambda(this_size-1))))
  if (isreal(this_lambda(this_size)))
    % This is a real pole, remove it
    reduce = [1:(this_size-1)];
    this_lambda = this_lambda(reduce,1);
  elseif ((this_lambda(this_size)) ~= conj(this_lambda(this_size-1)))
    % This is not a conjugate of the previous, remove it
    reduce = [1:(this_size-1)];
    this_lambda = this_lambda(reduce,1);
  end
  this_size = length(this_lambda);
end

% Remove unstable poles, poles where continuous system real part > 0
this_size = length(this_lambda);
n = 1;
while n <= this_size
  if (real(this_lambda(n)) > 0)
    % This pole is unstable, remove it
    reduce = [1:(n-1),(n+1):this_size];
    this_lambda = this_lambda(reduce,1);
    this_size = length(this_lambda);
  else  
    % The pole is OK
    n = n + 1;
  end
end

% Remove poles outside frequency range of interest (fmin,fmax)
this_size = length(this_lambda);
n = 1;
while n <= this_size
  if ( (abs(this_lambda(n)/(2*pi))<fmin) | ((abs(this_lambda(n))/(2*pi))>fmax))
    % This pole is outside frequency range, remove it
    reduce = [1:(n-1),(n+1):this_size];
    this_lambda = this_lambda(reduce,1);
    this_size = length(this_lambda);
  else  
    % The pole is OK
    n = n + 1;
  end
end

% Calculate the frequencies in Hertz and the damping
if (this_size > 2)
  freq_compexp = abs(this_lambda(1:2:this_size)/(2*pi));
  zeta_compexp = abs(real(this_lambda(1:2:this_size))./imag(this_lambda(1:2:this_size)));
else
  fprintf(1,'\n\nNo meaningful poles were found within range %4.2f to %4.2f\n\n',fmin,fmax);
  err = 1;
  freq_compexp = [];
  zeta_compexp = [];
end

fprintf(1, 'Finished Complex Exponential Modal Fit.\n');

return








