#]
#activate .
#<BACKSPACE>
# Source: https://web.stanford.edu/~boyd/vmls/vmls-julia-companion.pdf

include("REPL_helper.jl");
using OhMyREPL, LinearAlgebra

A = rand(6,4)

Q,R = qr(A)
Q = matrix(Q)

A = rand(3,3);
inv(A)

Q,R = qr(A);
Q
Q = Matrix(Q)
inv(R)*Q'

function back_subst(R,b)
n = length(b)
x = zeros(n)
for i=n:-1:1
x[i] = (b[i] - R[i,i+1:n]'*x[i+1:n]) / R[i,i]
end
return x
end

R = triu(randn(4,4))
b = rand(4)
x1 = back_subst(R,b)

x2 = R \ b

x3 = R^-1 * b

n = 5000;
A = randn(n,n); b = randn(n); # random set of equations
@time x1 = A\b;
@time x2 = inv(A)*b;

save_REPL_history("L10_REPL_session.jl")