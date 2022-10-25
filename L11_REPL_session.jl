#]
#activate .
#<BACKSPACE>
include("REPL_helper.jl")
using OhMyREPL, LinearAlgebra

# Input - Output Table
I_O =[1131        25480        1        607        710        762;
7930        304584        64167        41082        11981        30360;
426            7334        3875        5296        23457        9155;
3559        72717        14190        74399        10835        21008;
3637        96115        31027        65755        193176        34223;
1552        14986        1747        11225        15058        22070]

# Vector of Final Demands
y = [15219
619296
196063
343355
268554
442280]

# Total Production by industry
using OhMyREPL
x = [sum(I_O[i,:]) + y[i] for i in 1:6]
A = hcat([I_O[:,i] / x[i] for i in 1:6])
A = hcat([I_O[:,i] / x[i] for i in 1:6]...)

# Leontief matrix
I - A

# Inverse
(I-A)^-1

# Recovering the economic activity vector
(I-A)^-1 * y

# Track the direct and indirect effect of specific changes in the vector of final demands 
sum((I-A)^-1 * [1,0,0,0,0,0])
sum((I-A)^-1 * [0,1,0,0,0,0])
sum((I-A)^-1 * [0,0,1,0,0,0])
sum((I-A)^-1 * [0,0,0,1,0,0])
sum((I-A)^-1 * [0,0,0,0,1,0])
sum((I-A)^-1 * [0,0,0,0,0,1])

save_REPL_history("L11_REPL_session.jl")