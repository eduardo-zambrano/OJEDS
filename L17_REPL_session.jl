#]
#activate .
#<BACKSPACE>
using OhMyREPL
include("REPL_helper.jl")
using LinearAlgebra, VMLS, Plots, Statistics

# Regularization portion of the class

D = house_sales_data()
area = D["area"];
beds = D["beds"];
condo = D["condo"];
location = D["location"];
price = D["price"];
N = size(price)
X_large = hcat(ones(N), area, max.(area.-1.5, 0), beds, condo, location .== 2, location .== 3, location .== 4 );
θ = X_large \ price

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

# Portfolio Optimization portion of the calss

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
T,n = size(R);

R
Rtest

Ttest, n = size(Rtest)

rho = 0.10/250

w = port_opt(R,rho)

sum(w)
r = R*w
mean(r)*250

# Review
A = randn(100,20); b = randn(100);
x1 = A\b; # Least squares using backslash operator
x2 = inv(A'*A)*(A'*b); # Using formula
x3 = pinv(A)*b; # Using pseudo-inverse
Q, R = qr(A);
Q = Matrix(Q);
x4 = R\(Q'*b);
x1
x2
x3

# Portfolio value with re-investment, return time series r
cum_value(r) = 10000 * cumprod(1 .+ r)

# Plot the in-sample behavior of the porfolio
plot(1:T, cum_value(r), label= "10%", legend=:topleft)

# Testing the optimal portfolio out of sample
returns_in_the_test_set = Rtest*w;
mean(returns_in_the_test_set)*250
save_REPL_history("L17_REPL_session.jl")