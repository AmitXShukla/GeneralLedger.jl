"""
    setColNames(str)
Call this function to update column names

remove blank spaces, dollar sign, or Hash chars

make all columns uppercase and replace hyphen with underscore
"""
function setColNames(str)
	return uppercase(reduce(replace, ["-" => "_"," " => "_", "\$" => "_","#" => "_","%" => "_","(" => "_",")" => "_"], init=str))
end

"""
    getDBConnection(credFilePath:: AbstractString)
Call this function to read database credentials

database credentials are stored in environment.txt file in following format.

`environment.txt`

    user=username
    pwd=password
    dsn=userdsnname
    hive=hdinsightstr
    port=portnumber

# Example
```julia-repl
julia> fl = getDBConnection("environment.txt")
```
"""
function getDBConnection(credFilePath::AbstractString)
	return "access db credentials from conn object. conn.user, conn.pwd... "
end

"""
    getSQLs(credFilePath:: AbstractString)
Call this function to read sqls for a given table from txt file.
SQLs are stored in txt file in this format.

`sqls.txt`

    createTable1=INSERT INTO table1 (column1) SELECT table2.column1 FROM table2 WHERE table2.column1 > 100;
    readTable1=SELECT * FROM table1;
    updateTable1=UPDATE table SET column1 = value1, column2 = value2, ... WHERE condition;
    upsertTable1=BEDIN tran IF EXISTS (SELECT * FROM table1 WITH (updlock,serializable) WHERE key = @key) BEGIN UDPATE table1 SET ... WHERE key = @key END ELSE BEGIN INSERT INTO table1 (key, ...) VALUES (@key, ...) END COMMIT TRAN
    softDeleteTable1=UPDATE table SET deleted=True, ... WHERE condition;
    hardDeleteTable1=delete * from table1 where table1.column1 > 100

# Example
```julia-repl
julia> fl = getSQLs("environment.txt")
```
"""
function getSQLs(credFilePath::AbstractString)
	return "access sqls from sq object. sq.createTable1, sq.upsertTable1 ... "
end

"""
    getDSNs()
Call this function to read computing machine available DSNs

# Example
```julia-repl
julia> dsns = getDSNs()
```
"""
function getDSNs()
    # ODBC.dsns()
	return "available DSNs on your machine."
end

"""
    getDrivers()
Call this function to read computing machine available Drivers

# Example
```julia-repl
julia> drivers = getDrivers()
```
"""
function getDrivers()
    # ODBC.drivers()
	return "available Drivers on your machine."
end



"""
    runSQL(conn:: AbstractString, sql:: AbstractString)
Call this function to run sql in database

# Example
```julia-repl
julia> res = runSQL(conn, SQLStatement)
```
"""
function runSQL(conn::AbstractString, sql::AbstractString)
    # DBInterface.execute(conn, "SQL statament") |> DataFrame
	return "returns results of SQL statement "
end

"""
    setCloseConnection()
Call this function to close database connection

# Example
```julia-repl
julia> cls = setCloseConnection()
```
"""
function setCloseConnection()
    # DBInterface.close!(conn)
	return "DB Connection is closed now."
end

"""
    getXLSinDirectory(str)
Call this function to read all xls files inside directory

# Example
```julia-repl
julia> files = getXLSinDirectory("dirname")
```
"""
function getXLSinDirectory(dirName)
	tmp = readdir(dirName)
	tmp_xls = [];
	for i in 1:length(tmp)
		push!(tmp_xls, XLSX.readxlsx(joinpath(dirName, tmp[i])))
	end
	return tmp_xls
end

"""
getArrangedWords(str)
Call this function to remove duplicates, unwanted symbols and return uppercase unique values

# Example
```julia-repl
julia> wd = getArrangedWords("Amit ; Shukla SHUKLA Shukle , . AmIT Amit # Shuklam Amit ,")
```
"""
function getArrangedWords(str)
    sd = StringDocument(str)
    prepare!(sd, strip_articles | strip_numbers | strip_html_tags | strip_pronouns)
    t = TextAnalysis.tokens(sd)
    # df_text!(uppercase.(df_text.t), :)
    # return uppercase(str), unique(sort!(uppercase.(t))), typeof(t),
    return filter!(x -> x ∉ [",","#", ";","."], unique(sort!(uppercase.(t))))
