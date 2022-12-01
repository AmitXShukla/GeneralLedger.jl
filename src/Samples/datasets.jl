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
function getSampleDataTimeTaken(str)
    return DataFrame(Vehicle=["new car", "old bus", "train", "jetpack"],
        weather="sunny",
        season="summer",
        time="1400",
        weekday=1,
        speed=60,
        distance=400,
        bias=[0, 0.2, 0.4, -]
    )
end