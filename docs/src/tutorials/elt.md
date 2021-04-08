# ELT vs ETL.jl

ETL Data Warehouse vs ELT Data Lake debate, is like vim vs emacs, linux vs windows never ending discussions.

It means different things and may represent different concepts, but end of the day leads to one conclusion.

*Data is a mineral, if you handle it with care and delicacy, polish and move it to a fine safe enclosure, it will age as fine gold.* - Amit Shukla

In the following lessons, we will discuss different strategies to Extract, Transform, Load data from different sources to different enclosures.

**Why this package?**
There are a dozen ETL/ELT and Data warehouse/ Data lake solutions available in the market today. All of them are extremely capable of extraction, load and transforming almost any type of data structure like structured, un-structured, binary, BLOB, sound, image or simple text in large quantities.

``` This package neither challenges or aims to build anything different. ```
.
Instead, this package will use existing RDBMS, DataLakes, or Document databases available in the market.

This package should be seen as providing a DataType environment, where we can first understand and define subject data structure, then do ELT operations on it.
This is what I meant earlier by saying handle with care and delicacy.

``` Inheriting behavior is much more important than being able to inherit structure.```

Just to give an example,
Normally, we ingest all vendor tables/transactions into a Date warehouse or Data lake or any self-service environment, and then let SMEs run meaningful analytics on it.
instead,
Lets first define a Vendor DataType and then build ELT or ETL operations on it.
This simple concept will age your data to fine gold and SME enjoy back seat ride on driverless AI.

Another example is, 
Instead of loading all your accounting data into RDBMS tables,
developers take time to pre-define an accounting Data Structure such as JOURNALS, LEDGER, ACCOUNTINGLINES, CHARTFIELDs and HIERARCHY data types, then ELTdata into these Data Structures and push it to the reporting database.
This will lead to a much powerful driverless self-service live reporting/ predictive analytics environment.

In the following sections, we will discuss ELT & ELT strategies.

---

## Extract

Data Extraction from a known source is simple, the difficult part is, automating to fetch data on pre-defined schedules. Further, almost impossible task is, identify deltas on every single data extract execution and fetch only changed datasets.

In this lesson, we will see different strategies to extract different types of data.

**Stage or not to stage: **
keeping an original copy of data into a local/hadoop directory or storing the first original copy in RDBMS tables brings extra benefit to your Analytics.
You will always be able to go back in time and restore from originals, however, it also brings unmanageable clutter, junk and storage costs.

Before trying to read data from source, you must think, how would you want to use it in near future.

You can store the original copy as-is to a directory or RDBMS table.
This works well, when you are dealing with txt, image files. Storage is cheaper than computing.

for example
- consider storing a copy of the *APPL SEC Balance sheet filing PDF* from the internet rather than building NLP AI to read certain dollar amounts or quantities from a PDF.
Your AI scripts will bill more for compute hours than storing a few extra KBs.

- on contrast, reading 5 lines from 5000 pages PDF, doesn't justify the need to store the entire document. Instead, use a web crawler or good OCR or text reader AI-bot to fetch data that is meaningful to you.


- while reading data from a RDBMS, consider using a *where last_update_date > last_run_date* to fetch only deltas.

``` storing <last_run_date> will be discussed in *LOAD* section later. ```


#### automating data pull
In this section, we will build a simple script and automate to run it on certain schedules.

#### file download
In this section, We will download a simple file from a website, FTP or hadoop location.

#### web crawler
using Selenium and webdriver.jl to crawl the web, search & load data from the website.

#### RDBMS
connecting to Oracle, MY SQL or MS SQL Server

#### JSON, XML
working with JSON, XML like files and parsing data

## Load

Now once data is identified, we will need a storage system, typically a database, data warehouse or data lake to keep data.
Before loading into a Target system, let's work on our load strategy.

Think of these scenarios you will be dealing after data is loaded.

- simple excel files first row will be used as RDBMS table names. Often, RDBMS will change column headers and this will be a challenge to map with original excel files each time a newer file is downloaded.
- you dont want to fetch the same file if it already exists in the local/hadoop directory.
- in case of RDBMS, you may want to mark each record with CRUD date (when a row was first created, updated and read. You may never want to hard delete a row, and just do a soft delete instead to hide from the user's view).

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

## ETL Data warehouse

Lets discuss how to create a Data warehouse like structure while ETL- extracting, loading and transforming data into a Data warehouse structure for faster ad-hoc self service star-schema like reporting.



