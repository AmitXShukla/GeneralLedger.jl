# ELT vs ETL.jl

ETL Data Warehouse vs ELT Data Lake debate, is like vim vs emacs, linux vs windows never ending discussions.

It means different things and may represent different concepts, but end of the day leads to one conclusion.

*Data is a mineral, if you handle it with care and delicacy, polish and move it to a fine safe enclosure, it will age as fine gold.* 
```@raw html
<font color=brown><b> Amit Shukla</b></font>
<br>
```
In this lesson, we will discuss different strategies to Extract, Transform, Load data from different sources to different enclosures.
You will find examples to address different type of extract, data pull strategies with code.

**Why this package?**
There are a dozen ETL/ELT and Data warehouse/ Data lake solutions available in the market today. All of them are extremely capable of extraction, load and transforming almost any type of data structure like structured, un-structured, binary, BLOB, sound, image or simple text in large quantities.

``` This package neither challenges or aims to build anything different. ```
Instead, this package will use existing RDBMS, DataLakes, or Document databases available in the market.

This package should be seen as providing a DataType environment, where we can first understand and define subject data structure, then do ELT operations on it.
This is what I meant earlier by saying handle with care and delicacy.

``` Inheriting behavior is much more important than being able to inherit structure.```

Just to give an example,
Normally, we ingest all vendor tables/transactions into a Data warehouse or Data lake or any self-service environment, and then let SMEs run meaningful analytics on it.
instead,
Lets first define a Vendor DataType and then build ELT or ETL operations on it.
This simple concept will age your data to fine gold and SME will be able to do self-service analytics with worrying too much learning data structure and entity relationships.

Another example is, 
Instead of loading all your accounting data into RDBMS tables,
developers take time to pre-define an accounting Data Structure such as JOURNALS, LEDGER, ACCOUNTINGLINES, CHARTFIELDs and HIERARCHY data types, then ELT data into these Data Structures and push it to the reporting database.
This will lead to a much powerful driverless self-service live reporting/ predictive analytics environment.

In the following sections, we will discuss few ETL & ELT strategies.

---

## Extract

Data Extraction from a known source is easy, tough part is, automating to fetch data on pre-defined schedules. Further, most difficult task is to identify deltas on every single data row during extract execution and pull/push only changed datasets.

**Stage or not to stage:**
keeping an original copy of data into a local/hadoop directory or storing the first original copy in RDBMS tables brings extra benefit to your Analytics.
You will always be able to go back in time and restore from originals, however, it also brings unmanageable clutter, junk and storage costs.

Before trying to read data from source, you must think, how would you want to use it in near future.

You can store the original copy as-is to a directory or RDBMS table.
This works well, when you are dealing with txt, image files. Storage is cheaper than computing.

for example
- consider storing a copy of the *APPL SEC Balance sheet filing PDF* from the internet rather than building NLP AI to read certain dollar amounts or quantities from a PDF.
Your AI scripts will bill more for compute hours than storing a few extra KBs.

on the other hand, reading 5 lines from 5000 pages PDF, doesn't justify the need to store the entire document. Instead, use a web crawler, good OCR or text reader AI-bot to fetch data that is meaningful to you.

- while reading data from a RDBMS, consider using a *where last_update_date > last_run_date* to fetch only deltas.

``` storing <last_run_date> will be discussed in LOAD section later. ```

Let's look into few example used to extract different type of data.

#### add GeneralLedger.jl package

```@repl
# first, add GeneralLedger.jl package to your environment
using Pkg
Pkg.add(url="https://github.com/AmitXShukla/GeneralLedger.jl")
```

#### file download

**download a simple file from a website, FTP location**
```@repl
# let's download Apple INC Q2 2021 SEC Filing document
# downloading from website
# download(url::AbstractString, [path::AbstractString = tempName()]) -> path
using GeneralLedger
fl = getFile("https://s2.q4cdn.com/470004039/files/doc_financials/2021/q2/FY21-Q2-Consolidated-Financial-Statements.pdf", "FY21-Q2-Consolidated-Financial-Statements.pdf");
filesize(fl)
```

