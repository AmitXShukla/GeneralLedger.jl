# Probability & Statistics

---

In this chapter, we will examine the **basics of probability and statistical distributions**, and how they relate to our financial data.

- [Probability and Statistical Distributions](@ref)
    - [Probability](@ref)
    - [Sample space](@ref)
    - [Probability axioms](@ref)
    - [Probability consequences](@ref)
- [Probability Distributions Functions (PDFs)](@ref)
    - [Probability Mass Function (PMF)](@ref)
    - [Probability Density Function (PDF)](@ref)
    - [Cumulative Density Function (CDF)](@ref)
    - [Probability Distributions Functions (PDFs)](@ref)
- [Distributions](@ref)
    - [Normal Gaussian, Binomial, Poisson, Exponential](@ref)
    - [Mean, median, mode, average, weighted average, EWA](@ref)
    - [p value, quantile, quartile](@ref)
    - [standard deviation, Correlation, covariance](@ref)
    - [moments, entropy, skewness, kurtosis, entropy](@ref)
- [CLT - Central limit Theorem](@ref)

## Probability and Statistical Distributions

---

**how do you explain what a probability distribution in statistics is?**

In simple terms, we use a single value to represent a group of data. This value is called the measure of central tendency and it describes what is typical or average in the data. Common measures of central tendency include the mean, median, and mode.

Probability and distributions aid in comprehending general patterns within data during statistical analysis.

For example, given a set of 100k different Mutual Funds or Stock prices estimated growth is, we want to have a general idea of about how each group of Mutual Fund or stock prices is performing in over all market conditions.

!!! note "what's the point of learning statistics for Finance ML"
    If you are wondering, why we even care of learning probability, statistics, algebra and calculus functions for the sake of Finance Analytics.
    It's because building AI, is all about using mathematics to find statistical association to rationally predict outcome of an event given a set of inputs, than casual reasoning.

    As we progress, we will see, how learning statistical associations and using calculus for automation in small steps,
    lead to performing statistical tasks, automate predictive analytics, which are fast improved fact based statistical association rather than casual reasoning, and often outperforms human intuitive analytics.

## Probability

---
A probability event is defined as set of outcomes of an experiment. In simpler words, Probability is likelihood of occurrence of an event.

As an example, What’s the probability of the fair coin landing on Heads?

Calculating statistical probability mathematically helps us answer these type of questions.

```math
    f = Number of favorable Outcomes \\
    T = Total number of outcomes \\
    P(X = Head) = \frac{f}{T} \\
    P(X = Head) = \frac{P(H)}{P(H)+P(T)} \\
    P(X = Head) = \frac{1}{1+1} \\
    P(X = Head) = 0.5
```

Similarly, calculating mathematical probabilities may help us answer more complex questions like, given our Finance data, We may want to use Probability or likelihood of best possible return from given amount invested in certain investment group/category.

**Let's review one example.**

|Category | ROI (%) |
--- | --- |
|A|3|
|B|5|
|C|4|
|D|2|

```@example
using UnicodePlots, DataFrames, Latexify; # hide
df = DataFrame(cateogry=["A", "B", "C", "D"], ROI=[3,5,4,2]) # hide
ROI_by_InvestmentGroup = UnicodePlots.barplot(df.cateogry, df.ROI, xlabel = "ROI (%)", ylabel = "Category", title="ROT by Investment group") # hide
ROI_by_InvestmentGroup
```

above data/figure shows, Category B has maximum ROI.
Assuming, one Mutual Fund belongs to only one category,
probability of getting maximum ROI on a given fund is `0.25`.

```math
    f = Number of favorable Outcomes \\
    T = Total number of outcomes \\
    P(X = maxROI) = \frac{f}{T} \\
    P(X = maxROI) = \frac{P(C)}{P(A)+P(B)+P(C)+P(D)} \\
    P(X = maxROI) = \frac{1}{1+1+1+1} \\
    P(X = maxROI) = 0.25
```

