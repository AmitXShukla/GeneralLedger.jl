# Self Service Analytics
In the previous chapter, we learned how to extract, load and transform data.
Often, ERP system use RDBMS database to store data in normalized forms.
However, recently, due to advancements in cloud computing, ELT Data lakes gained popularity to perform data analysis, high performance parallel computing in cloud environments.

In this chapter, we will learn how to create self-service normalized data for ad-hoc reporting using The Julia Language. We will create sample data to mimic actuals datasets and will further create basic GL reports using this data.

This tpye of drag 'n' drop ad-hoc analytics reporting is very popular using BI tools like Microsoft Power BI, Tableau, Kibana, OACs, Cognos etc.

Creating these basic reports in Julia language may not look very useful in the beginning.
This exercise should be seen as creating fundamental environment for reporting, which helps perform Advance Analytics, Real time analytics, Advance Visualizations and Predictive analytics on Financial data later on.

```@repl
# Let's first import GeneralLedger.jl package
# in following examples, I'll assume, that you downloaded this package
using Pkg
Pkg.add(url="https://github.com/AmitXShukla/GeneralLedger.jl")
using GeneralLedger
```

**understanding Finance, Supply chain data**

A typical Finance statement look like this.
[click here](https://s2.q4cdn.com/470004039/files/doc_financials/2020/q4/FY20_Q4_Consolidated_Financial_Statements.pdf)

Let's first create chartfields to support General Ledger finance books accounting structure, this accounting structure will support Ledger Analytics and should be interpreted as data structure responsilbe to create Finance Statements.

**Accounts**

```@repl
using DataFrames

# create dummy data
accounts = DataFrame(AS_OF_DATE=Date("1900-01-01", dateformat"y-m-d"), 
							ID = 11000:1000:45000,
							CLASSIFICATION=repeat([
	"OPERATING_EXPENSES","NON-OPERATING_EXPENSES", "ASSETS","LIABILITIES","NET_WORTH","STATISTICS","REVENUE"
	], inner=5),
							CATEGORY=[
	"Travel","Payroll","non-Payroll","Allowance","Cash",
	"Facility","Supply","Services","Investment","Misc.",
	"Depreciation","Gain","Service","Retired","Fault.",
	"Receipt","Accrual","Return","Credit","ROI",
	"Cash","Funds","Invest","Transfer","Roll-over",
	"FTE","Members","Non_Members","Temp","Contractors",
	"Sales","Merchant","Service","Consulting","Subscriptions"
	],
							STATUS="A",
							DESCR=repeat([
	"operating expenses","non-operating expenses","assets","liability","net-worth","stats","revenue"
	], inner=5),
							ACCOUNT_TYPE=repeat([
	"E","E","A","L","N","S","R"
				],inner=5));
	accounts[collect(1:5:35),:]
```

creating Fact/Dimensions DataFrames


publishing Star - Schema RDBMS design

using Microsoft Power BI, Tableau or Oracle Analytics cloud BI tools to query data

publishing Julia Graphs, Plots using dash.jl

