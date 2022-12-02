"""
    getSampleDataTimeTaken(str)
Call this function to produce sample datasets showing Timetaken by vehicles.

Time taken to travel between two cities via Air, Bus, Train or personal vehicle depends mostly depends on speed and distance. 
However, there are other factors like weather, season, population or faults, which may occasionally impact travel time.
However, knowing intensity of these factors, it's still possible to predict time taken rationally.

There are many assumptions when calculating Time taken, 
like, Passenger needs to travel to bus, train station or time to get ready, wait time etc. is not reflected here.
Let's capture these assumptions as in column "bias" for now.
    
"""
function getSampleDataTimeTaken(sampleSize=10::Int8)
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
    getSampleFigFunctions()
Call this function to produce sample graph showing Discrete and Continuous function examples.
"""
function getSampleFigFunctions(fileName="functions.png"::string)
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
    getSampleBD(P, r, n, t)
    Call this function to calculate simple yearly interest.

    P=10000::Int64 # Principal amount
    r=3.875::Float64 # Rate of Interest
    n=1::Int8, # compound frequency - Daily=365, Monthly=12, Quarterly=4, Annually=1
    t=60::Int8 # number of deposit months

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
    return P, P * (1 + (r * t) / n)
end

"""
    getSampleCD(P, r, n, t)
    Call this function to calculate accumulated compound interest.

    P=10000::Int64 # Principal amount
    r=3.875::Float64 # Rate of Interest
    n=1::Int8, # compound frequency - Daily=365, Monthly=12, Quarterly=4, Annually=1
    t=60::Int8 # number of deposit months

    function getSampleCD(P, r, n, t) # certificate deposit
        r = r/100;
        t = t/12;
        return P, P * (1+r/n) ^ (n*t)
    end
"""
function getSampleCD(P, r, n, t) # certificate deposit
    r = r / 100
    t = t / 12
    return P, P * (1 + r / n)^(n * t)
end

"""
    getSampleRD(P, r, n, t)
    Call this function to calculate Random Interest return.

    P=10000::Int64 # Principal amount
    r=3.875::Float64 # Rate of Interest
    n=1::Int8, # compound frequency - Daily=365, Monthly=12, Quarterly=4, Annually=1
    t=60::Int8 # number of deposit months

    function getSampleRD(P, r, n, t) # random deposit
        return P, P * (1+randn())
    end
"""
function getSampleRD(P, r, n, t) # random deposit
    return P, P * (1 + randn())
end

"""
getSampleDataDeposits(;sampleSize=10::Int8, P=10000::Int64, r=3.875::Float64, n=1::Int8, t=60::Int8)
Call this function to produce sample datasets showing deposits.

please see, this function generate only sample data with bias (intentionally biased and wrong)
and must not be used for any real calculations.

sampleSize=10:Int8 # number of rows generated
P=10000::Int64 # Principal amount
r=3.875::Float64 # Rate of Interest
n=1::Int8, # compound frequency - Daily=365, Monthly=12, Quarterly=4, Annually=1
t=60::Int8 # number of deposit months
    
"""
function getSampleDataDeposits(; sampleSize=10::Int8, P=10000::Int64, r=3.875::Float64, n=1::Int8, t=60::Int8)
    dfDP = DataFrame(deposit=["buddy"], principal=P, ROI=r, time=t, intType=["Simple"], compound=[1])
    push!(dfDP, ["certificate", P, r, t, "daily", 365])
    push!(dfDP, ["certificate", P, r, t, "monthly", 12])
    push!(dfDP, ["certificate", P, r, t, "quarterly", 4])
    push!(dfDP, ["certificate", P, r, t, "annual", 1])
    for i in 1:sampleSize-5
        push!(dfDP, [string("MutualFund-", i), P, 0.99, t, "-", 1])
    end

    dfDeposit = select!(dfDP, :,
        [:deposit, :compound] => ByRow((x1, x2)
        ->
            x1 == "buddy" ? getSampleBD(P, r, x2, t) :
            x1 == "certificate" ? getSampleCD(P, r, x2, t) : getSampleRD(P, r, x2, t)
        ) => ["Interest", "Total"]
    )
    return dfDeposit
end