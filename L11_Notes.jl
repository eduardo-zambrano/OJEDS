include("REPL_helper.jl");
using OhMyREPL, LinearAlgebra

# Source:
# https://ec.europa.eu/eurostat/documents/3859598/5902113/KS-RA-07-013-EN.PDF/b0b3d71e-3930-4442-94be-70b36cea9b39?version=1.0
# pages 493-494

# Intermediate Consumption by Industry  (page 483)
# (Millions of Euro)
I_O =[1131	25480	1	607	710	762;
7930	304584	64167	41082	11981	30360;
426	    7334	3875	5296	23457	9155;
3559	72717	14190	74399	10835	21008;
3637	96115	31027	65755	193176	34223;
1552	14986	1747	11225	15058	22070]

# Sectors:
# 1. Agriculture. Products of agriculture, forestry, fisheries and aquaculture
# 2. Manufacturing. Products of mining and quarrying, manufactured products and energy products.
# 3. Construction. Construction work.
# 4. Trade. Wholesale and retail trade, repair services, hotel and restaurant services, transport and communication services.
# 5. Business services. Financial intermediation services, real estate, renting and business services.
# 6. Other services. Other services  

# Final Consumption by Industry
# (Millions of Euro)
y = [15219
619296
196063
343355
268554
442280]


# Total production by Industry
x = [sum(I_O[i,:])+y[i] for i in 1:6]

# Input - Output Coefficients (page 485)
A = hcat([I_O[:,i] / x[i] for i in 1:6]...)

# Leontief matrix (page 487)
I - A

# Leontief Inverse (page 488)
(I-A)^-1

# Baseline
(I-A)^-1 * y

# Add 1 million EUR of final demand. Where does it have the greatest effect? (page 488)
sum((I-A)^-1 * [1,0,0,0,0,0])
sum((I-A)^-1 * [0,1,0,0,0,0])
sum((I-A)^-1 * [0,0,1,0,0,0])
sum((I-A)^-1 * [0,0,0,1,0,0])
sum((I-A)^-1 * [0,0,0,0,1,0])
sum((I-A)^-1 * [0,0,0,0,0,1])

# Intermediate Emissions 
# (1,000 tons)
E =[10448 558327 11194 71269 8792 26990; 
1534 1160 1 4 1 1058;
77 100 0 3 0 11 ;]

# Emissions:
# 1. Carbon Dioxide.
# 2. Methane.
# 3. Nitrous Oxide.

# Private Consumption Emissions
p = [217137
136
17]

# Emission coefficients
B = hcat([E[:,i] / x[i] for i in 1:6]...)

# Direct and indirect emissions per unit of output
B*(I-A)^-1

Y = Diagonal(y)

# Emission content of final demand
 B*(I-A)^-1 * Y
  p 

# Remember to 
# 1. save the REPL session.

save_REPL_history("L10_REPL_session.jl")

# 2. GIT commit and GIT push at the end of class.