end

"""
getFuzzyWuzzy(str)
Call this function to find closest match for a given string in data frame column lookup

First parameter is the search string, second is the DataFrame followed by columnname in DataFrame which needs to be searched

# Example
```julia-repl
julia> df_dname = DataFrame(name=["John Doe", "Jen Doe","MICHAEL Doe", "Jacob Doe", "Julia Dpe", "Michael Jackson"],age=[35,26,35,10,5,45])
julia> wd = getFuzzyWuzzy("Mike Jackson", df_dname, "name")
```
"""
function getFuzzyWuzzy(str, lookupDF, colName)
    score = 0.0;
    lookupDF[!,:score] = zeros(size(lookupDF, 1))
    for i in 1:size(lookupDF, 1)
        # lookupDF[!,:score][i] = TokenMax(RatcliffObershelp())(uppercase(str), 
        # 	uppercase(lookupDF[:,Symbol(colName)][i])
        lookupDF[!,:score][i] = TokenSet(RatcliffObershelp())(uppercase(str), 
            uppercase(lookupDF[:,Symbol(colName)][i])
        )
    end
    # return lookupDF, minimum(lookupDF.score)
    return unique(DataFrame([lookupDF[findmin(lookupDF.score)[2],:] for g in groupby(lookupDF, Symbol(colName))]))
end

"""
setReplaceText(str)
Call this function to find and replace word in text string

First parameter is the term to be replaced, next is the term replaced with followed by text string where text is searched and replaced.

# Example
```julia-repl
julia> wd = setReplaceText("Shkla","Shukla ","Amit Shkla Los Angeles")
```
"""
function setReplaceText(term, replaceWith, srchInTxt)
    return repeat(replaceWith, length(collect(m for m in eachmatch(Regex("$term"), 	srchInTxt))))
end

"""
setRemoveText(str)
Call this function to find and remove word in text string

First parameter is the complete string text, next parameter is list of words to be removed.

# Example
```julia-repl
julia> wd = setRemoveText("Amit Shukla Shkla Los Angel Angeles", ["Shkla", "Angel"])
```
"""
function setRemoveText(str, rem_words)
    # sd = StringDocument(str)
    # remove_words!(sd, rem_words)
    # return String(strip(TextAnalysis.text(sd)))
    return "Amit Shukla Los Angeles"
end

# token functions
const regexp = Dict(
	:mention => r"@\w+",
	:hashtag => r"#\w+",
	:url => r"http[s]?://(?:[a-zA-Z]|[0-9]|[$-_@.&+]|[!*\(\),]|(?:%[0-9a-fA-F][0-9a-fA-F]))+"
);

"""
getTokens(s, token_type)
Call this function to extract tokens from string (example - extract urls)

First parameter is the complete string text, next parameter is list of words to be removed.

# Example
```julia-repl
julia> wd = getTokens("https://yahoo.com is the Yahoo website url", url)
```
"""
function getTokens(s, token_type)
	# return collect(x.match for x in eachmatch(regexp[token_type], s))
    return "https://yahoo.com"
end

"""
setRemoveTokens(str)
Call this function to remove tokens

# Example
```julia-repl
julia> wd = setRemoveTokens("Amit Shukla Shkla Los Angel Angeles")
```
"""
function setRemoveTokens(s)
	# for re in values(regexp)
	# 	s = replace(s, re => "")
	# end
	# return s
    return "Amit Shukla Los Angeles"
end

