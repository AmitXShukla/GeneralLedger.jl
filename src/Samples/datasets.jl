"""
    getSampleDataTimeTaken(sampleSize::Int64=10)
Call this function to produce sample datasets showing Timetaken by vehicles.

Time taken to travel between two cities via Air, Bus, Train or personal vehicle depends mostly depends on speed and distance. 
However, there are other factors like weather, season, population or faults, which may occasionally impact travel time.
However, knowing intensity of these factors, it's still possible to predict time taken rationally.

There are many assumptions when calculating Time taken, 
like, Passenger needs to travel to bus, train station or time to get ready, wait time etc. is not reflected here.
Let's capture these assumptions as in column "bias" for now.
    
"""
function getSampleDataTimeTaken(sampleSize::Int64=10)
    sampleSize = sampleSize < 5 ? 5 : sampleSize
    dfVehicle = DataFrame(
        vehicleID=1:5,
        vehicle=["new car", "old bus", "train", "jetpack", "UFO"],
        speed=[75, 58, 95, 999, 1999],
        bias=[0, 0.2, 0.4, 99, 199])
    dfTimeTaken = innerjoin(DataFrame(
            vehicleID=rand(dfVehicle.vehicleID, sampleSize),
            season=rand(["summer", "winter", "fall", "rain"], sampleSize),
            departure=rand(0600:100:2200, sampleSize),
            distance=fill(400, sampleSize)
        ), dfVehicle, on=:vehicleID)
    select!(dfTimeTaken, [:5, :2, :3, :6, :4, :7], [:distance, :speed, :bias] => ByRow((x1, x2, x3) -> (x1 / x2) + (x3 / 60)) => "ETA")
end

"""
    getSampleFigFunctions(fileName::String="functions.png")
Call this function to produce sample graph showing Discrete and Continuous function examples.
"""
function getSampleFigFunctions(fileName::String="functions.png")
    x = 0:5:100
    f = Figure(backgroundcolor=:orange, resolution=(600, 400))
    ax1 = Axis(f[1, 1], title="Discrete Function", xlabel="x", ylabel="y")
    ax2 = Axis(f[1, 2], title="Continuous Function", xlabel="x", ylabel="y")
    scatter!(ax1, x, x .+ 12)
    lines!(ax2, x, sin.(x))
    # f # uncomment this to see when figure when running online
    save(fileName, f)
end

"""
    Deposit{T}
    defines a data structure for deposit calculations
"""
mutable struct Deposit{T}
    principal::T
    rate::T
    compound::T
    time::T
end

"""
    getSampleBDeposit(bd:: Deposit)
    
    Call this function to calculate simple yearly interest.
        principal::T # =10000 # Principal amount
        rate::T # =3.875  Rate of Interest
        compound::T # compound frequency - Daily=365, Monthly=12, Qtr=4, Annually=1
        time::T # number of deposit months

    function getSampleBDeposit(d) # buddy deposit
        P = d.principal
        n = d.compound # simple interest calculated per year
        r = d.rate/100;
        t = d.time/12;
        return P * (1 + (r * t) / n) - P, P * (1 + (r * t) / n) # interest, total
    end
"""
function getSampleBDeposit(d::Deposit) # buddy deposit
    P = d.principal
    # n = d.compound # simple interest calculated per year
    n = 1 # simple interest calculated per year
    r = d.rate / 100
    t = d.time / 12
    return P * (1 + (r * t) / n) - P, P * (1 + (r * t) / n) # interest, total
end

"""
    getSampleBD(P, r, n, t)
    Call this function to calculate simple yearly interest.

    P::Int64=10000 # Principal amount
    r::Float64=3.875 # Rate of Interest
    n::Int64=1, # compound frequency - Daily=365, Monthly=12, Qtr=4, Annually=1
    t::Int64=60 # number of deposit months

    function getSampleBD(P, r, n, t) # buddy deposit
        n =1 # simple interest calculated per year
        r = r/100;
        t = t/12;
        return P, P * (1+(r*t)/n)
    end
"""
function getSampleBD(P, r, n, t) # buddy deposit
    n = 1 # simple interest calculated per year
    r = r / 100
    t = t / 12
    return P * (1 + (r * t) / n) - P, P * (1 + (r * t) / n) # interest, total
