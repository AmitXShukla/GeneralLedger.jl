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
using Pkg;
Pkg.add(url="https://github.com/AmitXShukla/GeneralLedger.jl.git");
using GeneralLedger;
GeneralLedger.getSampleFigFunctions("functions.png")
```

![](functions.png)

## Using Functions in Machine learning
Functions are smart, given an input value, it can always provide an output value.

We just learned essence of machine learning, if we know function logic, we can always predict output for a given input.

It's always true, however, problem is, we don't always know the logic, when function definition or logic is not known, Human, animals or machine fail to deliver output regardless of input available.

Most of the time, whether is working on mechanical, electrical or civil engineering projects, we can predict output based on inputs, provided problem/logistics are defined, calculated in certain ways using some functional formula, like
`F = ma or E = mc2`

But what if, when logistics or mechanism is not known or partially known, is it still possible to predict output just based on some input?

Let's pretend, if we have a magical function which given an input produces a rationally acceptable output.

Machine learning, is data science of finding this missing magical function, which given an input produces a rationally acceptable output.

## Machine learning without any library

Let's take an example,

Time taken to travel between two cities via Air, Bus, Train or personal vehicle depends mostly depends on speed and distance. However, there are other factors like weather, season, population or faults, which may occasionally impact travel time.
However, knowing intensity of these factors, it's still possible to predict time taken rationally.

```@repl
using Pkg;
Pkg.add(url="https://github.com/AmitXShukla/GeneralLedger.jl.git");
using GeneralLedger;
GeneralLedger.getSampleDataTimeTaken(5)
```
*There are many assumptions when calculating Time taken,
like, Passenger time taken for preparation or time to travel to bus, train station is not reflected in calculations.
Let's capture these assumptions as bias for now.*

### Finding magical function
Let's assume that we don't know "time taken" formula or some reason like we don't exactly know speed of UFO or Jet Pack, how else we would know how much time it’s going to take to reach to destination when facts are unknown.

Answer may surprise you,

Ask a daily/weekly train or bus commuter, a person who has traveled long enough between two places, often knows and can rationally predict time taken in journey using different vehicles.

Of course, `Time Taken = d/s + b` may give same or better results, 
but it's been observed, if a person's mind is trained (traveled in this case) enough (aka is experienced), can predict and often beat pre-defined formulas and even apply learnings on unknown/unseen circumstances.

In a nutshell, human mind has magical functions stored in brain cells, let's call them neurons, which is trained on data rather than formulas. Using Trained functions, one can apply learning rationally and predict outcome.

Neural network deep learning is nothing but an art of finding this magical function which can be used to rationally predict outcomes based on some input data.

Let's take another example, which is more familiar and relevant to Finance community.

```html
    BD = Buddy Deposit
    CD = Certificate of Deposit
    P = Principal amount
    r = R/100
    R = Rate of Interest
    T = Time in years
    n = compound (365 = daily, 12=monthly, 1=yearly)
```

### Buddy Deposit system
let’s say, one borrows money from buddy and return it on a simple yearly calculated interest condition

```math
    BD = P (1 + r*t/n)
```

Using above formula, one can safely predict,
The total amount accrued, principal plus interest, with simple interest on a principal of `$100,000.00` at a rate of `3.875%` per year over `7.5` years is `$129,062.50`.

### Certificate Deposit, with complex compound interest
```math
    CD = P (1 + r/n)^n*T
```

Using above formula, one can safely predict,
The total amount accrued, principal plus interest, with compound interest on a principal of `$100,000.00` at a rate of `3.875%` per year compounded `365` times per year over `7.5` years is `$133,724.24`.

```html
    A = P + I where
    P (principal) = $100,000.00
    I (interest) = $33,724.24

    Calculation Steps:

    First, convert R as a percent to r as a decimal
    r = R/100
    r = 3.875/100
    r = 0.03875 rate per year,

    Then solve the equation for A
    A = P(1 + r/n)^nt
    A = 100,000.00*(1 + 0.03875/365)^(365)(7.5) 
    A = 100,000.00*(1 + 0.00010616438356164)^(2737.5) 
    A = $133,724.24 
```

### Mutual Fund Deposit
```html
    Formula = GOK (God only knows)
