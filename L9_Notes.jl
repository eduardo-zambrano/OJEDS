# Source: https://web.stanford.edu/~boyd/vmls/vmls-julia-companion.pdf

include("REPL_helper.jl");
using VMLS, OhMyREPL
using LinearAlgebra

#   Chapter 11
#   ============
# 
#   Matrix inverses
#   ≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡
# 
#   11.1 Left and right inverses
#   ––––––––––––––––––––––––––––––
# 
#   We’ll see later how to find a left or right inverse, when one exists.

A = [-3 -4; 4 6; 1 1]
B = [-11 -10 16; 7 8 -11]/9 # A left inverse of A
C = [0 -1 6; 0 1 -4]/2 # Another left inverse of A;
A

B

C

# Let’s check
B*A

C*A

#   11.2 Inverse
#   ––––––––––––––
# 
#   If A is invertible, its inverse is given by inv(A) (and also A^-1). You’ll
#   get an error if A is not invertible, or not square.

A = [1 -2 3; 0 2 2; -4 -4 -4]
B = inv(A)
B*A

A*B

#   Inverse via QR factorization. The inverse of a matrix A can be computed from
#   its QR factorization A = QR.

A = randn(3,3);
inv(A)

Q, R = qr(A);
Q
Q = Matrix(Q);
Q
inv(R)*Q'

diff = inv(A) .- inv(R)*Q'
[abs(round(x)) for x in diff]

#   11.3 Solving linear equations
#   –––––––––––––––––––––––––––––––
# 
#   Back substitution. Let’s first implement back substitution (VMLS Algorithm
#   11.1 (https://web.stanford.edu/~boyd/vmls/vmls.pdf#algorithmctr.11.1)) in
#   Julia, and check it. You won’t need this function, since Julia has a better
#   implementation of it built in (via the backslash operation discussed below).
#   We give it here only to demonstrate that it works.

function back_subst(R,b)
n = length(b)
x = zeros(n)
for i=n:-1:1
x[i] = (b[i] - R[i,i+1:n]'*x[i+1:n]) / R[i,i]
end
return x
end

#   The function triu gives the upper triangular part of a matrix, i.e., it
#   zeros out the entries below the diagonal.
R = triu(randn(4,4)) # Random 4x4 upper triangular matrix

b = rand(4);
x = back_subst(R,b);
norm(R*x-b)

# 
#   Backslash notation. The Julia command for solving a set of linear equations
#   Ax = b is x=A\b. This is faster than x=inv(A)*b, which first computes the
#   inverse of A and then multiplies it with b.

n = 5000;
A = randn(n,n); b = randn(n); # random set of equations
@time x1 = A\b;
norm(b-A*x1)

@time x2 = inv(A)*b;
norm(b-A*x2)

#   11.5 Pseudo-inverse
#   –––––––––––––––––––––
# 
#   In Julia, the pseudo-inverse of a matrix A is obtained with pinv(A). We
#   compute the pseudo-inverse for the example on page 216
#   (https://web.stanford.edu/~boyd/vmls/vmls.pdf#section*.270) of VMLS using
#   the pinv function, and via the QR factorization of A.

A = [-3 -4; 4 6; 1 1]
pinv(A)

Q, R = qr(A);
Q = Matrix(Q)

R

R \ Q' # pseudo-inverse from QR factors

# Remember to 
# 1. save the REPL session.

save_REPL_history("L9_REPL_session.jl")

# 2. GIT commit and GIT push at the end of class.