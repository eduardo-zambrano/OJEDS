# Source: https://web.stanford.edu/~boyd/vmls/vmls-julia-companion.pdf

include("REPL_helper.jl");
using OhMyREPL
using VMLS
using LinearAlgebra

#   Chapter 6
#   ===========
# 
#   Matrices
#   ≡≡≡≡≡≡≡≡≡≡
# 
#   6.1 Matrices
#   ––––––––––––––

A = [0.0 1.0 -2.3 0.1;
    1.3 4.0 -0.1 0.0;
    4.1 -1.0 0.0 1.7]

A = [0 1 -2.3 0.1; 1.3 4 -0.1 0; 4.1 -1 0 1.7]

#   The Julia function size(A) gives the size, as a tuple. 
size(A)
# 
#   Indexing entries. We get the i, j entry of a matrix A using A[i,j]. We can
#   also assign a new value to an entry.

A[2,3] # Get 2,3 entry of A

A[1,3] = 7.5; # Set 1,3 entry of A to 7.5
A

#   Single index indexing. Julia allows you to access an entry of a matrix using
#   only one index. To use this, you need to know that matrices in Julia are
#   stored in column-major order. This means that a matrix can be considered as
#   a one - dimensional array, with the first column stacked on top of the
#   second, stacked on top of the third, and so on. For example, 

Z = [ -1 0 2; -1 2 -3];
Z[5]

#   This is very much not standard mathematical notation, but it can be handy in some cases when you are using Julia.

#   Row and column vectors. In Julia, as in VMLS, n-vectors are the same as n ×
#   1 matrices.

a = [ -2.1 -3 0 ] # A 3-row vector or 1x3 matrix

b = [ -2.1; -3; 0 ] # A 3-vector or 3x1 matrix

#   Slicing and submatrices. Using colon notation you can extract a submatrix.

A = [ -1 0 1 0 ; 2 -3 0 1 ; 0 4 -2 1]

A[1:2,3:4]

#   This is very similar to the mathematical notation in VMLS.

A[:,3] # Third column of A

A[2,:] # Second row of A, returned as column vector!

#   In mathematical (VMLS) notation, we say that A[2,:] returns the transpose of
#   the second row of A. 

#   Julia’s single indexing for matrices can be used with index ranges or sets.
#   For example if X is an m × n matrix, X[:] is a vector of size mn that
#   consists of the columns of X stacked on top of each other. The Julia
#   function reshape(X,(k,l)) gives a new k × l matrix, with the entries taken
#   in the column-major order from X. (We must have mn = kl, i.e., the original
#   and reshaped matrix must have the same number of entries.) Neither of these
#   is standard mathematical notation, but they can be useful in Julia.

B = [ 1 -3 ; 2 0 ; 1 -2]

B[:]

reshape(B,(2,3))

reshape(B,(3,3))

#   Block matrices. Block matrices are constructed in Julia very much as in the
#   standard mathematical notation in VMLS. You use ; to stack matrices, and a
#   space to do (horizontal) concatenation. Apply this to the example on page
#   109 (https://web.stanford.edu/~boyd/vmls/vmls.pdf#equation.6.1.1) of VMLS.

B = [ 0 2 3 ]; # 1x3 matrix

C = [ -1 ]; # 1x1 matrix

D = [ 2 2 1 ; 1 3 5]; # 2x3 matrix

E = [4 ; 4 ]; # 2x1 matrix

# construct 3x4 block matrix

A = [B C ; 
    D E]

#   Column and row interpretation of a matrix. An m × n matrix A can be
#   interpreted as a collection of n m-vectors (its columns) or a collection of
#   m row vectors (its rows). Julia distinguishes between a matrix (a
#   two-dimensional array) and an array of vectors. An array (or a tuple) of
#   column vectors can be converted into a matrix using the horizontal
#   concatenation function hcat.

a = [ [1., 2.], [4., 5.], [7., 8.] ] # array of 2-vectors

A = hcat(a...)

