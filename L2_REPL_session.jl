# Run Julia from your OJEDS directory
#]
#activate .
#<BACKSPACE>
include("REPL_helper.jl")
using OhMyREPL

# Source: https://github.com/miguelraz/REPLMasteryWorkshop

x = 3 + 3
ans

β = 9
⛵ = 10
#;
#pwd
#ls
#<BACKSPACE>
#?
#sin
#<BACKSPACE>
#;
#vim README.md
# Stuff happened inside vim
#ls
#git add README.md
#git commit -m "Incorporated Christine's taste in music"
#git push
#<BACKSPACE>
#]
#status
#gc
#<BACKSPACE>
using UnicodePlots
save_REPL_history("L2_REPL_session.jl")