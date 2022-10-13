# Source: https://web.stanford.edu/~boyd/vmls/vmls-julia-companion.pdf

#]
#activate .
include("REPL_helper.jl")
using LinearAlgebra, SparseArrays

A = [ 1 6 ; 9 3]
B = [0 -1 ; -1 2]

A*B
B*A
A'
B'*A'
A'*B'
(A'*B')'

A[1] #Single index indexing

size(A)
A[1,2]
A[4]
A[3]

A = [0.0 1.0 -2.3 0.1;
1.3 4.0 -0.1 0.0;
4.1 -1.0 0.0 1.7]
A[2:3,2:3]
A[:,3]
A[2,:]

a = [ [1., 2.], [4., 5.], [7., 8.] ]

A = hcat(a...) # creating a matrix out of a list of vectors

zeros(4,4)
ones(4,5)
eye(n) = 1.0*Matrix(I,n,n)

eye(7)

rand(2,3)
randn(4,5)

# Create a sparse matrix
rowind = [ 1, 2, 2, 1, 3, 4];
colind = [1, 1, 2, 3, 3, 4];
values = [-1.11, 0.15, -0.1, 1.17, -0.3, 0.13];
A = sparse(rowind, colind, values, 4, 5)
nnz(A)

B = rand(4,5)

2*A
A + B
C = A .* B
norm(A)
save_REPL_history("L8_REPL.session.jl")