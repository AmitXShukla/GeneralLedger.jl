module GeneralLedger

using Documenter
using DataFrames

# using CSV
# using XLSX
# using ODBC

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

export fixColNames, getWebLinks, autoPullFiles

end