## Sample space

---
All set of possible set of outcomes of an experiment is the sample space.

let's assume, given there are 4 possible directions (``North``, ``South``, ``East``, ``West``).

- Probability of person walking in North Direction is `1/4`. Given Sample space (``North``, ``South``, ``East``, ``West``).

```math
    P(X = N) = \frac{f}{T} \\
    P(X = N) = \frac{P(N)}{P(N)+P(S)+P(E)+P(W)} \\
    P(X = N) = \frac{1}{1+1+1+1} \\
    P(X = N) = 0.25
```

- Probability of person walking in ``North``(ish) Direction is `3/8`. Given Sample space is `(N, NE, NW, S, SE, SW, E, W)`.

```math
    P(X = N(ish)) = \frac{f}{T} \\
    P(X = N(ish)) = \frac{P(N)+P(NE)+P(NW)}{P(N)+P(S)+P(E)+P(W)+P(NE)+P(NW)+P(SW)+P(SE)} \\
    P(X = N(ish)) = \frac{1+1+1}{1+1+1+1+1+1+1+1} \\
    P(X = N(ish)) = \frac{3}{8}
```
`Determining statistical probability accurately depends on context and sample space.`

```@eval
using CairoMakie;

tblA = (direction=["N","S","E","W"],
        prob=repeat([1/4], inner=4));
tblB = (direction=["N","S","E","W","NE","NW","SE","SW"],
        prob=repeat([1/8], inner=8));

fig = Figure(backgroundcolor=:white, resolution=(600,400),
    fonts = (; regular= "Sans Serif"));
axa = Axis(fig[1,1], xlabel="distributions", ylabel="probability",
    xgridvisible=false, ygridvisible=true, ygridstyle = :dash,
    xticks = (1:length(tblA.prob), tblA.direction), xticklabelrotation=pi/3,
    limits=(0,5,0,0.3),
    title="Probability Distribution");
axb = Axis(fig[1,2], xlabel="distributions",
    xgridvisible=false, ygridvisible=false, ygridstyle = :dash,
    xticks = (1:length(tblB.prob), tblB.direction), xticklabelrotation=pi/3,
    limits=(0,9,0,0.3),
    yticksvisible=false,
    title="Probability Distribution");

barplot!(axa, tblA.prob, label = "Sample Space 4", color=(:dodgerblue, 0.5), strokewidth=0.5);
barplot!(axb, tblB.prob, label = "Sample Space 8", color=(:orange, 0.5), strokewidth=0.5);
axislegend(axa, position=:cb);
axislegend(axb);

save("prob.png", fig)
nothing

```

![](prob.png)

**Application:** As seen in above examples, We can apply similar concepts in our given finance data set. For example, given outcome ROI, which group one Mutual Fund belongs to, and further, what is the likelihood of maximum profit given stocks in included in Fund.

Keep in mind, in above examples, Sample space and possible outcomes are in finite in numbers and hence are considered as discrete probability functions. Later sections, we will see continuous probability distributions which often have infinite outcomes.

## Probability axioms

---

- The probability of occurrence of any event lies between 0 and 1.
    ``P(X) \in (0,1)``
- The sum of all the probabilities of outcomes should be equal to 1.
    ``P(\Omega) = 1``
- For mutually exclusive events, sum of probabilities is equal to sum of individual event probabilities.
    ``P\left(\bigcup _{i=1}^{\infty }E_{i}\right)=\sum _{i=1}^{\infty }P(E_{i}).``

## Probability consequences

---

- The probability of occurrence of any event lies between 0 and 1.
    ``P(X) \in (0,1)``
- The sum of all the probabilities of outcomes should be equal to 1.
    ``P(\Omega) = 1``
- For mutually exclusive events, sum of probabilities is equal to sum of individual event probabilities.
    ``P\left(\bigcup _{i=1}^{\infty }E_{i}\right)=\sum _{i=1}^{\infty }P(E_{i})``

