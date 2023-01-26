## Hypothesis, p - value

## what is a gradient, derivatives, gradients, Jacobians, Hessians

## what is optimization

## ForwardDiff, ReverseDiff

## ChainRules, AutoDiff

AutoGrad | AutoDiff (automatic differentiation)

## Optimization using gradient

## what is gradient descent

## UAT Universal Approximation theorem

As per Wikipedia -

In the mathematical theory of artificial neural networks, universal approximation theorems are results, that establish the density of an algorithmically generated class of functions within a given function space of interest.

In simple English..

if you set knobs, levers (aka parameters..) of a given UAT function in such a way, this UAT function starts working as the magical function described above (i.e. universal approximation).

## Linear regression

## Taylor Series

## Fourier Transformation

## Loss function

## Gradient & Gradient Descent

## Curse of Dimensionality

## what is a Neural network

## Neurons

## Why we need layers

## What are activation functions

## Training neural networks

## Predicting results

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

--------

# p-value, null hypothesis and real time analytics (onlinestat)

In this section, we will see an example how to perform null hypthoses/p-value analysis on Ledger data.

*use case*

Finance Ledger

## Finance Ledger , Balance Sheet, Income Statement and Cash Flow

below is sample Finance Ledger Data,
in this Ledger data, we will run p-value to test following Hypothesis.

`For a Given Given FISCALY_YEAR and ACCOUNTING_PERIOD,
OPERATING EXPENSES are aligned (10%) tolerance range in comparison to BEFORE or AFTER FISCAL_YEAR & ACCOUNTING_PERIOD.`

```@repl
using DataFrames, Plots, Dates
# create dummy data
accounts = DataFrame(AS_OF_DATE=Date("1900-01-01", dateformat"y-m-d"), 
     ID = 11000:1000:45000,
     CLASSIFICATION=repeat([
  "OPERATING_EXPENSES","NON-OPERATING_EXPENSES", "ASSETS","LIABILITIES",
  "NET_WORTH","STATISTICS","REVENUE"
  ], inner=5),
 CATEGORY=[
  "Travel","Payroll","non-Payroll","Allowance","Cash",
  "Facility","Supply","Services","Investment","Misc.",
  "Depreciation","Gain","Service","Retired","Fault.",
  "Receipt","Accrual","Return","Credit","ROI",
  "Cash","Funds","Invest","Transfer","Roll-over",
  "FTE","Members","Non_Members","Temp","Contractors",
  "Sales","Merchant","Service","Consulting","Subscriptions"
 ],
 STATUS="A",
 DESCR=repeat([
  "operating expenses","non-operating expenses",
  "assets","liability","net-worth","stats","revenue"
 ], inner=5),
 ACCOUNT_TYPE=repeat([
 "E","E","A","L","N","S","R"
    ],inner=5));
dept = DataFrame(AS_OF_DATE=Date("2000-01-01", dateformat"y-m-d"), 
       ID = 1100:100:1500,
       CLASSIFICATION=[
 "SALES","HR", "IT","BUSINESS","OTHERS"
 ],
       CATEGORY=[
 "sales","human_resource","IT_Staff","business","others"
 ],
       STATUS="A",
       DESCR=[
 "Sales & Marketing","Human Resource","Infomration Technology","Business leaders","other temp"
 ],
       DEPT_TYPE=[
 "S","H","I","B","O"]);
location = DataFrame(AS_OF_DATE=Date("2000-01-01", dateformat"y-m-d"), 
       ID = 11:1:22,
       CLASSIFICATION=repeat([
 "Region A","Region B", "Region C"], inner=4),
       CATEGORY=repeat([
 "Region A","Region B", "Region C"], inner=4),
       STATUS="A",
       DESCR=[
"Boston","New York","Philadelphia","Cleveland","Richmond",
"Atlanta","Chicago","St. Louis","Minneapolis","Kansas City",
"Dallas","San Francisco"],
       LOCA_TYPE="Physical");
ledger = DataFrame(
  LEDGER = String[], FISCAL_YEAR = Int[], PERIOD = Int[], ORGID = String[],
  OPER_UNIT = String[], ACCOUNT = Int[], DEPT = Int[], LOCATION = Int[],  
  POSTED_TOTAL = Float64[]
 );
 # create 2020 Period 1-12 Actuals Ledger 
 l = "Actuals";
 fy = 2020;
 for p = 1:12
  for i = 1:10^5
  push!(ledger, (l, fy, p, "ABC Inc.", rand(location.CATEGORY),
   rand(accounts.ID), rand(dept.ID), rand(location.ID), rand()*10^8))
  end
 end
 # create 2021 Period 1-4 Actuals Ledger 
 l = "Actuals";
 fy = 2021;
 for p = 1:4
  for i = 1:10^5
  push!(ledger, (l, fy, p, "ABC Inc.", rand(location.CATEGORY),
   rand(accounts.ID), rand(dept.ID), rand(location.ID), rand()*10^8))
  end
 end
 # create 2021 Period 1-4 Budget Ledger 
 l = "Budget";
 fy = 2021;
 for p = 1:12
  for i = 1:10^5
  push!(ledger, (l, fy, p, "ABC Inc.", rand(location.CATEGORY),
   rand(accounts.ID), rand(dept.ID), rand(location.ID), rand()*10^8))
  end
 end
ledger[:,:]

```

#### p-value function

getPValue(ledger, ACCOUNT_CLASSIFICATION = "OPERATING_EXPENSES", FISCAL_YEAR =2021, ACCOUNTING_PERIOD = 7)

return p-value for given ACCOUNT NODE

getPValue(ledger, ACCOUNT_CLASSIFICATION = "OPERATING_REVENUE", FISCAL_YEAR =2021, ACCOUNTING_PERIOD = 7)

return p-value for given ACCOUNT NODE

getPValue(ledger, ACCOUNT_CLASSIFICATION = "OPERATING_ASSETS", FISCAL_YEAR =2021, ACCOUNTING_PERIOD = 7)

return p-value for given ACCOUNT NODE

getPValue(ledger, DEPT_CLASSIFICATION = "OPERATING_EXPENSES", FISCAL_YEAR =2021, ACCOUNTING_PERIOD = 7)

return p-value for given DEPT NODE

getPValue(ledger, DEPT_CLASSIFICATION = "OPERATING_REVENUE", FISCAL_YEAR =2021, ACCOUNTING_PERIOD = 7)

return p-value for given DEPT NODE

getPValue(ledger, DEPT_CLASSIFICATION = "OPERATING_ASSETS", FISCAL_YEAR =2021, ACCOUNTING_PERIOD = 7)

return p-value for given DEPT NODE

getPValue(ledger, REGION_CLASSIFICATION = "OPERATING_EXPENSES", FISCAL_YEAR =2021, ACCOUNTING_PERIOD = 7)

return p-value for given REGION NODE

getPValue(ledger, REGION_CLASSIFICATION = "OPERATING_REVENUE", FISCAL_YEAR =2021, ACCOUNTING_PERIOD = 7)

return p-value for given REGION NODE

getPValue(ledger, REGION_CLASSIFICATION = "OPERATING_ASSETS", FISCAL_YEAR =2021, ACCOUNTING_PERIOD = 7)

return p-value for given REGION NODE
