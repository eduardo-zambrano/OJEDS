""" 
Source:
https://julia.quantecon.org/getting_started_julia/julia_by_example.html
"""
using Plots

n = 100
f(x) = x^2
ϵ = randn(n)
plot(f.(ϵ), label="ϵ²")
plot!(ϵ, label="ϵ")