end

"""
    getSampleCD(P, r, n, t)
    Call this function to calculate accumulated compound interest.

    P::Int64=10000 # Principal amount
    r::Float64=3.875 # Rate of Interest
    n::Int64=1, # compound frequency - Daily=365, Monthly=12, Qtr=4, Annually=1
    t::Int64=60 # number of deposit months

    function getSampleCD(P, r, n, t) # certificate deposit
        r = r/100;
        t = t/12;
        return P, P * (1+r/n) ^ (n*t)
    end
"""
function getSampleCD(P, r, n, t) # certificate deposit
    r = r / 100
    t = t / 12
    return P * (1 + r / n)^(n * t) - P, P * (1 + r / n)^(n * t)# interest, total
end

"""
    getSampleRD(P, r, n, t)
    Call this function to calculate Random Interest return.

    P::Int=10000 # Principal amount
    r::Float64=3.875 # Rate of Interest
    n::Int=1, # compound frequency - Daily=365, Monthly=12, Qtr=4, Annually=1
    t::Int=60 # number of deposit months

    function getSampleRD(P, r, n, t) # random deposit
        return P, P * (1+randn())
    end
"""
function getSampleRD(P, r, n, t) # random deposit
    x = rand(-0.51:0.02:0.99)
    return P * (1 + x) - P, P * (1 + x) # interest, total
end

"""
getSampleDataDeposits(sampleSize::Int64=10, P::Int64=10000, r::Float64=3.875, n::Int=1, t::Int=60)
Call this function to produce sample datasets showing deposits.

please see, this function generate only sample data with bias (intentionally biased and wrong, so that a pattern can be analyzed)
and must not be used for any real calculations.

sampleSize::Int64=10 # number of rows generated
P::Int64=10000 # Principal amount
r::Float64=3.875 # Rate of Interest
n::Int=1, # compound frequency - Daily=365, Monthly=12, Qtr=4, Annually=1
t::Int=60 # number of deposit months
    
"""
function getSampleDataDeposits(sampleSize::Int64=10, P::Int64=10000, r::Float64=3.875, n::Int=1, t::Int=60)
    sampleSize = sampleSize < 5 ? 5 : sampleSize
    dfDP = DataFrame(deposit=["buddy"], amount=P, ROI=r, time=t, rate=["simple"], compound=[1])
    push!(dfDP, ["CD", P, r, t, "daily", 365])
    push!(dfDP, ["CD", P, r, t, "monthly", 12])
    push!(dfDP, ["CD", P, r, t, "qtr", 4])
    push!(dfDP, ["CD", P, r, t, "annual", 1])
    for i in 1:sampleSize-5
        push!(dfDP, [string("MF-", i), P, 0.00, t, string("assignGroup"), 1])
    end

    dfDeposit = select!(dfDP, :,
        [:deposit, :compound] => ByRow((x1, x2)
        ->
            x1 == "buddy" ? getSampleBD(P, r, x2, t) :
            x1 == "CD" ? getSampleCD(P, r, x2, t) : getSampleRD(P, r, x2, t)
        ) => ["Interest", "Total"]
    )
    dfDeposit = select!(dfDP, :,
        [:rate, :Interest, :amount] => ByRow((x1, x2, x3)
        ->
            x1 == "assignGroup" ? (x2 * 100) / x3 >= 35 ? "Group A" :
                                  (x2 * 100) / x3 >= 15 < 35 ? "Group B" :
                                  (x2 * 100) / x3 >= 0 < 15 ? "Group C" : "Group D"
            : x1
        ) => :rate
    )
    return dfDeposit
end