```

```@repl
using Pkg;
Pkg.add(url="https://github.com/AmitXShukla/GeneralLedger.jl.git");
using GeneralLedger;
GeneralLedger.getSampleDataDeposits(sampleSize=10, P=10000, r=3.875, n=1, t=90)
```

Let's use Julia language to create some data and plot this for visual analysis.

### UAT Universal Approximation theorem
As per Wikipedia -

In the mathematical theory of artificial neural networks, universal approximation theorems are results, that establish the density of an algorithmically generated class of functions within a given function space of interest. 

In simple English..

if you set knobs, levers (aka parameters..) of a given UAT function in such a way, this UAT function starts working as the magical function described above (i.e. universal approximation).

Linear regression
Taylor Series
Fourier Transformation

Loss function

Gradient
Gradient Descent

Curse of Dimensionality

Neural network

Neurons

Why we need layers

What are activation functions

Training neural networks



What is a neural network
A neural network is the magical function:
NN(x)= W(n)σ(n-1)…..(W3σ2(W2σ1(W1x+b1)+b2)+b3…. bn)
where W & b (weight & bias) are changeable, represent parameters of a given layer in multi "n" layer function and when these knobs & lever, aka parameters(weights, bias) are trained to tune properly, can produce a rationally acceptable output given a set of input values.

For the beginner, let's simplify this and work on a single layer.

NN(x) = W1x + b

How computer works and what is GPU

Stack vs HEAP

Programming Languages and ML Frameworks


UAT
This means that NN(x) is now a very good function approximator to f(x) = ones(5)!
So Why Machine Learning? Why Neural Networks?
All we did was find parameters that made NN(x) act like a function f(x). How does that relate to machine learning? Well, in any case where one is acting on data (x,y), the idea is to assume that there exists some underlying mathematical model f(x) = y. If we had perfect knowledge of what f is, then from only the information of x we can then predict what y would be. The inference problem is to then figure out what function f should be. Therefore, machine learning on data is simply this problem of finding an approximator to some unknown function!
So why neural networks? Neural networks satisfy two properties. The first of which is known as the Universal Approximation Theorem (UAT), which in simple non-mathematical language means that, for any ϵ of accuracy, if your neural network is large enough (has enough layers, the weight matrices are large enough), then it can approximate any (nice) function f within that ϵ. Therefore, we can reduce the problem of finding missing functions, the problem of machine learning, to a problem of finding the weights of neural networks, which is a well-defined mathematical optimization problem.
Why neural networks specifically? That's a fairly good question, since there are many other functions with this property. For example, you will have learned from analysis that a0+a1x+a2x2+…a0+a1x+a2x2+… arbitrary polynomials can be used to approximate any analytic function (this is the Taylor series). Similarly, a Fourier series
f(x)=a0+∑kbkcos(kx)+cksin(kx)f(x)=a0+∑kbkcos⁡(kx)+cksin⁡(kx)
can approximate any continuous function f (and discontinuous functions also can have convergence, etc. these are the details of a harmonic analysis course).
That's all for one dimension. How about two dimensional functions? It turns out it's not difficult to prove that tensor products of universal approximators will give higher dimensional universal approximators. So for example, tensoring together two polynomials:
a0+a1x+a2y+a3xy+a4x2y+a5xy2+a6x2y2+…a0+a1x+a2y+a3xy+a4x2y+a5xy2+a6x2y2+…
will give a two-dimensional function approximator. But notice how we have to resolve every combination of terms. This means that if we used n coefficients in each dimension d, the total number of coefficients to build a d-dimensional universal approximator from one-dimensional objects would need ndnd coefficients. This exponential growth is known as the curse of dimensionality.

A fundamental problem that makes language modeling and other learning problems difficult is the
curse of dimensionality. It is particularly obvious in the case when one wants to model the joint
distribution between many discrete random variables (such as words in a sentence, or discrete at-
tributes in a data-mining task). For example, if one wants to model the joint distribution of 10
consecutive words in a natural language with a vocabulary V of size 100,000, there are potentially
100 00010 − 1 = 1050 − 1 free parameters. 

From <https://www.jmlr.org/papers/volume3/bengio03a/bengio03a.pdf> 




NN Function
Background
Neural networks (NNs) are a collection of nested functions that are executed on some input data. These functions are defined by parameters (consisting of weights and biases), which in PyTorch are stored in tensors.
Training a NN happens in two steps:

Gradient

Gradient descent

Forward pass
copied from PyTorch
Forward Propagation: In forward prop, the NN makes its best guess about the correct output. It runs the input data through each of its functions to make this guess.

Backward propagation
copied from PyTorch
Backward Propagation: In backprop, the NN adjusts its parameters proportionate to the error in its guess. It does this by traversing backwards from the output, collecting the derivatives of the error with respect to the parameters of the functions (gradients), and optimizing the parameters using gradient descent. For a more detailed walk through of backprop, check out this video from 3Blue1Brown.

Auto Grad

Automatic Differentiation

Loss function

Generalization

Regularization

Optimization

Epoch

Layers
Why we need so many layers?

Activation functions
Why we need activation functions in NN

Training
Testing
Predictions

---

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