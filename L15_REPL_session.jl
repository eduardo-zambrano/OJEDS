# Source: https://web.stanford.edu/~boyd/vmls/vmls-julia-companion.pdf
#]
#activate .
#<BACKSPACE>
include("REPL_helper.jl")
using OhMyREPL
using LinearAlgebra, VMLS, Plots, Statistics

D = house_sales_data()
price = D["price"];
N = length(price)
area = D["area"];
beds = D["beds"];

X = [ones(N) area beds]
β = X \ price

brando = ones(N) \ price
mean(price)

# Find the part of area that is orthogonal to beds
area_hat = [ones(N) beds] * ([ones(N) beds] \ area);
([ones(N) beds] \ area)
# This is the part of area that is orthogonal to beds:
area_resid = area - area_hat

# Check the orthogonality
area_resid'*area_hat

# Run price on area_resid and the constant term
β_new = [ones(N) area_resid] \ price

#Compare to β
β

# The eight features model
condo = D["condo"];
location = D["location"];
X_large = hcat(ones(N), area, max.(area.-1.5, 0), beds, condo, location .== 2, location .== 3, location .== 4 );

θ = X_large \ price

scatter(price, X_large*θ , lims = (0,800));
plot!([0, 800], [0, 800], linestyle = :dash);
plot!(xlims = (0,800), ylims = (0,800), size = (500,500));
plot!(xlabel = "Actual price", ylabel = "Predicted price (more complex model")

save_REPL_history("L15_REPL_session.jl")