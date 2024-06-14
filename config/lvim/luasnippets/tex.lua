print("in tex.lua")

return {
  s("itemize", {
    t({ "\\begin{itemize}" }),
    t({ "", "\t" }), i(0),
    t({ "", "\\end{itemize}" }),
  }),
}