## Probability Distributions Functions (PDFs)

---
Probability Distribution functions (referred as PDFs), not to be confused with Probability density function (PDF),
is the mathematical function that gives the probabilities of occurrence of different possible outcomes for an experiment. It is a mathematical description of a random phenomenon in terms of its sample space and the probabilities of events (subsets of the sample space).

```math
    PDFs \Rrightarrow
    \left[\begin{array}{c}
        Discrete \Leftrightarrow PMF \\
        Continuous \Leftrightarrow PDF
    \end{array}\right]
    \Rrightarrow 
    CDF
```

!!! info "what's the point of learning PDFs"
    just to keep reader and objective of this tutorials aligned, the whole reason, we are learning about probability distributions is, it helps us visualize data in terms of "central or distributed" tendency and/or estimating an event or point of interest in terms of maximum likelihood of occurrence.

## Probability Mass Function (PMF)

## Probability Density Function (PDF)

## Cumulative Density Function (CDF)

Probability density/mass functions (pdf) and their logarithm (logpdf)

---

So far, we have seen examples of simple, compound interest certificate deposit types.
Now let's dig in deeper and move onto another type of deposit types, i.e. Mutual Funds, stocks, options equity etc.

Before we jump on to more advance Machine learning training, model and predictive analytics, let's spend time on statistical analysis and visualizing probability distributions of data first.

Above analysis is the key to machine learning and predictive analytics. Understanding below statistical concepts lay strong foundations for ML/DL modeling later on.

In this section, we will focus on performing Univariate analysis on Mutual fund data, as you can see in below data sample, that rate type, compound interest type does't impact MF performance, in this dataset, outcome depends on only one variable, "Group Type".

!!! info
    Once we get a hang of analyzing data on one variable, later we will introduce more variables like MF Type, contents, market type etc.
    Then in later section, we will train our neural network on multiple inputs.

In this example below, we will work on datasets from GeneralLedger.jl package in following steps.

- first draw one million data samples from GeneralLedger.jl package
- groupby data by deposit type
- filter data to include only Mutual Funds

```julia
using GeneralLedger, DataFrames, Statistics;
sampleSize = 1000000;
df = GeneralLedger.getSampleDepositsData(sampleSize);
subset!(df, :deposit => x -> contains.(x, "MF"));

dfG = groupby(df, [:rate]);
combine(dfG, nrow, proprow, groupindices, :Total => mean => :mean, :Total => std => :std);
# dfA = subset(df, :rate => x -> isequal.(x, "Group A"));

show(first(dfA,5)) # show first 5 rows

describe(dfA.Total) # describe stats

dfC = combine(dfG, nrow, proprow, groupindices, :Total => mean => :mean, :Total => std => :std);
show(first(dfC,5)) # show first 5 rows
```

```@eval
using GeneralLedger, CairoMakie, DataFrames, Statistics, Latexify;
sampleSize = 1000000;
df = GeneralLedger.getSampleDepositsData(sampleSize);
subset!(df, :deposit => x -> contains.(x, "MF"));
mdtable(first(df, 5), latex=false)

dfG = groupby(df, [:rate]);
combine(dfG, nrow, proprow, groupindices, :Total => mean => :mean, :Total => std => :std)

select!(df, :, :Interest => (x -> round.(x, digits=2)) => :Interest, :Total => (x -> round.(x, digits=2)) => :Total)

mdtable(first(df, 10), latex=false)

```

- as you can see, above data set is divided in 4 groups and each group has different type of outcomes.
- we will assume, these groups have further characteristics, which lead them to produce outcome in certain ranges.
- for example, Group A invests in certain types of equities which performed better or worse than others.
- however, with in a group, outcome are somewhat consistent (like in certain range).
- abnormal distribution with in one certain group is another topic for detail analysis.
- in later sections, we will only focus on doing analytics at one group level.
- let's visualize groups altogether.