**download using curl/wget**
```@repl
# let's download Apple INC Q2 2021 SEC Filing document
# downloading using curl/wget
# wrap system commands (curl or wget) inside backticks

downloadFileCommand = `curl https://s2.q4cdn.com/470004039/files/doc_financials/2021/q2/FY21-Q2-Consolidated-Financial-Statements.pdf --output apple_q2-21-10Q.pdf`
run(downloadFileCommand)
```

#### [automating data pull](@id auto_data_pull)
In this section, we will build a simple script, which reads input (urls) file, and downloads all files.

*to scrap all available links from webpage tinto a local txt file, see [Web crawl & Web Scraping](@ref web_crawl) section below.*
```@repl
# use this code, to read all links from a txt file 
# and download each file one by one
using GeneralLedger
getPullFiles("c:\\amit.la\\file_name.txt")
```
#### scheduling automated data pull
In this section, we will learn different options to automate data pull scripts to run on recurring schedule.

First and preferred option is, user can setup a cron job on Linux or powershell script on windows.

    # setup a Linux cron job
    crontab -e
    # minute hour day-of-month month day-of-week command
    0 10 * * * Julia autopull.jl

and if you must do this in Julia, second option is to use native Julia Lang sleep, timer or scheduler functions.
```@repl
# code credit - discourse.julialang.org thread
result = nothing
done = false
while !done
    try 
        result = # invoke function that may fail
        done = true
    catch e
        sleep(86400)  # sleep for 1 day(=86400 seconds) before restarting
     end
end
```

#### RDBMS, HIVE
connecting to Oracle, MY SQL or MS SQL Server

In this section, below are few examples showing, how to connect to RDBMS SQL databases using ODBC.jl package.

Please see, user can directly use ODBC.jl package instead of GeneralLedger.jl wrapper functions as shown below.
GeneralLedger.jl created this wrapper functions just to enforce and implement standard community guidelines and best practices.

For example
    - It's not a good idea to pass Database credentials to functions directly, instead, credentials should be kept in separate environment file.
    - Similarily, keeping SQLs in xls/txt file is better than using variable to hold SQLs.

First create a txt file to hold database credentials and make sure DSN are already created in computing environment.

`environment.txt`

    user=username
    pwd=password
    dsn=userdsnname
    hive=hdinsightstr
    port=portnumber

```@repl
using GeneralLedger
getDSNs()
getDrivers()
```

Next create txt file(s) to hold database SQLs.

`sqls.txt`

    createTable1=INSERT INTO table1 (column1) SELECT table2.column1 FROM table2 WHERE table2.column1 > 100;
    readTable1=SELECT * FROM table1;
    updateTable1=UPDATE table SET column1 = value1, column2 = value2, ... WHERE condition;
    upsertTable1=BEDIN tran IF EXISTS (SELECT * FROM table1 WITH (updlock,serializable) WHERE key = @key) BEGIN UDPATE table1 SET ... WHERE key = @key END ELSE BEGIN INSERT INTO table1 (key, ...) VALUES (@key, ...) END COMMIT TRAN
    softDeleteTable1=UPDATE table SET deleted=True, ... WHERE condition;
    hardDeleteTable1=delete * from table1 where table1.column1 > 100


```@repl
using GeneralLedger, DataFrames
conn = getDBConnection("environment.txt")
sql = getSQLs("sqls.txt")
df = runSQL(conn, sql.readTable1) |> DataFrame

