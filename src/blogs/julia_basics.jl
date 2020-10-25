### A Pluto.jl notebook ###
# v0.11.14

using Markdown
using InteractiveUtils

# ╔═╡ b8468210-f906-11ea-1ea9-51db4f0143e3
md"# Learn Julia Basics

This is not a typical Julia TODO List tutorial.

This notebook is intended to cover all Julia Language basics needed but not limited to do Data Science for ERP Analytics.

later tutorials (not this tutorial), assume fundamental understanding in ERP systems (HCM, Finance, SupplyChain, AM, Grants, CRM etc.) using ORACLE, SAP, PeopleSoft, Intuit etc. to learn ML for GL, i.e. Machine Learning for General Ledger, Supply chain, CRM etc.

Please open
[![GitHub issue](https://github.com/AmitXShukla/GeneralLedger.jl/blob/master/docs/src/images/github.png)](https://github.com/AmitXShukla/GeneralLedger.jl/issues) for any suggestions.

Here is a 
[![YouTube](https://github.com/AmitXShukla/GeneralLedger.jl/tree/master/docs/src/images/youtube.png)](https://youtube.com/amitshukla_ai) video tutorial.

**Table of Contents**
- OOPs vs about Julia Types as Object
- Julia Environment, REPL, Pkg, Modules, Project, Application
- utilities
- Char, String, Numbers, Data Type, Arrays, Math
- Functions
- Control Flows
- Type System
- Methods, Method Dispatch, Constructors
- Conversion
- Interfaces
- Metaprogramming
- why Julia is fast 
- julia vs Python for EPR Data Science - DS for ERP is more of Statistics and numerical computing, this is why Julia fits more than Python

**what is not included in this notebook**
- Parallel, Distributed, Async computing
- Embedded Julia
- Other Advance topics
"

# ╔═╡ 258c0790-f908-11ea-33d5-e3c994b9a2dc
md"
# OOPs vs Julia Types as Object

Julia features optional typing, multiple dispatch, and good performance, achieved using type inference and just-in-time (JIT) compilation, implemented using LLVM. It is multi-paradigm, combining features of imperative, functional, and object-oriented programming. 

*Walks like a Python, runs like C.*

In OOPs, We create classes which contain properties and behaviors, objects are created as instance of classed which inherit properties and bahavior as functions.

In Julia, There is no division between object and non-object values: all values in Julia are true objects having a type that belongs to a single, fully connected type graph, all nodes of which are equally first-class as types.

True objects are created having a Type and functions/methods/constructors are created to define behavior which takes Objects/Types as arguments.

In Julia Lang's own words.

*inherit behavior is much more important than being able to inherit structure, and inheriting both causes significant difficulties in traditional object-oriented language.*"

# ╔═╡ d38f10f0-f906-11ea-37f9-1bc62cb49996
md"
# Julia Environment, REPL, Pkg, Modules, Project, Application
**The Julia REPL :** full-featured interactive command-line REPL (read-eval-print loop) built into the julia executable *in color*.

Best tool ever for Techie Geeks & Gurus on the go.
REPL is for people who wake up middle of night and expect a code editor ready in less than 10 seconds.
Once you get use to REPL, there is no other code editor you may want to use in real life.

I use REPL on Pro office machines and iPad on the go (rent Linux cloud VM, use SSH client to connect to REPL, start Jupyter or Pluto notebooks on tablet/mobile devices).


**Install Julia/REPL :** [download Julia](https://julialang.org/downloads/)

**what is Project:** it's your standard working directory where you would typically keep
- *src* folder to keep Julia code files,
- *docs* folder to keep related documentation
- *test* User testing scripts
- *Project.toml* metadata about your project (like UUID, Author etc.)
- *Manifest.toml* file to keep complete dependency graph

**Package:** is a Project, which provide reusable functionality which can be *imported*

**Applications** can provide global configuration, whereas packages cannot.

 **Environments** is a real working environment where you create projects, applications and work with projects.

**Modules** are individual components of your overall Julia package which implement a discrete functionality.
"

# ╔═╡ d025a730-f906-11ea-3a3e-8b4df90c32ef
md"
# Utilities

- ENV[\"COLUMNS\"]
- ENV[\"LINES\"]
- ENV[\"JULIA_EDITOR\"] -> set this to your vscode code editor

- if you type ; after julia commands, it doesnt show results in REPL, is useful to avoid printing DB conns or passwords during REPL working sessions

- Type ] on REPL put you on package mode
- on Pkg prompt, type add, update, remove and status
- in Julia REPL type ]
*tips*
- when you start working on a new project, always prefer to activate a new environment
- Type activate GeneralLedger -> will create a new Julia environment
- make sure your Pkg prompt show (GL)Pkg> instead of (1.4)pkg>
- use ; in Julia REPL to switch to shell window

*utilities*
- pwd() -> show current directory
- readdir() -> show current directory contents
- Type ; on REPL to switch to Shell mode and then Type tree .
- joinpath(pwd(), \"data\") -> handy method used with pwd() to join subdirs
- versioninfo() -> show version & current ENV settings
- apropos(\"mean\") or type ?mean
- @which +(1234.56, 12)
- @time +(1234.56, 12)

*how to read any file in REPL*
- io = open(joinpath(pwd(), \"src\", \"conn.jl\",\"r\")
- print(read(io, String))
- ->or use less command as shown below
- less(joinpath(pwd(), \"src\", \"conn.jl\"))
- open source file in your editor using edit command as shown below
- edit(joinpath(pwd(), \"src\", \"conn.jl\")

*llvm*
- my_square(x) = x^2;
- @code_llvm my_square(1)
- @code_llvm my_square(1.0)
- function f(a,b)
-  return 2a+b
- end
- @code_native f(2.0,3.0)
- @code_llvm f(2.0,3.0)
- @code_warntype f(1,2.0) -> learn how to use it to identify type instability

* get into habit of writing docstring*
\"Flip a biased coin with probability \$p\$\"

```
function coin(p)
	r = rand()
	return r < p
end
```

*using interact*

```
	@manipulate for i in 1:10
  		i^2
	end
```
	
@macroexpand 
CHECK PLUTO.JL

*REPL is not slow*
-just Don't write your scripts directly in the REPL, always wrap them in a function. 
"

# ╔═╡ 7d3f576e-fde6-11ea-146b-216666634512
md"
# Char, String, Numbers, Data Types, Arrays, Math

**Char**
"

# ╔═╡ Cell order:
# ╟─b8468210-f906-11ea-1ea9-51db4f0143e3
# ╟─258c0790-f908-11ea-33d5-e3c994b9a2dc
# ╟─d38f10f0-f906-11ea-37f9-1bc62cb49996
# ╟─d025a730-f906-11ea-3a3e-8b4df90c32ef
# ╠═7d3f576e-fde6-11ea-146b-216666634512
