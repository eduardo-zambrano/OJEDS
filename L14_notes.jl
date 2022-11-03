# Source: https://web.stanford.edu/~boyd/vmls/vmls-julia-companion.pdf
include("REPL_helper.jl");
using OhMyREPL
using VMLS, LinearAlgebra, Plots

# Housing Prices - two features plus the constant term
D = house_sales_data();
area = D["area"];
beds = D["beds"];
price = D["price"];
N = length(price);
X = [ ones(N) area beds ];
β = X \ price

scatter(price, X*β, lims = (0,800));
plot!([0, 800], [0, 800], linestyle = :dash);
# make axes equal and add labels
plot!(xlims = (0,800), ylims = (0,800), size = (500,500));
plot!(xlabel = "Actual price", ylabel = "Predicted price (simple model)")

# Housing Prices - seven features plus the constant term
condo = D["condo"];
location = D["location"];
# N = length(price);
X_large = hcat(ones(N), area, max.(area.-1.5, 0), beds, condo, location .== 2, location .== 3, location .== 4 );
θ = X_large \ price

# rms(X*θ - price) # RMS prediction error

scatter(price, X_large*θ , lims = (0,800));
plot!([0, 800], [0, 800], linestyle = :dash);
plot!(xlims = (0,800), ylims = (0,800), size = (500,500));
plot!(xlabel = "Actual price", ylabel = "Predicted price (more complex model")