```
when you are done with SQLs, don't forget to close DB connection.

#### close DB Connections

```@repl
using GeneralLedger
setCloseConnection()
```

*using ODBC to insert data into RDBMS may be very slow operation, see below LOAD section for other methods/strategies to load bulk data.*

#### JSON
```@repl
# use this code, to download BITCOIN market price into a dataframe
# and download data in csv format
using GeneralLedger
df = getJSONintoDataFrame("https://api.coindesk.com/v1/bpi/currentprice.json", "downloads/web")
```

#### XML

```@repl
# use this code, to download XML into a dataframe
# and download data in csv format
using GeneralLedger
df = getXMLintoDataFrame("https://www.clinicaltrials.gov/ct2/results/rss.xml?rcv_d=14&lup_d=&sel_rss=new14&cond=Coronavirus&count=10000", "downloads/web")
```

---

## [Web crawl & Web Scraping](@id web_crawl)
We just looked at examples, how to download file(s) from website or FTP locations. However in some case, you may not know how many files are available for download.

In this example below, we will use this GeneralLedger.jl function, which crawl through Apple INC SEC Filing web page (or any webpage), reads HTML and identify all PDF/XLSX or CSV files downloadable links.

We will store these links into csv file and this file can be used in [automating data pull](@ref auto_data_pull), to automatically download all files at once.

**start a webdriver session**
```@repl
# you must have a valid webdriver session running on your machine
# download a valid chromedriver version on your machine from this link
# https://chromedriver.chromium.org/downloads (may vary)
# after you download, open a terminal window & browe to directory
# where chromedrive.exe is location and run
# chromedriver.exe --url-base=/wd/hub
# above command will start a chrome webdriver session on port 9515

wdrvCommand = `chromedriver.exe --url-base=/wd/hub`
# if you see an error below, that's because I didn't provide correct path
# to find chromedriver.exe file
run(wdrvCommand)
```

**web crawl & web scraping**

```@repl
# Call this function to crawl through a web page and download all file links
# first parameter is webpage url, next parameter is list of all file extensions
# where user wish to download followed by output directory path
using GeneralLedger
getWebLinks("https://investor.apple.com/investor-relations/default.aspx#tabs_content--2021", ["pdf","csv","xlsx","xls"], "downloads/web")
```

GeneralLedger `getWebLinks` function fetches and store these links into csv file, which is used in [automating data pull](@ref auto_data_pull), to automatically download all files at once.

---

## Load

Now once data is identified, we will need a storage system, typically a database, data warehouse or data lake to keep data.
Before loading into a Target system, let's work on our load strategy.

Think of these scenarios you will be dealing after data is loaded.

- simple excel files first row will be used as RDBMS table names. Often, RDBMS will change column headers and this will be a challenge to map with original excel files each time a newer file is downloaded.
- you dont want to fetch the same file if it already exists in the local/hadoop directory.
- in case of RDBMS, you may want to mark each record with CRUD date (when a row was first created, updated and read. You may never want to hard delete a row, and just do a soft delete instead to hide from the user's view).

using ODBC to load BULK data could be very slow operations, instead Cloud data upload strategies are highly recommended to move data.

For Example, using Oracle, Google or Azure cloud storage systems could be easier option to load huge datasets into RDBMs.

[Google Cloud SQL upload strategy](https://cloud.google.com/sql/docs/mysql/import-export/importing)

[Oracle Cloud upload strategy](https://docs.oracle.com/en/database/oracle/machine-learning/oml4py/1/mlpug/push-data-to-database.html#GUID-C50C0D37-C057-43CE-BE4B-750E52865E2C)

`TODO: will update this section to show case how to use Julia to upload Big Data into cloud databases.`

First, we will create few METADAT tables to store LOAD information.

Ideally, These METADATA tables should be stores in Target system database, however, just to showcase, data LOAD Strategy, in this case, We will use `JULIADB` to capture TABLES LOAD METADATA information.

#### [METADATA tables](@id meta_data_table)

`METADATA.LOADTIME`
This table is used to store information related to each table METADATA.
Everytime, after Data is Extracted and loaded into Target Database, these METADATA tables must be updated.

    name=tablename
    sor=source_system_name
    author=source_system_userid
    updateAt=lastupddttm

`METADATA.DATE_BASED_CDC` create One METADATA file per table.
This table is used to store information related to each table read from source through a date based `CDC (Change data capture)` logic.
and next time, same date is used to pull incremental data from source system.

For example, - 
`SELECT * FROM sourceDB.table1 WHERE sourceDB.table1.updateDttm > JULIADB.METADATA.DATE_BASED_CDC.table1.incrementDt`

Everytime, after Data is Extracted and loaded into Target Database, these METADATA tables must be updated.

    name=tablename
    sor=source_system_name
    author=source_system_userid
    updateAt=lastupddttm
    incrementDt=max_updateDt_at_source # Leave blank in case of KEYs based CDC
    sid=maxDourrogateID # unique numerical identifier per row, used in ETL Datawarehouse.
                        # Leave blank is case of ELT Data lake

`METADATA.KEYS_BASED_CDC` create One METADATA file per table.
This table is used to store information related to each table read from source through a date based `CDC (Change data capture)` logic.
and next time, same date is used to pull incremental data from source system.

For example, - 
`SELECT [key_columns] FROM sourceDB.table1 <MATCH> JULIADB.METADATA.DATE_BASED_CDC.table1.key1..2..3 => INSERT / UPDATE / UPSERT`

Everytime, after Data is Extracted and loaded into Target Database, these METADATA tables must be updated.

    key1=primarykey
    key2=primarykey
    key3=primarykey
    author=source_system_userid
    createAt=currentdttm # do not update this, in case of an update
    updateAt=currentdttm
    sid=maxDourrogateID # unique numerical identifier per row, used in ETL Datawarehouse.
                        # Leave blank is case of ELT Data lake

```@repl
using GeneralLedger
getDSNs()
getDrivers()
```

---

## Transform
What seems hardest, is the easiest part to deal with. Once a correct dataset is read and loaded into the system. There are several transformation techniques and tools available.

In ELT like environments, Transformation is mostly done on Analytical tool, like Microsoft Power BI, Tableau, Oracle Analytics are extremely powerful and provide out of the box transformation techniques.

However, here are some useful scripts, which can be run on local environment for data cleansing.
These GeneralLedger.jl data cleansing/tranformation funcitons are extremely powerful when dealing with extreme large Big data sets.

- read all xls files from a directory `getXLSinDirectory`
- removing unwanted chars in columns headers or rows `setColNames`
- arrange words (remove unwanted chars, sort and return uppercase) `getArrangedWords`
- FuzzyWuzzy - finds closest match for a given string in data frame column `getFuzzyWuzzy`
- removing missing, NA, Tokens `getTokens`, `setRemoveTokens`
- removing words `setRemoveText`
- replacing text `setReplaceText`
- identifying duplicates `getDuplicateRows`
- identifying key columns in dataset `getKeyColumns`
- removing duplicates `setRemDuplicateRows`
- categorizing data `getCategoryData`
- creating Hierarchy, Tree like dimensional structure `getTreeData`
- creating synthetic/masked reversible data (produces two files, one with masked data and original with masked data) `getMaskedData`

```@repl
using GeneralLedger, DataFrames
# getXLSinDirectory
# read all xls files from a directory
getXLSinDirectory(".")

