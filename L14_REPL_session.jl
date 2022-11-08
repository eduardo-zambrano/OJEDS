include("REPL_helper.jl");
using OhMyREPL, LinearAlgebra


#   12.3 Solving least squares problems
#   –––––––––––––––––––––––––––––––––––––
# 
#   Julia uses the backslash operator to denote the least squares approximate
#   solution: xhat = A\b. (The same operator is used to solve square systems of
#   linear equations, and we will see more uses of it in later chapters.)

A = randn(100,20); b = randn(100);
x1 = A\b; # Least squares using backslash operator
x2 = inv(A'*A)*(A'*b); # Using formula
x3 = pinv(A)*b; # Using pseudo-inverse
Q, R = qr(A);
Q = Matrix(Q);
x4 = R\(Q'*b); # Using QR factorization
norm(x1-x2),norm(x2-x3),norm(x3-x4)

#   12.4 Examples
#   –––––––––––––––
# 
#   Advertising purchases. We work out the solution of the optimal advertising
#   purchase problem on page 234
#   (https://web.stanford.edu/~boyd/vmls/vmls.pdf#section*.284) of VMLS.

R = [ 0.97 1.86 0.41;
1.23 2.18 0.53;
0.80 1.24 0.62;
1.29 0.98 0.51;
1.10 1.23 0.69;
0.67 0.34 0.54;
0.87 0.26 0.62;
1.10 0.16 0.48;
1.92 0.22 0.71;
1.29 0.12 0.62];
m, n = size(R);
vdes = 1e3 * ones(m);
s = R \ vdes

sum(s)

rms(R*s - vdes)

# Remember to 
# 1. save the REPL session.

save_REPL_history("L14_REPL_session.jl")

# 2. GIT commit and GIT push at the end of class.