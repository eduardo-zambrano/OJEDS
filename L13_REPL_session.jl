#]
#activate .
#<BACKSPACE>

using OhMyREPL, LinearAlgebra

# Input-Output Tables Review

I_O =[1131        25480        1        607        710        762;
7930        304584        64167        41082        11981        30360;
426            7334        3875        5296        23457        9155;
3559        72717        14190        74399        10835        21008;
3637        96115        31027        65755        193176        34223;
1552        14986        1747        11225        15058        22070];

y = [15219
619296
196063
343355
268554
442280];

x = [sum(I_O[i,:])+y[i] for i in 1:6];

# Input - Output Coefficients (page 485)
A = hcat([I_O[:,i] / x[i] for i in 1:6]...);
# Leontief matrix (page 487)
I - A;
A
(I-A)^-1

sum((I-A)^-1 * [1,0,0,0,0,0])

(I-A)^-1 * [1,0,0,0,0,0]

# Moving on to Least Squares

A = [ 2 0; -1 1; 0 2];
b = [1, 0 ,-1];
xhat = [1/3, -1/3]

rhat = A*xhat - b

norm(rhat)

xtilde = [1/2,-1/2]
rtilde = A*xtilde - b
norm(rtilde)

x = A \ b

save_REPL_history("L13_REPL_session.jl")