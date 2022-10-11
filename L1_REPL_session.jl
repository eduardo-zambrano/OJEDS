# Run Julia from your OJEDS directory
#]
#activate . (don't forget the space and the period)
#<BACKSPACE>

include("REPL_helper.jl")

#Source: https://julia.quantecon.org/getting_started_julia/julia_by_example.html

using Plots
n = 100
f(x) = x^2
ϵ = randn(n)
plot(f.(ϵ),label="ϵ²")
plot!(ϵ,label="ϵ")


# Adapted from https://github.com/chkwon/jpor_codes/blob/master/chap2/LP1.jl 
# See also https://www.globaltechcouncil.org/data-science/a-quick-guide-to-linear-programming-for-data-science/

include("first_LP.jl")

# The line below saves everything you typed into the REPL inside your current Julia session
save_REPL_history("Insert_filename_here.jl")