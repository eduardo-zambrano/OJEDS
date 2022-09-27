#;pwd
#activate .
include("REPL_helper.jl")
using OhMyREPL
x = true
x
typeof(x)
y = 1>2
typeof(y)
typeof(1.0)
typeof(1)
x = 2 ; y = 1.0
2x - 3y
x = "SpongeBob"
typeof(x)
x = "F"
typeof(x)
y = 'F'
typeof(y)
y = 'β'
typeof(y)
z = '⚾'
typeof(z)
⚾ = 99
typeof(⚾)
"y = $z"
⚾
x
"y = $x "
"Sponge"*"Bob"
s = "Charlie don't surf"
split(s)
replace(s, "surf" => "climb")
strip("     SpongeBob     ")
x =("Doctor", )
x =("Doctor", "Strange")
# x[1] = "Nurse" """this would give an error
y = ["Doctor", "Strange"]
y[1] = "Nurse"
y
z = y
z[1] = "Player"
z
y
w = copy(y)
w[1] = "Spy"
w
y
x = [10, 20, 30, 40]
x[end]
x[end-1]
x[1:3]
x[2:end]
"DoctorStrange"[3:end]
actions =["surf", "ski"]
for action in actions
    println("Charlie doesn't $action")
end
for action in actions
    println("Charlie does $action")
end
for i in 1:3
    print(i)
end
x_values = 1:5
typeof(x_values)
typeof(eachindex(x_values))
for i in eachindex(x_values)
println(x_values[i]^2)
end
doubles = [ 2i for i in 1:4]
typeof(doubles)
animals = ["dog", "cat", "bird"]
plurals = [ animal * "s" for animal in animals]
[ i + j for i in 1:3, j in 4:6]
x = 1
x == 1
x == 2
x != 2
1 + 1E-8 ≈ 1
x = true
!x
true && false
false && true
x
z
true || z
function test(x,y)
           if x < y
               relation = "less than"
           elseif x == y
               relation = "equal to"
           else
               relation = "greater than"
           end
           println("x is ", relation, " y.")
end
test(1,1)
test(1,2)
function newtest(x,y)
    return x < y ? "less than" : "not less than"
end
newtest(7,7)
whuut(x,y) = x < y ? "less than" : "not less than"
z = 7 < 8
save_REPL_history("Lecture_3_REPL.jl")