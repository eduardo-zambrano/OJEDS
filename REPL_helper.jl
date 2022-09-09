# Some functionality to save the current REPL history to a file
# Credit: https://discourse.julialang.org/t/export-from-repl-history-to-julia-script/59399/8

"""
Get commands of the current REPL session as an array of strings
"""
function get_REPL_as_history()
          history = Base.active_repl.interface.modes[1].hist
          history.history[history.start_idx+1:end]
end
"""
Save REPL commands of this session to a file

file: Path to a file
"""
function save_REPL_history(file)
           isfile(file) && error("file already exists")
           open(file,"w") do io
                      txt = join(get_REPL_as_history(),"\n")
                      write(io,txt)
           end
end