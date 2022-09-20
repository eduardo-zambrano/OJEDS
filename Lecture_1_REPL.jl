activate .
include("REPL_helper.jl")
using Plots
n = 100
f(x) = x^2
ϵ = randn(n)
plot(f.(ϵ),label="ϵ²")
plot!(ϵ,label="ϵ")
include("first_LP.jl")
save_REPL_history("Lecture_1_REPL.jl")