## Source: <https://julia.quantecon.org/getting_started_julia/julia_by_example.html>

using Statistics, Distributions, Plots

n = 100
f(x) = x^2
ϵ = randn(n)
plot(f.(ϵ), label="ϵ²")
plot!(ϵ, label="ϵ")

typeof(ϵ)

ϵ[1:5]

#array indices start at 1 (like MATLAB and Fortran but unlike Python and C)

## 'For' loops 

# Poor style
n = 100
ϵ² = zeros(n)
for i in 1:n
    ϵ²[i] = randn()^2
end

# Indentation does not matter, there's no colons after the for, the for loop must end with "end"

# Better style
n = 100
ϵ² = zeros(n)
for i in eachindex(ϵ²)
    ϵ²[i] = randn()^2
end

# You can loop directly over arrays
ϵ_sum = 0.0 # careful to use 0.0 here, instead of 0
m = 5
for ϵ_val in ϵ[1:m]
    ϵ_sum = ϵ_sum + ϵ_val
end
ϵ_mean = ϵ_sum / m


# Use built-in functions whenever possible
mean(ϵ[1:m])
ϵ_mean ≈ mean(ϵ[1:m])

#where we are comparing floating point numbers using ≈ `\approx`
#for integers and other types, use ==

## User-defined functions

# poor style
function generatedata(n)
    ϵ = zeros(n)
    for i in eachindex(ϵ)
        ϵ[i] = (randn())^2 # squaring the result
    end
    return ϵ
end

data = generatedata(10)
plot(data)

# still poor style
function generatedata(n)
    ϵ = randn(n) # use built in function

    for i in eachindex(ϵ)
        ϵ[i] = ϵ[i]^2 # squaring the result
    end

    return ϵ
end
data = generatedata(5)

## Instead of looping, we can broadcast the ^2 square function over a vector using a "."

# better style
function generatedata(n)
    ϵ = randn(n) # use built in function
    return ϵ.^2
 end
data = generatedata(5)

# good style
generatedata(n) = randn(n).^2
data = generatedata(5)


#Finally, we can broadcast any function, where squaring is only a special case.

# good style
f(x) = x^2 # simple square function
generatedata(n) = f.(randn(n)) # uses broadcast for some function `f`
data = generatedata(5)

##For this particular case, the clearest and most general solution is probably the simplest.

# direct solution with broadcasting, and small user-defined function
n = 100
f(x) = x^2
ϵ = randn(n)
plot(f.(ϵ), label="ϵ²")
plot!(ϵ, label="ϵ")

# Multiple dispatch: a crude introduction

#
histogram(rand(500))
lp = Laplace()
histogram(rand(lp,500))

#The function `rand` behaves differently depending on what arguments are passed on to it

#Hence in Julia we can take an existing function and give it a new behavior by defining how it acts on a new type of value.

#The compiler knows which function definition to apply to in a given setting by looking at the types of the values the function is called on.
# In Julia these alternative versions of a function are called methods.