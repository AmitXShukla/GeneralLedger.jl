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
Call this function to finds closest match for a given string in data frame column lookup

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