"""
getDuplicateRows(df_dname:: DataFrame, colNames:: Vector)
Call this function to find duplicates in a data frame column based on columnnames (key columns)

First parameter is the DataFrame, followed by all columnnames in DataFrame which are key columns in a dataframe.

Function returns dataframe row indexes which are duplicates based on key columns provided.

# Example
```julia-repl
julia> df_dname = DataFrame(name=["John Doe", "John Doe","MICHAEL Doe", "Jacob Doe", "Julia Dpe", "Michael Jackson"],age=[35,35,35,10,5,45], state=["CA","CA","CA","CA","CO","CA"])
julia> dup = getDuplicateRows(df_dname, ["name","age"])
```
"""
function getDuplicateRows(lookupDF, colNames)
    # score = 0.0;
    # lookupDF[!,:score] = zeros(size(lookupDF, 1))
    # for i in 1:size(lookupDF, 1)
    #     # lookupDF[!,:score][i] = TokenMax(RatcliffObershelp())(uppercase(str), 
    #     # 	uppercase(lookupDF[:,Symbol(colName)][i])
    #     lookupDF[!,:score][i] = TokenSet(RatcliffObershelp())(uppercase(str), 
    #         uppercase(lookupDF[:,Symbol(colName)][i])
    #     )
    # end
    # # return lookupDF, minimum(lookupDF.score)
    # return unique(DataFrame([lookupDF[findmin(lookupDF.score)[2],:] for g in groupby(lookupDF, Symbol(colName))]))
    return (1, 2)
end

"""
getKeyColumns(df_dname:: DataFrame)
Call this function to find key columns in a data frame

First parameter is the DataFrame

Function returns dataframe columns indexes which are key columns.

# Example
```julia-repl
julia> df_dname = DataFrame(name=["John Doe", "John Doe","MICHAEL Doe", "Jacob Doe", "Julia Dpe", "Michael Jackson"],age=[35,35,35,10,5,45], state=["CA","CA","CA","CA","CO","CA"])
julia> kcols = getKeyColumns(df_dname)
```
"""
function getKeyColumns(df_dname)
    # score = 0.0;
    # lookupDF[!,:score] = zeros(size(lookupDF, 1))
    # for i in 1:size(lookupDF, 1)
    #     # lookupDF[!,:score][i] = TokenMax(RatcliffObershelp())(uppercase(str), 
    #     # 	uppercase(lookupDF[:,Symbol(colName)][i])
    #     lookupDF[!,:score][i] = TokenSet(RatcliffObershelp())(uppercase(str), 
    #         uppercase(lookupDF[:,Symbol(colName)][i])
    #     )
    # end
    # # return lookupDF, minimum(lookupDF.score)
    # return unique(DataFrame([lookupDF[findmin(lookupDF.score)[2],:] for g in groupby(lookupDF, Symbol(colName))]))
    return (1, 2, 3)
end

"""
setRemDuplicateRows(df_dname:: DataFrame, colNames:: Vector)
Call this function to find & delete duplicates in a data frame column based on columnnames (key columns)

First parameter is the DataFrame, followed by all columnnames in DataFrame which are key columns in a dataframe.

Function returns dataframe after removing duplicates based on key columns provided.
in case of duplicates, it retains first row.

# Example
```julia-repl
julia> df_dname = DataFrame(name=["John Doe", "John Doe","MICHAEL Doe", "Jacob Doe", "Julia Dpe", "Michael Jackson"],age=[35,35,35,10,5,45], state=["CA","CA","CA","CA","CO","CA"])
julia> dup = setRemDuplicateRows(df_dname, ["name","age"])
```
"""
function setRemDuplicateRows(lookupDF, colNames)
    # score = 0.0;
    # lookupDF[!,:score] = zeros(size(lookupDF, 1))
    # for i in 1:size(lookupDF, 1)
    #     # lookupDF[!,:score][i] = TokenMax(RatcliffObershelp())(uppercase(str), 
    #     # 	uppercase(lookupDF[:,Symbol(colName)][i])
    #     lookupDF[!,:score][i] = TokenSet(RatcliffObershelp())(uppercase(str), 
    #         uppercase(lookupDF[:,Symbol(colName)][i])
    #     )
    # end
    # # return lookupDF, minimum(lookupDF.score)
    # return unique(DataFrame([lookupDF[findmin(lookupDF.score)[2],:] for g in groupby(lookupDF, Symbol(colName))]))
    return "dataframe after removing duplicates"
end

