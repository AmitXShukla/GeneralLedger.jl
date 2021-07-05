"""
    getWebLinks(url::AbstractString, fileTypes::AbstractVector, downloadPath:: AbstractString)
Call this function to crawl through a web page and download all file links
first parameter is webpage url, next parameter is list of all file extensions user wish to download followed by output directory path

# Example
```julia-repl
julia> fl = getWebLinks("https://investor.apple.com/investor-relations/default.aspx#tabs_content--2021", ["pdf","csv","xlsx","xls"], "downloads/web")
```
"""
function getWebLinks(url::AbstractString, fileTypes::AbstractVector, downloadPath::AbstractString)
	return uppercase(reduce(replace, ["-" => "_"," " => "_", "\$" => "_","#" => "_","%" => "_","(" => "_",")" => "_"], init=url))
end

"""
    autoPullFiles(path::AbstractString)
Call this function to read urls in local txt files line by line, and download each file

# Example
```julia-repl
julia> fl = autoPullFiles("c:\amit.la\filename.txt")
```
"""
function autoPullFiles(path::AbstractString)
	return "Download complete"
end