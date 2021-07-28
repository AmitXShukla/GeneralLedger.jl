module GeneralLedger
# current release: v0.18
#     next planned release: v0.20 Aug 27, 2021.
#     Please do NOT download source code until v0.20 release.

#     !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
#     !!! source code will available v0.20 Aug 27, 2021 !!!
#     !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
using Base:Downloads
using Documenter
using DataFrames
using HTTP
using JSON3
using ODBC
using CSV
using XLSX
using TextAnalysis
using TimeSeries
using Flux
using CUDA

abstract type Ledger end
abstract type SubLedger end
abstract type AccountingLines end
abstract type LedgerType end
abstract type Account end
abstract type Department end
abstract type Location end
abstract type OrgEntity end
abstract type CostCenter end
abstract type Vendor end
abstract type Item end
abstract type Payables end
abstract type Receivable end
abstract type PurchaseOrder end

include("ELTs/elt.jl")
include("ELTs/web.jl")
include("ELTs/dbstructs.jl")

export getWebLinks, getFile, getPullFiles, getJSONintoDataFrame, getXMLintoDataFrame
export setColNames, getXLSinDirectory
export getDBConnection, getDSNs, getDrivers, getSQLs, setCloseConnection, runSQL
export account, department, location, costcenter, operunit, ledger

end