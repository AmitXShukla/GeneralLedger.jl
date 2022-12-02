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
            departureTime=rand(0600:100:2200, sampleSize),
            distance=fill(400, sampleSize)
        ), dfVehicle, on=:vehicleID)
    select!(dfTimeTaken, [:1, :5, :2, :3, :6, :4, :7], [:distance, :speed, :bias] => ByRow((x1, x2, x3) -> (x1 / x2) + (x3 / 60)) => "timeTaken")
end

"""
    getSampleFigFunctions()
Call this function to produce sample graph showing Discrete and Continuous function examples.
"""
function getSampleFigFunctions(fileName::string="functions.png")
    x = 0:5:100
    f = Figure(backgroundcolor=:orange, resolution=(600, 400))
    ax1 = Axis(f[1, 1], title="Discrete Function", xlabel="x", ylabel="y")
    ax2 = Axis(f[1, 2], title="Continuous Function", xlabel="x", ylabel="y")
    scatter!(ax1, x, x .+ 12)
    lines!(ax2, x, sin.(x))
    # f # uncomment this to see when figure when running online
    save(fileName, f)
end