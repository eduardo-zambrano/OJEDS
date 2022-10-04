include("REPL_helper.jl")
using OhMyREPL

# Source: https://web.stanford.edu/~boyd/vmls/vmls-julia-companion.pdf

x = [-1.1, 0.0, 3.6, -7.2]
length(x)

a = [ 1 2 ]
b = ( 1, 2)

z = [1.3]
w = 1.3
z == w

x = [1, -2]; y = [1,1,0];
z = [x;y]
z = [x, y]
z(x,y)
z = (x,y)

zeros(3)
ones(9)

[0, 7,9] + [1,2,0]
ans
x = [0,2,-1]
2x
# 2 x this would not work
2*x
2 * x # this works
y = [1,2,0]
2x+5y

# [1.1, -3.7, 0.3] - 1.4  this would not work
[1.1, -3.7, 0.3] .- 1.4

p_initial = [ 22.15, 89.32, 56.77 ];
p_final = [ 23.05, 87.32, 57.12 ];
r = (p_final - p_initial) ./ p_initial

x = [-1,2,2];
y = [1,0,-3];
x'y

using LinearAlgebra

x = [2, -1, 2]
norm(x)
sqrt(x'*x)

x = randn(10)
y = randn(10)
RHS = norm(x+y)
LHS = norm(x) + norm(y)

u = [1.8, 2.0, -3.7, 4.7]
v = [0.6, 2.1, 1.9, -1.4]
w = [2.0, 1.9, -4.0, 4.6]

norm(u-v)
norm(u-w)
norm(v-w)

peanutcos(x,y) = x'*y/(norm(x)*norm(y))
peanutcos(x,y)
save_REPL_history("L5_REPL_session.jl")