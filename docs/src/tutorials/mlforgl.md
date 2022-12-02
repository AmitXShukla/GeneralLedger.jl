# Machine Learning for General Ledger

This tutorial is gentle introduction to understand deep learning concepts with help of real life examples.
This chapter demonstrates, how to train Finance data on given dataset and predict values.

*This chapter is very detailed, beginner friendly tutorial and assume no prior ML experience.*

For experienced programmers, please skip to [Use Cases](@ref) section below.


## What is AI, ML and Deep Learning
as per Wikipedia
The term "artificial intelligence" is intelligence demonstrated by machines, as opposed to natural intelligence displayed by humans and animals. Major AI researchers, now define AI in terms of rationality and acting rationally, which does not limit how intelligence can be articulated.

When Machines are trained to learn problem solving skills by use of information, this process of learning is Machine Learning. Further Deep learning is a special type of Machine learning where neural networks are used for learning purpose to solve a problem.

Now, introduction is out of the way, let’s learn meaning of these big words by actually doing it.

here are new AI, ML & DL definitions.
- If you see a Power Point, it's an AI.
- If you see code with calculus you understand, it's ML.
- If you see code with calculus you don't understand, it's DL.
- If you see calculus wrapped in layers, is NN, 
- if calculus after calculus, is C/RNN, 
- If calculus remembering calculus is LSTM,
- If calculus with physics is PINN
- And so on…so forth…

![AI ML DL](../images/aimldl.png)

## Data
Data is useful information described in terms of numbers, text, audio, video, images or any other format which can be read, write and understood in computers.

## Functions
```math
    y = f(x)
```
In functional programming languages, Function is defined as an object, which take input values and maps to output values based on some logic.

### Discrete Functions
Give a set or range of input values, if a function produces discrete and separate output (unconnected values), is a discrete function.
for example: number of people in a concert

```math
    y = f(x) = x + 12
```
```math
    y = f(300) = 312
```

### Continuous Functions
Give a set or range of input values, if a function produces output which can take any value with in a finite or infinite interval (connected values), is a continuous function.
for example: height of one person in a concert may be anywhere within possible heights from 4ft to 7.2ft.

```math
    y = f(m, f) = (mother's height + father's height)/2
```
```math
    y = f(5, 6) = 5.5
```

```@repl
# let's open a Julia REPL and import packages
# if you are new to Julia REPL environment and installation
# please visit this blog https://amit-shukla.medium.com/setup-local-machine-ipad-android-tablets-for-julia-lang-data-science-computing-823d84f2cb28

using Pkg
Pkg.add(["DataFrames","CSV","CairoMakie"]);
Pkg.add(url="https://github.com/AmitXShukla/GeneralLedger.jl.git");
using DataFrames, CSV, CairoMakie, GeneralLedger;

x = 0:5:100;
f = Figure(backgroundcolor = :orange, resolution = (600, 400));
ax1 = Axis(f[1,1], title = "Discrete Function", xlabel = "x", ylabel = "y");
ax2 = Axis(f[1,2], title = "Continuous Function", xlabel = "x", ylabel = "y");
scatter!(ax1,x,x .+ 12);
lines!(ax2,x,sin.(x));
# f # uncomment this to see when figure when running online

save("functions.png", f)
```
```@repl
using Pkg;
Pkg.add(url="https://github.com/AmitXShukla/GeneralLedger.jl.git");
using GeneralLedger;
GeneralLedger.getSampleFigFunctions("functions.png")
```

![](functions.png)

```@repl

GeneralLedger.getSampleDataTimeTaken(5)
```
## Use Cases

- Finance Ledger ACTUALS - Predict $$ by ACCOUNT Classifications
- Finance Ledger ACTUALS - Predict $$ by REGION Classifications
- Dynamic roll ups
- Invoices by Diversity Vendor groups
- Predict Duplicate/Fuzzy Vendor Invoices
- Vendor Ranking
- Product Ranking
- Cost per Invoice
- Operating Expenses trend
- Supply chain Inventory Dashboard