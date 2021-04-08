push!(LOAD_PATH,"../src/")
using Documenter, GeneralLedger

makedocs(sitename="GeneralLedger.jl",
	  pages = [
		   "Objective" => "index.md"
		   "Introduction" => "introduction.md"
		   "Tutorials" => [
				  "About GL" => "tutorials/aboutgl.md"
				  ]
		   ],
	  )