# setColNames
# Call this function to remove not-compatible SQL columns chars
setColNames("Amit Sh-ukla # \$")

# getArrangedWords
# Call this function to remove duplicates, unwanted symbols and return uppercase unique values
wd = getArrangedWords("Amit ; Shukla SHUKLA Shukle , . AmIT Amit # Shuklam Amit ,")

# getFuzzyWuzzy
# Call this function to find closest match for a given string in data frame column lookup
# First parameter is the search string, second is the DataFrame followed by columnname in DataFrame which needs to be searched
df_dname = DataFrame(name=["John Doe", "Jen Doe","MICHAEL Doe", "Jacob Doe", "Julia Dpe", "Michael Jackson"],age=[35,26,35,10,5,45])
wd = getFuzzyWuzzy("Mike Jackson", df_dname, "name")

# getTokens
# Call this function to extract tokens from string (example - extract urls)
# First parameter is the complete string text, next parameter is list of words to be removed.
wd = getTokens("https://yahoo.com is the Yahoo website url", url)

# setRemoveTokens
# Call this function to remove tokens
wd = setRemoveTokens("Amit Shukla Shkla Los Angel Angeles")

# setRemoveText
# Call this function to find and remove word in text string
# First parameter is the complete string text, next parameter is list of words to be removed.
wd = setRemoveText("Amit Shukla Shkla Los Angel Angeles", ["Shkla", "Angel"])

# setReplaceText
# Call this function to find and replace word in text string
# First parameter is the term to be replaced, next is the term replaced with followed by text string where text is searched and replaced.
wd = setReplaceText("Shkla","Shukla ","Amit Shkla Los Angeles")

