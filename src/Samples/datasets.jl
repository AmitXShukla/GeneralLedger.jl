"""
    getSampleDataTimeTaken(str)
Call this function to produce sample datasets

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
    transform!(dfTimeTaken, [:distance, :speed] => ByRow((x1, x2) -> x1 / x2) => "timeTaken")
end