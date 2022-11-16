# Source: https://web.stanford.edu/~boyd/vmls/vmls-julia-companion.pdf
# Also: https://www.cambridge.org/core/elements/machine-learning-for-asset-managers/6D9211305EA2E425D33A9F38D0AE3545, sec 7.6
# Refer to this resource as MLDP below.
# With thanks to Joe Schneider for helping develop the Nested Clustered Optimization example

include("REPL_helper.jl");
using OhMyREPL
using VMLS, LinearAlgebra, Plots, Statistics

#   Chapter 17
#   ============
# 
#   Constrained least squares applications
#   ≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡
# 
#   17.1 Portfolio optimization
#   –––––––––––––––––––––––––––––

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
T, n = size(R)
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

# Problem: Markowitz's curse

"""
Solution: Nested Clustered Optimization
"""

"""
# # Step 1: cluster the assets in terms of the similarity of their 'correlation distance vectors' (MLDP, page 54) using your favorite
# # clustering algorithm. Here, I used k-means clustering, as in Chapter 4 of our textbook, with k=5.
"""

k = 5;

# # Prepare the data for clustering
# D = sqrt.(0.5* (ones(size(n)) .- cor(R)))
# x = [D[:,i] for i in 1:n]

# # k-means from scratch (Chapter 4, section 4.3)
# function kmeans_(x, k; maxiters = 100, tol = 1e-5)
#     #Overriding the "error in method definition: function VMLS.kmeans must be explicitly imported to be extended"
#     #By writing kmeans_ instead of kmeans to display this implementation
#     N = length(x)
#     n = length(x[1])
#     distances = zeros(N) # used to store the distance of each
#     # point to the nearest representative.
#     reps = [zeros(n) for j=1:k] # used to store representatives.
        
#      # ’assignment’ is an array of N integers between 1 and k. The initial assignment is chosen randomly.
#     assignment = [ rand(1:k) for i in 1:N ]
    
#     Jprevious = Inf # used in stopping condition
#     for iter = 1:maxiters
    
#         # Cluster j representative is average of points in cluster j.
#         for j = 1:k
#             group = [i for i=1:N if assignment[i] == j]
#                         reps[j] = sum(x[group]) / length(group);
#                         end;
    
#                     # For each x[i], find distance to the nearest representative
#                     # and its group index.
#                     for i = 1:N
#                         (distances[i], assignment[i]) =
#                         findmin([norm(x[i] - reps[j]) for j = 1:k])
#                         end;
    
#                     # Compute clustering objective.
#                     J = norm(distances)^2 / N
    
#                     # Show progress and terminate if J stopped decreasing.
#                     println("Iteration ", iter, ": Jclust = ", J, ".")
#                     if iter > 1 && abs(J - Jprevious) < tol * J
#                         return assignment, reps
#                         end
#                     Jprevious = J
#                     end
    
#                     end


# kmeans_(x, k; maxiters = 100, tol = 1e-5)

# The algorithm produces an assignment of each column of x to a cluster
D = [3, 5, 3, 3, 3, 3, 3, 1, 1, 3, 3, 3, 1, 5, 4, 3, 1, 3, 1, 2]

"""
# Step 2: perform portfolio optimization separately in each cluster
"""

# Create the five separate groups of assets
P = [ R[:,D .== i] for i in 1:k ];

# Optimize inside each cluster
wₚ = [ port_opt(P[i], ρ) for i in 1:k ];

# Track in-sample returns 
rₚ = [ P[i] * wₚ[i] for i in 1:k ];
Pᵣ = hcat(rₚ...);

"""
# Step 3: Create a portfolio of portfolios
"""
wₚₚ = port_opt(Pᵣ,ρ);
rₚₚ = Pᵣ * wₚₚ; # Portfolio return time series
pf_return = 250*mean(rₚₚ)

## Prepare to track out-of-sample returns 

# Split the test data into the same five clusters
Ptest = [ Rtest[:,D .== i] for i in 1:k ];

# Track the returns of the five cluster-optimal portfolios out of sample
rₚ_test = [ Ptest[i] * wₚ[i] for i in 1:k ];
Pᵣ_test = hcat(rₚ_test...);

# Track the returns of the portfolio of portfolios
rₚₚ_test = Pᵣ_test * wₚₚ 

# pf_return_test = 250 * mean(rₚₚ_test)

# Compare with the  out of sample performance of the original portfolio
plot(1:Ttest, cum_value(rtest), label= "Original", legend=:topleft)
plot!(1:Ttest, cum_value(rₚₚ_test), label= "NCO")

# Remember to 
# 1. save the REPL session.
save_REPL_history("L16_REPL_session.jl")
# 2. GIT commit and GIT push at the end of class.