# getDuplicateRows
# Call this function to find duplicates in a data frame column based on columnnames (key columns)
df_dname = DataFrame(name=["John Doe", "John Doe","MICHAEL Doe", "Jacob Doe", "Julia Dpe", "Michael Jackson"],age=[35,35,35,10,5,45], state=["CA","CA","CA","CA","CO","CA"])
dup = getDuplicateRows(df_dname, ["name","age"])

# getKeyColumns
# Call this function to find key columns in a data frame
df_dname = DataFrame(name=["John Doe", "John Doe","MICHAEL Doe", "Jacob Doe", "Julia Dpe", "Michael Jackson"],age=[35,35,35,10,5,45], state=["CA","CA","CA","CA","CO","CA"])
kcols = getKeyColumns(df_dname)

# setRemDuplicateRows
# Call this function to find & delete duplicates in a data frame column based on columnnames (key columns)
df_dname = DataFrame(name=["John Doe", "John Doe","MICHAEL Doe", "Jacob Doe", "Julia Dpe", "Michael Jackson"],age=[35,35,35,10,5,45], state=["CA","CA","CA","CA","CO","CA"])
dup = setRemDuplicateRows(df_dname, ["name","age"])

# getCategoryData
# Call this function to create a new column on DataFrame which provide a category based on ranges provided.
df_dname = DataFrame(name=["John Doe", "John Doe","MICHAEL Doe", "Jacob Doe", "Julia Dpe", "Michael Jackson"],age=[35,35,35,10,5,45], state=["CA","CA","CA","CA","CO","CA"])
catData = getCategoryData(df_dname, "age", [0:10,10:20,20:30])

# getTreeData(df_dname:: DataFrame, colName:: AbstractString)
# Call this function to create a flatten tree data structure.
df_dname = DataFrame(name=["John Doe", "John Doe","MICHAEL Doe", "Jacob Doe", "Julia Dpe", "Michael Jackson"],age=[35,35,35,10,5,45], state=["CA","CA","CA","CA","CO","CA"])
catData = getTreeData(df_dname, "state")

# getMaskedData(df_dname:: DataFrame, colNames:: Vector)
# Call this function to create a flatten tree data structure.
df_dname = DataFrame(name=["John Doe", "John Doe","MICHAEL Doe", "Jacob Doe", "Julia Dpe", "Michael Jackson"],age=[35,35,35,10,5,45], state=["CA","CA","CA","CA","CO","CA"])
catData = getMaskedData(df_dname, "name")
```

---

## ETL Data warehouse

Lets discuss how to create a Data warehouse like structure while ETL- extracting, loading and transforming data into a Data warehouse structure for faster ad-hoc self service star-schema like reporting.

We discussed several different ways to extract and load data into the system.
To create an ETL Datawarehouse, 

A Star schema DIMENSION table is created, where each row must include a SID (Surrogate ID), i.e. a unique identifier available for numerical joins and

A Star Schema FACT table is created on primary transaction tables, where, every chartfield/dimention lookup/refernce field, does a look-up on DIMENSION table to get DIMENSION.SID value.

please refer to [LOAD](@ref meta_data_table) section, METADATA tables structure and look for a field SID.

after data is extracted from source system, each row is appended with a unique SID value. 

For example, - 
`INSERT INTO table1.sid VALUES sid = (SELECT MAX(SID) FROM JULIADB.METADATA.DATE_BASED_CDC.table1.sid + 1)`

Everytime, after Data is Extracted and loaded into Target Database, these METADATA tables must be updated.

---
## ELT Data lake

Lets discuss how to create a Data lake like structure for faster ad-hoc self service star-schema like reporting.

To create an ELT Data Lake kind of structure, SID values are optional. Instead, system prefer to perform BULK INSERT or UPDATE.
ELT Data Lakes are also easier to create TYPE 2 Dimensions/Facts tables. (Where history is retained).

For example - 

`new rows => INSERT INTO table1 values (SELECT 'active_row=1', table1.* FROM source.table1)`

`update rows => UPDATE table1 SET active_row=0 WHERE rows = <updated rows>`

`update rows => INSERT INTO table1 values (SELECT 'active_row=1', table1.* FROM source.table1)`