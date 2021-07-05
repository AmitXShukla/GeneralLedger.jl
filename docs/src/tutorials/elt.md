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
Normally, we ingest all vendor tables/transactions into a Date warehouse or Data lake or any self-service environment, and then let SMEs run meaningful analytics on it.
instead,
Lets first define a Vendor DataType and then build ELT or ETL operations on it.
This simple concept will age your data to fine gold and SME will be able to do self-service analytics with worrying too much learning data structure and entity relationships.

Another example is, 
Instead of loading all your accounting data into RDBMS tables,
developers take time to pre-define an accounting Data Structure such as JOURNALS, LEDGER, ACCOUNTINGLINES, CHARTFIELDs and HIERARCHY data types, then ELT data into these Data Structures and push it to the reporting database.
This will lead to a much powerful driverless self-service live reporting/ predictive analytics environment.

In the following sections, we will discuss ELT & ELT strategies.

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

#### file download

**download a simple file from a website, FTP location**
```@repl
# let's download Apple INC Q2 2021 SEC Filing document
# downloading from website
# download(url::AbstractString, [path::AbstractString = tempname()]) -> path

fl = download("https://s2.q4cdn.com/470004039/files/doc_financials/2021/q2/FY21-Q2-Consolidated-Financial-Statements.pdf");
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
# use this code, to read all links from a txt file and download each file one by one
using Pkg
Pkg.add(url="https://github.com/AmitXShukla/GeneralLedger.jl")
using GeneralLedger
autoPullFiles("c:\\amit.la\\file_name.txt")
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

#### RDBMS
connecting to Oracle, MY SQL or MS SQL Server

#### HIVE
connecting to Oracle, MY SQL or MS SQL Server

#### JSON, XML
working with JSON, XML like files and parsing data

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
# after you download, open a terminal window & browe to directory where chromedrive.exe is location and run
# chromedriver.exe --url-base=/wd/hub
# above command will start a chrome webdriver session on port 9515
# if you see an error below, that's because I didn't provide correct path to find chromedriver.exe file

wdrvCommand = `chromedriver.exe --url-base=/wd/hub`
run(wdrvCommand)
```

**web crawl & web scraping**

```@repl
using Pkg
Pkg.add(url="https://github.com/AmitXShukla/GeneralLedger.jl")
using GeneralLedger
# Call this function to crawl through a web page and download all file links
# first parameter is webpage url, next parameter is list of all file extensions user wish to download followed by output directory path
getWebLinks("https://investor.apple.com/investor-relations/default.aspx#tabs_content--2021", ["pdf","csv","xlsx","xls"], "downloads/web")
```
---

## Load

Now once data is identified, we will need a storage system, typically a database, data warehouse or data lake to keep data.
Before loading into a Target system, let's work on our load strategy.

Think of these scenarios you will be dealing after data is loaded.

- simple excel files first row will be used as RDBMS table names. Often, RDBMS will change column headers and this will be a challenge to map with original excel files each time a newer file is downloaded.
- you dont want to fetch the same file if it already exists in the local/hadoop directory.
- in case of RDBMS, you may want to mark each record with CRUD date (when a row was first created, updated and read. You may never want to hard delete a row, and just do a soft delete instead to hide from the user's view).

---

## Transform
What seems hardest, is the easiest part to deal with. Once a correct dataset is read and loaded into the system. There are several transformation techniques and tools available.

In ELT like environments, Transformation is mostly done on Analytical tool, like Microsoft Power BI, Tableau, Oracle Analytics are extremely powerful and provide out of the box transformation techniques.

However, here are some useful scripts, which can be run on local environment for data cleansing.
These scripts are extremely powerful when dealing with extreme large Big data sets.

- removing unwanted chars in columns headers or rows.
- removing duplicates
- removing missing, NA
- replacing chars/ strings
- categorizing data
- creating Hierarchy, Tree like dimensional structure

---

## ETL Data warehouse

Lets discuss how to create a Data warehouse like structure while ETL- extracting, loading and transforming data into a Data warehouse structure for faster ad-hoc self service star-schema like reporting.

---
## ELT Data lake

Lets discuss how to create a Data lake like structure for faster ad-hoc self service star-schema like reporting.