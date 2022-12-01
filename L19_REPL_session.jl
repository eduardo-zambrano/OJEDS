#]
#activate .
#<BACKSPACE>
include("REPL_helper.jl")
using OhMyREPL
using JuMP, GLPK

m = Model(GLPK.Optimizer)

@variable(m,x₁ ≥ 0)
@variable(m, x₂ ≥ 0)

@objective(m, Max, 20x₁ + 30x₂)

@constraint(m, flour_constraint, 3x₁ + 6x₂ ≤ 150)
@constraint(m, sugar_constraint, x₁ + 0.5x₂ ≤ 22)
@constraint(m, butter_constraint, x₁ + x₂ ≤ 27.5)

print(m)

JuMP.optimize!(m)

println("x₁ = ", JuMP.value(x₁))
println("x₂ = ", JuMP.value(x₂))

JuMP.shadow_price(flour_constraint)
JuMP.shadow_price(sugar_constraint)
JuMP.shadow_price(butter_constraint)

save_REPL_history("L19_REPL_session.jl")