```@eval
using GeneralLedger, CairoMakie, DataFrames, Statistics;

sampleSize = 10000;
df = GeneralLedger.getSampleDepositsData(sampleSize);
subset!(df, :deposit => x -> contains.(x, "MF"));
sort!(df, [:rate]);
dfG = groupby(df, [:rate]);
dfC = combine(dfG, nrow, proprow, groupindices, :Total => mean => :mean, :Total => std => :std);

fig = Figure(backgroundcolor=:lightgrey, resolution=(600,600), fonts = (; regular = "CMU Serif"));
axFBP = Axis(fig[1,1], title="Rows, Stats by Mutual Fund Group", xlabel="MF Groups", xgridvisible=false,
xticklabelrotation=pi/3, yticklabelrotation=pi/3, xticks = (1:4, dfC.rate));
plt = CairoMakie.barplot!(axFBP, dfC.groupindices, dfC.nrow,
        stack = dfC.nrow,
        color = [:green, :yellow, :purple, :orange],
        label = "Row Distributions");
CairoMakie.lines!(axFBP, dfC.groupindices, dfC.mean/100,
        stack = convert.(Int64, round.(dfC.mean/100)),
        color = convert.(Int64, round.(dfC.mean/100)),
        label = "mean (in 100s)");
CairoMakie.scatterlines!(axFBP, dfC.groupindices, dfC.std/4,
        label = "std (in 250s)" );
axislegend(position = :ct);

ax = Axis(fig[2,1], title="\$100k = 10k MF samples in 100 bins", xlabel="Total \$ (in 100k)",
         ylabel="Distributions")
density!(ax, subset(df, :rate => x -> isequal.(x, "Group A")).Total./1000,
        npoints = 100, color = (:green, 0.3),
strokecolor = :green, strokewidth = 3, strokearound = true, label="Group A")
density!(ax, subset(df, :rate => x -> isequal.(x, "Group B")).Total./1000,
        npoints = 100, color = (:yellow, 0.3),
strokecolor = :yellow, strokewidth = 3, strokearound = true, label="Group B")
density!(ax, subset(df, :rate => x -> isequal.(x, "Group C")).Total./1000,
        npoints = 100, color = (:purple, 0.3),
strokecolor = :purple, strokewidth = 3, strokearound = true, label="Group C")
density!(ax, subset(df, :rate => x -> isequal.(x, "Group D")).Total./1000,
        npoints = 100, color = (:orange, 0.3),
strokecolor = :orange, strokewidth = 3, strokearound = true, label="Group D")
axislegend(position=:rt)

save("group_data.png", fig)
nothing
```

![Distributions Graphs](group_data.png)

as you can see in above graphs, Group A has largest population and has greatest means as well. Meaning, given 100k investment, overall ROI can be anywhere between 120-180k. Standard deviation in results are very high as range 120-180 on 100k original amount is very wide.

Similarly, Group B, Group C follow Group A in ROI.
Group D has second largest population but is worse performing, and most of the time, ROI is less then 100k, which is under performing and losing investment anywhere from 40-50k.



## Distributions

---

## Normal Gaussian, Binomial, Poisson, Exponential

---

## Mean, median, mode, average, weighted average, EWA

## p value, quantile, quartile

## standard deviation, Correlation, covariance

## moments, entropy, skewness, kurtosis, entropy

notes

## regression is another blog with optimization

linear regression, what is linear regression, GLM etc. refer to statistics data science math topics

## CLT - Central limit Theorem

---

`as per wikipedia'
In probability theory, the central limit theorem (CLT) establishes that, in many situations, when independent random variables are summed up, their properly normalized sum tends toward a normal distribution even if the original variables themselves are not normally distributed.

The theorem is a key concept in probability theory because it implies that probabilistic and statistical methods that work for normal distributions can be applicable to many problems involving other types of distributions.