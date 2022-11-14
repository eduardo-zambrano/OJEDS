# Source: https://web.stanford.edu/~boyd/vmls/vmls-julia-companion.pdf
include("REPL_helper.jl");
using OhMyREPL
using VMLS, LinearAlgebra, Plots

# Housing Prices 
D = house_sales_data();
area = D["area"];
beds = D["beds"];
condo = D["condo"];
location = D["location"];
price = D["price"];
N = size(price)
X_large = hcat(ones(N), area, max.(area.-1.5, 0), beds, condo, location .== 2, location .== 3, location .== 4 );

θ = X_large \ price

#   15.1 Multi-objective least squares
#   ––––––––––––––––––––––––––––––––––––
# 
#   Let’s write a function that solves the multi-objective least squares
#   problem, with given positive weights. The data are a list (or array) of
#   coefficient matrices (of possibly different heights) As, a matching list of
#   (right-hand side) vectors bs, and the weights, given as an array or list,
#   lambdas.

function mols_solve(As,bs,lambdas)
    k = length(lambdas);
    Atil = vcat([sqrt(lambdas[i])*As[i] for i=1:k]...)
    btil = vcat([sqrt(lambdas[i])*bs[i] for i=1:k]...)
    return Atil \ btil
end

N, p = size(X_large)
npts = 100;
lambdas = 10 .^ linspace(-6,6,npts);
thetas = zeros(p,npts);
for k = 1:npts    
    theta = mols_solve([ X_large, [zeros(p-1) eye(p-1)]],
        [ price, zeros(p-1) ], [1, lambdas[k]])
    thetas[:,k] = theta;
end;

# Plot coefficients
plot(lambdas, thetas', label = ["θ₁" "θ₂" "θ₃" "θ₄" "θ₅" "θ₆" "θ₇" "θ₈"], xscale = :log10)
plot!(xlabel = "lambda", xlim = (1e-6, 1e6))

# Remember to 
# 1. save the REPL session.
save_REPL_history("L16_REPL_session.jl")
# 2. GIT commit and GIT push at the end of class.
