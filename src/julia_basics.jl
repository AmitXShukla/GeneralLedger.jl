### A Pluto.jl notebook ###
# v0.11.14

using Markdown
using InteractiveUtils

# ╔═╡ b8468210-f906-11ea-1ea9-51db4f0143e3
md"# Learn Julia Basics

This is not a typical Julia TODO List tutorial.

This notebook is intended to cover all Julia Language basics needed but not limited to do Data Science for ERP Analytics.

later tutorials (not this tutorial), assume fundamental understanding in ERP systems (HCM, Finance, SupplyChain, AM, Grants, CRM etc.) using ORACLE, SAP, PeopleSoft, Intuit etc. to learn ML for GL, i.e. Machine Learning for General Ledger, Supply chain, CRM etc.

**Table of Contents**
- OOPs vs about Julia Types as Object
- Julia Environment, REPL, Pkg, Modules, Project, Application
- utilities
- String, Numbers, Arrays, Math & Functions
- Type System
- Methods, Method Dispatch, Constructors
- Conversion
- Interfaces
- Metaprogramming
- why Julia is fast 
- julia vs Python for EPR Data Science - DS for ERP is more of Statistics and numerical computing, this is why Julia fits more than Python"

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

I use REPL on Pro office machines and iPad on the go (rent Linux cloud VM, use SSH client to connect to REPL).


**Install Julia/REPL :** [download Julia](https://julialang.org/downloads/)
"

# ╔═╡ d025a730-f906-11ea-3a3e-8b4df90c32ef


# ╔═╡ Cell order:
# ╟─b8468210-f906-11ea-1ea9-51db4f0143e3
# ╟─258c0790-f908-11ea-33d5-e3c994b9a2dc
# ╠═d38f10f0-f906-11ea-37f9-1bc62cb49996
# ╠═d025a730-f906-11ea-3a3e-8b4df90c32ef
