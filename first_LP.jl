## Adapted from https://github.com/chkwon/jpor_codes/blob/master/chap2/LP1.jl ##
## See also https://www.globaltechcouncil.org/data-science/a-quick-guide-to-linear-programming-for-data-science/


using JuMP, GLPK

# Preparing the optimization model
m = Model(GLPK.Optimizer)

# Declaring variables
@variable(m, x≥0)
@variable(m, y≥0)

# Setting the objective
@objective(m, Max, 50x + 120y)

# Adding constraints
@constraint(m, budget_constraint, 100x + 200y ≤ 10000)
@constraint(m, workers_constraint,  10x + 30y ≤ 1200)
@constraint(m, land_constraint,  x + y ≤ 110)

# Printing the prepared optimization model
print(m)

# Solving the optimization problem
JuMP.optimize!(m)

# Printing the optimal solutions obtained
println("Optimal Solutions:")
println("Area for growing wheat = ", JuMP.value(x))
println("Area for growing barley = ", JuMP.value(y))

# Printing the shadow prices
println("Shadow prices:")
println("Shadow price of 'budget' = ", JuMP.shadow_price(budget_constraint))
println("Shadow price of 'worker' = ", JuMP.shadow_price(workers_constraint))
println("Shadow price of 'land' = ", JuMP.shadow_price(land_constraint))
