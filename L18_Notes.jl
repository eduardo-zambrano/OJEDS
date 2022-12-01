## Adapted from https://github.com/chkwon/jpor_codes/blob/master/chap2/LP1.jl ##
## See also Chapter 19 in https://www.pearson.com/store/p/essential-mathematics-for-economic-analysis/P200000005528/9781292359328

include("REPL_helper.jl");
using JuMP, GLPK
using OhMyREPL

# Preparing the optimization model
m = Model(GLPK.Optimizer)

# Declaring variables
@variable(m, x₁ ≥ 0)
@variable(m, x₂ ≥ 0)

# Setting the objective
@objective(m, Max, 20x₁ + 30x₂)

# Adding constraints
@constraint(m, flour_constraint, 3x₁ + 6x₂ ≤ 150)
@constraint(m, sugar_constraint,  x₁ + 0.5x₂ ≤ 22)
@constraint(m, butter_constraint,  x₁ + x₂ ≤ 27.5)

# Printing the prepared optimization model
print(m)

# Solving the optimization problem
JuMP.optimize!(m)

# Printing the optimal solutions obtained
println("Optimal Solutions:")
println("x₁ = ", JuMP.value(x₁))
println("x₂ = ", JuMP.value(x₂))

# Printing the shadow prices
println("Shadow prices:")
println("Shadow price of flour = ", JuMP.shadow_price(flour_constraint))
println("Shadow price of sugar = ", JuMP.shadow_price(sugar_constraint))
println("Shadow price of butter = ", JuMP.shadow_price(butter_constraint))

# Remember to 
# 1. save the REPL session.
save_REPL_history("L16_REPL_session.jl")
# 2. GIT commit and GIT push at the end of class.