#   The ... operator in hcat(a...) splits the array a into its elements, i.e.,
#   hcat(a...) is the same as hcat(a[1], a[2], a[3]), which concatenates a[1],
#   a[2], a[3] horizontally. Similarly, vcat concatenates an array of arrays
#   vertically. This is useful when constructing a matrix from its row vectors.

a = [ [1. 2.], [4. 5.], [7. 8.] ] # array of 1x2 matrices

A = vcat(a...)

#   6.2 Zero and identity matrices
#   ––––––––––––––––––––––––––––––––
# 
#   Zero matrices. A zero matrix of size m× n is created using zeros(m,n).

zeros(2,2)

#   Identity matrices. Identity matrices in Julia can be created many ways, for
#   example by starting with a zero matrix and then setting the diagonal entries
#   to one.
# 
#   The LinearAlgebra package also contains functions for creating a special
#   identity matrix object I, which has some nice features. You can use
#   1.0*Matrix(I,n,n) to create an n× n identity matrix. (Multiplying by 1.0
#   converts the matrix into one with numerical entries; otherwise it has
#   Boolean entries.) This expression is pretty unwieldy, so we can define a
#   function eye(n) to generate an identity matrix. This function is in the VMLS
#   package, so you can use it once the package is installed. (The name eye to
#   denote the identity matrix I traces back to the MATLAB language.)

eye(n) = 1.0*Matrix(I,n,n)
eye(4)

#   Julia’s identity matrix I has some useful properties. For example, when it
#   can deduce its dimensions, you don’t have to specify it. (This is the same
#   as with common mathematical notation; see VMLS page 113
#   (https://web.stanford.edu/~boyd/vmls/vmls.pdf#section*.135).)

A = [ 1 -1 2; 0 3 -1]

[A I]

[A ; I]

B = [ 1 2 ; 3 4 ]

B + I

#   Ones matrix. In VMLS we do not have notation for a matrix with all entries
#   one. In Julia, such a matrix is given by ones(m,n).
# 
#   Diagonal matrices. In standard mathematical notation, diag(1, 2, 3) is a
#   diagonal 3 × 3 matrix with diagonal entries 1, 2, 3. In Julia such a matrix
#   is created using the function diagm, provided in the LinearAlgebra package.
#   To construct the diagonal matrix with diagonal entries in the vector s, you
#   use diagm(0 => s). This is fairly unwieldy, so the VMLS package defines a
#   function diagonal(s). (Note that you have to pass the diagonal entries as a
#   vector.)

 diagonal(x) = diagm(0 => x)

diagonal([1,2,3])

#   A closely related Julia function diag(X) does the opposite: It takes the
#   diagonal entries of the (possibly not square) matrix X and puts them into a
#   vector.

H = [0 1 -2 1; 2 -1 3 0]

diag(H)

#   Random matrices. A random m×n matrix with entries between 0 and 1 is created
#   using rand(m,n). For entries that have a normal distribution, randn(m,n).

rand(2,3)

randn(3,2)

#   Sparse matrices. Functions for creating and manipulating sparse matrices are
#   contained in the SparseArrays.

using SparseArrays

M = [ 1, 2, 2, 1, 3, 4 ] # row indexes of nonzeros
N = [ 1, 1, 2, 3, 3, 4 ] # column indexes
V = [ -1.11, 0.15, -0.10, 1.17, -0.30, 0.13 ] # values
A = sparse(M, N, V, 4, 5)

nnz(A)

#   Sparse matrices can be converted to regular non-sparse matrices using the
#   Array function. Applying sparse to a full matrix gives the equivalent sparse
#   matrix.

A = sparse([1, 3, 2, 1], [1, 1, 2, 3],
    [1.0, 2.0, 3.0, 4.0], 3, 3)

B = Array(A)

B[1,3] = 0.0;
sparse(B)

