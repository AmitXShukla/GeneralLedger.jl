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
    getFile(url::AbstractString, downloadPath:: AbstractString)
Call this function to download a file
    
first parameter is webpage url, next parameter is output directory path including file name

# Example
```julia-repl
julia> fl = getFile("https://s2.q4cdn.com/470004039/files/doc_financials/2021/q2/FY21-Q2-Consolidated-Financial-Statements.pdf", "<folder_name>/test.csv")
```
"""
function getFile(url::AbstractString, downloadPathWithFileName::AbstractString)
	download(url, downloadPathWithFileName)
end

"""
    getPullFiles(path::AbstractString)
Call this function to read urls in local txt files line by line, and download each file

# Example
```julia-repl
julia> fl = getPullFiles("c:\amit.la\filename.txt")
```
"""
function getPullFiles(path::AbstractString)
    # source code release date Aug 20, 2021
	return "Download complete"
end

"""
    getJSONintoDataFrame(path::AbstractString)
Call this function to read json file from url and retrieve results into DataFrame

first parameter is webpage url, next parameter is output directory path

# Example
```julia-repl
julia> df = getJSONintoDataFrame("https://api.coindesk.com/v1/bpi/currentprice.json", "downloads/web")
```
"""
function getJSONintoDataFrame(url::AbstractString, downloadPath::AbstractString)
    # source code release date Aug 20, 2021
	return "Download complete"
end

"""
    getXMLintoDataFrame(path::AbstractString)

Call this function to read XML file from url and retrieve results into DataFrame

first parameter is webpage url, next parameter is output directory path
# Example
```julia-repl
julia> df = getXMLintoDataFrame("https://api.coindesk.com/v1/bpi/currentprice.json", "downloads/web")
```
"""
function getXMLintoDataFrame(url::AbstractString, downloadPath::AbstractString)
    # source code release date Aug 20, 2021
	return "Download complete"
end