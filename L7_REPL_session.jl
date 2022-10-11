#]
#activate .
#pwd
#<BACKSPACE>

include("REPL_helper.jl");
using OhMyREPL, LinearAlgebra

# Source: https://web.stanford.edu/~boyd/vmls/vmls-julia-companion.pdf

function gram_schmidt(a; tol = 1e-10)
    
    q = []
    for i = 1:length(a)
        qtilde = a[i]
        for j = 1:i-1
            qtilde -= (q[j]'*a[i]) * q[j]
        end
        if norm(qtilde) < tol
            println("Vectors are linearly dependent.")
            return q
        end
        push!(q, qtilde/norm(qtilde))
        end;
    return q
end
a = [ [-1, 1, -1, 1], [-1, 3, -1, 3], [1, 3, 5, 7] ]
a[1]
a[2]
a[3]
# a[4] gives an error
a
q = gram_schmidt(a)
norm(q[1])
norm(q[2])
norm(q[3])

q[1]'*q[2]
q[1]'*q[3]
q[2]'*q[3]

β1 = q[1]'*a[1]
β1*q[1]

γ1 = q[1]'*a[2]
γ2 = q[2]'*a[2]
victor = γ1*q[1] + γ2*q[2]

victor3 = (q[1]'a[3]) * q[1] + (q[2]'*a[3]) * q[2] + (q[3]'*a[3]) * q[3]
save_REPL_history("L7_REPL_session.jl");