#   A sparse m × n zero matrix is created with spzeros(m,n). To create a sparse
#   n × n identity matrix in Julia, use sparse(1.0I,n,n). This is not a
#   particularly natural syntax, so we define a function speye(n) in the VMLS
#   package. The VMLS package also includes the function speye(n) which creates
#   a sparse n × n identity matrix, as well as spdiagonal(a), which creates a
#   sparse diagonal matrix with the entries of the vector a on its diagonal.
# 
#   A useful function for creating a random sparse matrix is sprand(m,n,d) (with
#   entries between 0 and 1) and sprandn(m,n,d) (with entries that range over
#   all numbers). The first two arguments give the dimensions of the matrix; the
#   last one, d, gives the density of nonzero entries. The nonzero entries are
#   chosen randomly, with about mnd of them nonzero. The following code creates
#   a random 10000 × 10000 sparse matrix, with a density 10^{−7}. This means
#   that we’d expect there to be around 10 nonzero entries. (So this is a very
#   sparse matrix!)

A = sprand(10000,10000,10^-7)

#   6.3 Transpose, addition, and norm
#   –––––––––––––––––––––––––––––––––––
# 
#   Transpose. In VMLS we denote the transpose of an m × n matrix A as A^T . In
#   Julia, the transpose of A is given by A'.

H = [0 1 -2 1; 2 -1 3 0]

H'

#   Addition, subtraction, and scalar multiplication. In Julia, addition and
#   subtraction of matrices, and scalar-matrix multiplication, both follow
#   standard mathematical notation.

U = [ 0 4; 7 0; 3 1]

V = [ 1 2; 2 3; 0 4]

U+V

2.2*U

#   (We can also multiply a matrix on the right by a scalar.)

# 
#   Matrix norm. 

A = [2 3 -1; 0 -1 4]
norm(A),norm(A[:])

#   Triangle inequality. Let’s check that the triangle inequality ‖A+B‖ ≤
#   ‖A‖+‖B‖ holds, for two specific matrices.

A = [-1 0; 2 2]; B= [3 1; -3 2];
norm(A + B), norm(A) + norm(B)

#   6.4 Matrix-vector multiplication
#   ––––––––––––––––––––––––––––––––––
# 
#   In Julia, matrix-vector multiplication has the natural syntax y=A*x.

A = [0 2 -1; -2 1 1]
x = [2, 1, -1]
A*x


#   Chapter 10
#   ============
# 
#   Matrix multiplication
#   ≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡
# 
#   10.1 Matrix-matrix multiplication
#   –––––––––––––––––––––––––––––––––––
# 
#   In Julia the product of matrices A and B is obtained with A*B.
A = [-1.5 3 2; 1 -1 0]

B = [-1 -1; 0 -2; 1 0]

C = A*B

#   Gram matrix.

 A = randn(10,3);
 G = A'*A

# Gii is norm of column i, squared
G[2,2]

norm(A[:,2])^2

# Gij is inner product of columns i and j
G[1,3],A[:,1]'*A[:,3]


#   10.4 QR factorization
#   –––––––––––––––––––––––
# 
#   In Julia, the QR factorization of a matrix A can be found using qr(A), which
#   returns a tuple with the Q and R factors. However the matrix Q is not
#   returned as an array, but in a special compact format. It can be converted
#   to a regular matrix variable using the command Matrix(Q). Hence, the QR
#   factorization as defined in VMLS is computed by a sequence of two commands:

#   Q,R = qr(A)
#   Q = Matrix(Q)

#   The following example also illustates a second, but minor difference with
#   the VMLS definition. The R factor computed by Julia may have negative
#   elements on the diagonal, as opposed to only positive elements if we follow
#   the definition used in VMLS. The two definitions are equivalent, because if
#   R_{ii} is negative, one can change the sign of the ith row of R and the ith
#   column of Q, to get an equivalent factorization with R_{ii} > 0. However
#   this step is not needed in practice, since negative elements on the diagonal
#   do not pose any problem in applications of the QR factorization.

A = randn(6,4);
Q, R = qr(A);
R

Q = Matrix(Q)

norm(Q*R-A)

Q'*Q

# Remember to 
# 1. save the REPL session.

save_REPL_history("L8_REPL_session.jl")

# 2. GIT commit and GIT push at the end of class.