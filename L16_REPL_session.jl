# Source: https://web.stanford.edu/~boyd/vmls/vmls-julia-companion.pdf
#]
#activate .
#<BACKSPACE>
include("REPL_helper.jl")
using OhMyREPL
using VMLS, LinearAlgebra

R = [0.97 1.86 0.41;
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

x_unc = R \ vdes

Cost_of_unconstrained_solution = sum(x_unc)
Reduced_Budget = .8 * Cost_of_unconstrained_solution

S = [1 0 ; 0 1 ; -1 -1 ]
s = [0 ; 0 ; Reduced_Budget]

A_R = R*S
vdes_R = vdes - R*s

x_R_hat = A_R \ vdes_R

x = S*x_R_hat + s

save_REPL_history("L16_REPL_session.jl")