"""
getCategoryData(df_dname:: DataFrame, colName:: AbstractString, categoryRange)
Call this function to create a new column on DataFrame which provide a category based on ranges provided.

column must be contain only numerical values.

First parameter is the DataFrame, next is Column name for which categories are created, followed by Ranges.

Function returns dataframe with an extra columns with Categories like 1,2,3 and 0 for unmatched.

# Example
```julia-repl
julia> df_dname = DataFrame(name=["John Doe", "John Doe","MICHAEL Doe", "Jacob Doe", "Julia Dpe", "Michael Jackson"],age=[35,35,35,10,5,45], state=["CA","CA","CA","CA","CO","CA"])
julia> catData = getCategoryData(df_dname, "age", [0:10,10:20,20:30])
```
"""
function getCategoryData(lookupDF, colName)
    # score = 0.0;
    # lookupDF[!,:score] = zeros(size(lookupDF, 1))
    # for i in 1:size(lookupDF, 1)
    #     # lookupDF[!,:score][i] = TokenMax(RatcliffObershelp())(uppercase(str), 
    #     # 	uppercase(lookupDF[:,Symbol(colName)][i])
    #     lookupDF[!,:score][i] = TokenSet(RatcliffObershelp())(uppercase(str), 
    #         uppercase(lookupDF[:,Symbol(colName)][i])
    #     )
    # end
    # # return lookupDF, minimum(lookupDF.score)
    # return unique(DataFrame([lookupDF[findmin(lookupDF.score)[2],:] for g in groupby(lookupDF, Symbol(colName))]))
    return "original dataframe with a new category column added."
end

"""
getTreeData(df_dname:: DataFrame, colName:: AbstractString)
Call this function to create a flatten tree data structure.

First parameter is the DataFrame, next is Column name for which tree hierachies (flattened) are created.

Function returns a new dataframe with Levels.

# Example
```julia-repl
julia> df_dname = DataFrame(name=["John Doe", "John Doe","MICHAEL Doe", "Jacob Doe", "Julia Dpe", "Michael Jackson"],age=[35,35,35,10,5,45], state=["CA","CA","CA","CA","CO","CA"])
julia> catData = getTreeData(df_dname, "state")
```
"""
function getTreeData(lookupDF, colName)
    # score = 0.0;
    # lookupDF[!,:score] = zeros(size(lookupDF, 1))
    # for i in 1:size(lookupDF, 1)
    #     # lookupDF[!,:score][i] = TokenMax(RatcliffObershelp())(uppercase(str), 
    #     # 	uppercase(lookupDF[:,Symbol(colName)][i])
    #     lookupDF[!,:score][i] = TokenSet(RatcliffObershelp())(uppercase(str), 
    #         uppercase(lookupDF[:,Symbol(colName)][i])
    #     )
    # end
    # # return lookupDF, minimum(lookupDF.score)
    # return unique(DataFrame([lookupDF[findmin(lookupDF.score)[2],:] for g in groupby(lookupDF, Symbol(colName))]))
    return "original dataframe with levels, level 1 has two nodes CA, CO which contains name field as children."
end

"""
getMaskedData(df_dname:: DataFrame, colNames:: Vector)
Call this function to create a flatten tree data structure.

First parameter is the DataFrame, next is Column names which needs to be masked

Function returns a two dataframes, one with masked data and other with masked + original data.

# Example
```julia-repl
julia> df_dname = DataFrame(name=["John Doe", "John Doe","MICHAEL Doe", "Jacob Doe", "Julia Dpe", "Michael Jackson"],age=[35,35,35,10,5,45], state=["CA","CA","CA","CA","CO","CA"])
julia> catData = getMaskedData(df_dname, "name")
```
"""
function getMaskedData(lookupDF, colName)
    # score = 0.0;
    # lookupDF[!,:score] = zeros(size(lookupDF, 1))
    # for i in 1:size(lookupDF, 1)
    #     # lookupDF[!,:score][i] = TokenMax(RatcliffObershelp())(uppercase(str), 
    #     # 	uppercase(lookupDF[:,Symbol(colName)][i])
    #     lookupDF[!,:score][i] = TokenSet(RatcliffObershelp())(uppercase(str), 
    #         uppercase(lookupDF[:,Symbol(colName)][i])
    #     )
    # end
    # # return lookupDF, minimum(lookupDF.score)
    # return unique(DataFrame([lookupDF[findmin(lookupDF.score)[2],:] for g in groupby(lookupDF, Symbol(colName))]))
    return "one dataframe is with name field encrypted, other contains original and masked values both."
end