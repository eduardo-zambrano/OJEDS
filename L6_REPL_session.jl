include("REPL_helper.jl")
using LinearAlgebra, OhMyREPL

a1 = [0,0,-1]; a2 = [1,1,0]/sqrt(2); a3 = [1,-1,0]/sqrt(2);

norm(a1)
norm(a2)
norm(a3)

a1'*a2
a1'*a3
a2'*a3

x = [1,2,3]

β1 = a1'*x
β2 = a2'x
β3 = a3'x
x_expected = β1*a1 +β2*a2 + β3*a3


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

q = gram_schmidt(a)
zz=[("norm(q[1]:)",norm(q[1])),
("q[1]'*q[2]:",q[1]'*q[2]),
("q[1]'*q[3]:",q[1]'*q[3]),
("norm(q[2]):",norm(q[2])),
("q[2]'*q[3]:",q[2]'*q[3]),
("norm(q[3]):",norm(q[3]))]

save_REPL_history("L6_REPL_session.jl")