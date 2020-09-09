Data Loading
############

Objective
^^^^^^^^^
In this section, We will discuss, different ways to read, store different kinds of Data.

In real world, most of Big/small Organizations use ERP Systems like SAP, Oracle, PeopleSoft, Intuit, MS SQL/Access/SQL Server etc. to store Summary, Detail & Sub Ledgers in ERP systems. These ERP systems store Giga/Peta Bytes of GL data in RDBMS tables and mostly in highly structured data format.

using Python
^^^^^^^^^^^^

1. NumPy, Pandas DataFrame is one of the recommended way to load and read CSV, XLSX or Website data.
2. VAEX, PyTables or PYSPARK are few other recommended approaches to store high volume, highly structured data.

using Julia
^^^^^^^^^^^
1. Julia DataFrame is one of the recommended way to load and read CSV, XLSX or Website data.
2. JuliaDB is other approach recommended to store high volume, highly structured data.

using CSV
^^^^^^^^^
.. content-tabs::

    .. tab-container:: Python
        :title: Python

        .. code-block:: Python
            :linenos:

            import numpy as np
            import pandas as pd
            df = DataFrame(a=3, b=5)
            df.a
            df[:,:a]

    .. tab-container:: Julia
        :title: Julia

        .. code-block:: Julia
            :linenos:

            using Pkg           # load Pkg
            Pkg.add("CSV")      # add CSV package
            using CSV           # load CSV
            df = CSV.           # hit TAB to see all available methods
            
            # before you jump on loading CSV file, always count rows in CSV.

            (open("./Ledger.csv") |> readlines |> length) -1 # use readlines if file is clean format
            
            function rowcountcsv(file)    # write a generic funciton to readlines in a file (not so clean files)
                rowCount = 0
                for row in CSV.Rows(file; resusebuffer=true)
                    rowCount += 1
                end
                return rowCount
            end
            
            rowcountcsv("./Ledger.csv") # count # of lines in CSV

            # OMG, you don't want to print 100,000 lines from a big CSV file, but if you do...
            for row in CSV.File("./Ledger.csv")
                println("a=$(row.a), b=$(row.b), c=$(row.c)")
            end

            #### APPROACH - 1 ####
            #### let's load this CSV into a DataFrame ####
            using DataFrames
            df = CSV.File("./Ledger.csv") |> DataFrame!

            #### APPROACH - 2 ####
            # load a csv file directly into an sqlite database table
            using Pkg
            Pkg.add("SQLite")
            db = SQLite.DB()
            tbl = CSV.File("./Ledger.csv") |> SQLite.load!(db, "ledger_table")

            #### APPROACH - 3 ####
            #### loading data into JuliaDB ####
            using Pkg
            Pkg.add("JuliaDB")
            Pkg.add("Distributed")
            Pkg.add("OnlineStats")

            using JuliaDB
            using Distributed
            using OnlineStats
            addprocs(4)

            @everywhere using JuliaDB, OnlineStats
            files = glob("*.csv", "Ledger") # load all csvs at once in directory

            t = loadtable(files, filenamecol=:DBLedger) #DBLedger becomes one of column in this table
            groupreduce(Mean(), t, :DBLedger; select=:BALANCE) # assuming Ledger.csv has a column BALANCE


using DOWNLOAD
^^^^^^^^^^^^^^

using XLSX
^^^^^^^^^^

using ODBC
^^^^^^^^^^

using JDBC
^^^^^^^^^^

using HIVE
^^^^^^^^^^

using Website
^^^^^^^^^^^^^