module GeneralLedger
# current release: v0.18
#     next planned release: v0.20 Aug 27, 2023.
#     Please do NOT download source code until v0.20 release.

#     !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
#     !!! source code will available v0.20 Aug 27, 2023 !!!
#     !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
using Base: Downloads
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
# using CUDA
using Dates
using CairoMakie
using Distributions

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
include("Samples/datasets.jl")

export getWebLinks, getFile, getPullFiles, getJSONintoDataFrame, getXMLintoDataFrame
export setColNames, getXLSinDirectory, getArrangedWords, getFuzzyWuzzy, getTokens, setRemoveTokens, setRemoveText, setReplaceText
export getDuplicateRows, getKeyColumns, setRemDuplicateRows, getCategoryData, getTreeData, getMaskedData
export getDBConnection, getDSNs, getDrivers, getSQLs, setCloseConnection, runSQL
export account, department, location, costcenter, operunit, ledger
export Deposit, getSampleBDeposit
export getSampleDataTimeTaken, getSampleFigFunctions, getSampleDataDeposits
end