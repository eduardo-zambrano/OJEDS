include("REPL_helper.jl");
using OhMyREPL, LinearAlgebra


# Source:
# https://ec.europa.eu/eurostat/documents/3859598/5902113/KS-RA-07-013-EN.PDF/b0b3d71e-3930-4442-94be-70b36cea9b39?version=1.0
# pages 493-494


# Intermediate Consumption by Industry 
I_O =[1131	25480	1	607	710	762;
7930	304584	64167	41082	11981	30360;
426	    7334	3875	5296	23457	9155;
3559	72717	14190	74399	10835	21008;
3637	96115	31027	65755	193176	34223;
1552	14986	1747	11225	15058	22070]

# Final Consumption by Industry

y = [15219
619296
196063
343355
268554
442280]


# Total production by Industry
x = [sum(I_O[i,:])+y[i] for i in 1:6]

# Input - Output Coefficients
A = hcat([I_O[:,i] / x[i] for i in 1:6]...)

# Leontief Inverse
(I-A)^-1

# Intermediate Emissions 
E =[10448 558327 11194 71269 8792 26990; 
1534 1160 1 4 1 1058;
77 100 0 3 0 11 ;]

# Final Emissions
p = [217137
136
17]

# Emission coefficients
B = hcat([E[:,i] / x[i] for i in 1:6]...)


B*(I-A)^-1

Y = Diagonal(y)

Z = B*(I-A)^-1 * Y


# Remember to 
# 1. save the REPL session.

save_REPL_history("L10_REPL_session.jl")

# 2. GIT commit and GIT push at the end of class.