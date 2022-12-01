#]
#activate .
#<BACKSPACE>
include("REPL_helper.jl")
using OhMyREPL
using JuMP, GLPK, VMLS, LinearAlgebra

c = [9, 12.5, 12.5, 27.5, 27.5, 37.5, 28.5]
A₁ = [eye(5) eye(5) eye(5)]
A₂ = [ones(5) zeros(5);zeros(5) ones(5)]
A₂ = [ones(5) zeros(5);zeros(5) ones(5)]'
A₃ = [70 80 85 90 99 0 0 0 0 0 ;0 0 0 0 0  70 80 85 90 99]
b₁ = [2000, 4000, 4000, 5000, 3000]
b₂ = [93, 85]

m = Model(GLPK.Optimizer)

@variable(m, SA[1:5] ≥ 0)
@variable(m, SB[1:5] ≥ 0)
@variable(m, US[1:5] ≥ 0)
@variable(m, FA ≥ 0)
@variable(m, FB ≥ 0)

m

@objective(m, Max, c'*[US;FA;FB])
@constraint(m, stock_availability, A₁ * [SA;SB;US].== b₁)
@constraint(m, fuel_quantity, A₂ * [SA;SB]  .== [FA;FB])
@constraint(m, fuel_quality, A₃ * [SA;SB] .≥ Diagonal(b₂)*[FA;FB])

print(m)

JuMP.optimize!(m)

objective_value(m)
JuMP.value(FA)
JuMP.value(FB)

save_REPL_history("L20_REPL_session.jl")