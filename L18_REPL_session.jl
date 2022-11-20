#]
#activate .
#<BACKSPACE>
include("REPL_helper.jl")
using OhMyREPL, LinearAlgebra, VMLS, Plots, Statistics

# PART I: REVIEW
# Portfolio value with re-investment, return time series r
cum_value(r) = 10000 * cumprod(1 .+ r)
function port_opt(R,rho)
    T, n = size(R)
    if n == 1
        return [1.0]
    end
    mu = sum(R, dims=1)'/T
    KKT = [ 2*R'*R ones(n) mu; ones(n)' 0 0; mu' 0 0]
    wz1z2 = KKT \ [2*rho*T*mu; 1; rho]
    w = wz1z2[1:n]
    return w
end

R, Rtest = portfolio_data();

T, n = size(R);
Ttest, n = size(Rtest)

ρ = 0.10/250; # Ask for 10% annual return
w = port_opt(R,ρ);
r = R*w; # Portfolio return time series
pf_return = 250*mean(r) #Average annual return

# Plot the in-sample behavior of the porfolio
plot(1:T, cum_value(r), label= "the 10% portfolio", legend=:topleft)
# How do we do out of sample?
rtest = Rtest * w; # Portfolio return time series
pf_return_test = 250 * mean(rtest)

plot(1:Ttest, cum_value(ρ*ones(Ttest)), label= "'steady' 10%")
plot!(1:Ttest, cum_value(rtest), label= "the 10% portfolio underperforms out of sample!", legend=:topleft)

# PART II: Nested Clustered Optimization
# Number of clusters
k =5
# Cluster assignment for the 20 assets
D = [3, 5, 3, 3, 3, 3, 3, 1, 1, 3, 3, 3, 1, 5, 4, 3, 1, 3, 1, 2]
P = [ R[:,D .== i] for i in 1:k ];

# Look inside P
P[1]
P[2]
P[3]
P[4]
P[5]

wₚ = [ port_opt(P[i], ρ) for i in 1:k ];
wₚ # Look inside wₚ
rₚ = [ P[i] * wₚ[i] for i in 1:k ];
Pᵣ = hcat(rₚ...);
rₚ # Look inside rₚ
Pᵣ # Look iside Pᵣ

wₚₚ = port_opt(Pᵣ,ρ);

rₚₚ = Pᵣ * wₚₚ; # Portfolio return time series
pf_return = 250*mean(rₚₚ)
wₚₚ # Look inside wₚₚ

# Split the test data into the same five clusters
Ptest = [ Rtest[:,D .== i] for i in 1:k ];

# Track the returns of the five cluster-optimal portfolios out of sample
rₚ_test = [ Ptest[i] * wₚ[i] for i in 1:k ];
Pᵣ_test = hcat(rₚ_test...);
Pᵣ_test # Look inside Pᵣ_test

# Track the returns of the portfolio of portfolios
rₚₚ_test = Pᵣ_test * wₚₚ

plot(1:Ttest, cum_value(rtest), label= "Original", legend=:topleft)
plot!(1:Ttest, cum_value(rₚₚ_test), label= "NCO")

include("REPL_helper.jl")
save_REPL_history("L18_REPL_session.jl")