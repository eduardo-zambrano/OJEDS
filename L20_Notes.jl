## Adapted from https://github.com/chkwon/jpor_codes/blob/master/chap2/LP1.jl ##
## See also https://web.stanford.edu/class/archive/ee/ee392m/ee392m.1056/Lecture12_Optimization.pdf (pages 11-15)
include("REPL_helper.jl");
using JuMP, GLPK, VMLS, LinearAlgebra
using OhMyREPL

# Data
c = [9, 12.5, 12.5, 27.5, 27.5, 37.5, 28.5]
A₁ = [eye(5) eye(5) eye(5)]
A₂ = [ones(5) zeros(5);zeros(5) ones(5)]'
A₃ = [70 80 85 90 99 0 0 0 0 0 ;0 0 0 0 0  70 80 85 90 99]
b₁ = [2000, 4000, 4000, 5000, 3000]
b₂ = [93, 85]
Diagonal(b₂)

# Preparing the optimization model
m = Model(GLPK.Optimizer)

# Declaring variables
@variable(m, SA[1:5] ≥ 0)
@variable(m, SB[1:5] ≥ 0)
@variable(m, US[1:5] ≥ 0)
@variable(m, FA ≥ 0)
@variable(m, FB ≥ 0)

# Setting the objective
@objective(m, Max, c'*[US;FA;FB])

# Adding constraints
@constraint(m, stock_availability, A₁ * [SA;SB;US].== b₁)
@constraint(m, fuel_quantity, A₂ * [SA;SB]  .== [FA;FB])
@constraint(m, fuel_quality, A₃ * [SA;SB] .≥ Diagonal(b₂)*[FA;FB])

# Printing the prepared optimization model
print(m)

# Solving the optimization problem
JuMP.optimize!(m)

# Printing the optimal solutions obtained
println("Objective Value:")
objective_value(m)
println("Optimal Solutions:")
println("FA = ", JuMP.value(FA))
println("FB = ", JuMP.value(FB))
[JuMP.value(SA[i]) for i in 1:5]
[JuMP.value(SB[i]) for i in 1:5]
[JuMP.value(US[i]) for i in 1:5]

# Remember to 
# 1. save the REPL session.
save_REPL_history("L16_REPL_session.jl")
# 2. GIT commit and GIT push at the end of class.

