# Source: https://web.stanford.edu/~boyd/vmls/vmls-julia-companion.pdf

include("REPL_helper.jl");
using OhMyREPL
using VMLS, LinearAlgebra

#   14.2 Least squares classifier
#   –––––––––––––––––––––––––––––––
#   Iris flower classification. 
D = iris_data()

# Create 150x4 data matrix
iris = vcat(D["setosa"], D["versicolor"], D["virginica"])

# y[k] is true (1) if virginica, false (0) otherwise
y_o = [ zeros(Bool, 50); zeros(Bool, 50); ones(Bool, 50) ]
y = 2*y_o .-1 # Converting to +1 and -1

# Set up the features matrix
X = [ ones(150) iris ]

# Train the classifier
β = X \ y
f_tilde_X = X*β

y_hat = f_tilde_X .>0

confusion_matrix(y_o,y_hat)

# See p. 290 
