# Source: https://web.stanford.edu/~boyd/vmls/vmls-julia-companion.pdf

# ]
# activate .
include("REPL_helper.jl")
using OhMyREPL, LinearAlgebra

A = [-3 -4; 4 6; 1 1]
B = [-11 -10 16; 7 8 -11] / 9
C = [0 -1 6; 0 1 -4]/2

A
B
C

B*A
C*A

A = [1 -2 3; 0 2 2; -4 -4 -4]
B = inv(A)
B*A
A*B

marvin = triu(A)
marvin^-1
inv(marvin)

Marlon_Brando = rand(9,9)
triu(Marlon_Brando)
tril(Marlon_Brando)
b = rand(9)
A = Marlon_Brando

x = inv(A)*b
x = A \ b

save_REPL_history("L9_REPL_session.jl")