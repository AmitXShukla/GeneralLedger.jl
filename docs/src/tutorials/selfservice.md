# Self Service Analytics

---

In the previous chapter, we learned how to extract, load and transform data.
Often, ERP system use RDBMS database to store data in normalized forms.
However, recently, due to advancements in cloud computing, ELT Data lakes gained popularity to perform data analysis, high performance parallel computing in cloud environments.

In this chapter, we will learn how to create self-service normalized data for ad-hoc reporting using The Julia Language. We will create sample data to mimic actuals datasets and will further create basic GL reports using this data.

This tpye of drag 'n' drop ad-hoc analytics reporting is very popular using BI tools like Microsoft Power BI, Tableau, Kibana, OACs, Cognos etc.

Creating these basic reports in Julia language may not look very useful in the beginning.
This exercise should be seen as creating fundamental environment for reporting, which helps perform Advance Analytics, Real time analytics, Advance Visualizations and Predictive analytics on Financial data later on.

## About ERP Systems, General Ledger & Supply chain

A typical ERP system consists of many modules based on business domain, functions and operations.

GL is core of Finance and Supply chain domains and Buy to Pay, Order to Cash deal with different aspects of business operations in an Organization.
Many organization, use ERPs in different ways and may chose to implement all or some of the modules.

You can find examples of module specific business operations/processes diagram here.
- [General Ledger process flow](https://github.com/AmitXShukla/AmitXShukla.github.io/raw/master/blogs/PlutoCon/gl.png)
- [Account Payable process flow](https://github.com/AmitXShukla/AmitXShukla.github.io/raw/master/blogs/PlutoCon/ap.png)
- [Tax Analytics](https://github.com/AmitXShukla/AmitXShukla.github.io/raw/master/blogs/PlutoCon/tax.png)
- [Sample GL ERD - Entity Relaton Diagram](https://github.com/AmitXShukla/AmitXShukla.github.io/raw/master/blogs/PlutoCon/gl_erd.png)

A typical ERP modules list looks like below diagram.

![ERP Modules](https://github.com/AmitXShukla/AmitXShukla.github.io/raw/master/blogs/PlutoCon/ERP_modules.png)

## Current Solutions

Big Organizations have been using big ERP systems like **SAP, Oracle, PeopleSoft, Coupa, Workday** etc. systems over few decades now and 
Recent popularity of softwares like **Quickbooks, NetSuite, Tally** in medium, small organizations are proof that ERP are the way to manage any business successfully.

Finance analysts, supply chain managers heavily rely on using Business Intelligence tools like **Microsoft Excel, Microsoft Power BI, Tableau, Oracle Analytics, Google Analytics, IBM Cognos, Business Objects** etc. 

These BI tools provide a self-service reporting for analytics and often are used for managing daily ad-hoc reporting and anlysis.

A typical ERP data flow process looks like below diagram.

![GL Processes](https://github.com/AmitXShukla/AmitXShukla.github.io/raw/master/blogs/PlutoCon/gl.png)

## Problem Statement

*"Read, Write and Understand"* data are three aspects of any ERP system.

While big and small ERPs master "write aspect" of ERP, there is lot needs to be done on "read & understand" data.

I would rather not waste your time talking about how one BI Tools compare with Pluto  or others, 

instead, in this chapter,
I will show some sample reports I built in Pluto last year for Pandemic reporting, and then let Analysts decide, if They would have rather used Traditional BI reportings tools to build these reports.

Point is, How easily, Pluto can create real time ad-hoc, *Reactive* dashboard analytics to support critical business operations.

## understanding Finance, Supply chain data

A typical Finance statement look like this.
[click here](https://s2.q4cdn.com/470004039/files/doc_financials/2020/q4/FY20_Q4_Consolidated_Financial_Statements.pdf)

Let's first create chartfields to support General Ledger finance books accounting structure, this accounting structure will support Ledger Analytics and should be interpreted as data structure responsilbe to create Finance Statements.

### Examples

below are sample data sets,

Accounts, Dept (or Cost Center), Location, and Finance Ledger may look like below examples.

Let's first activate GeneralLedger.jl package.

```@repl
# Let's first import GeneralLedger.jl package
# in following examples, I'll assume, that you downloaded this package
using Pkg
Pkg.add(url="https://github.com/AmitXShukla/GeneralLedger.jl")
using GeneralLedger
```

## Accounts Dimension

```@repl
using DataFrames, Dates
# create dummy data
accounts = DataFrame(AS_OF_DATE=Date("1900-01-01", dateformat"y-m-d"), 
					ID = 11000:1000:45000,
					CLASSIFICATION=repeat([
		"OPERATING_EXPENSES","NON-OPERATING_EXPENSES", "ASSETS","LIABILITIES",
		"NET_WORTH","STATISTICS","REVENUE"
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
		"operating expenses","non-operating expenses",
		"assets","liability","net-worth","stats","revenue"
	], inner=5),
	ACCOUNT_TYPE=repeat([
	"E","E","A","L","N","S","R"
				],inner=5));
accounts[collect(1:5:35),:]
```

## Department Dimension

```@repl
using DataFrames, Dates
# create dummy data
dept = DataFrame(AS_OF_DATE=Date("2000-01-01", dateformat"y-m-d"), 
							ID = 1100:100:1500,
							CLASSIFICATION=[
	"SALES","HR", "IT","BUSINESS","OTHERS"
	],
							CATEGORY=[
	"sales","human_resource","IT_Staff","business","others"
	],
							STATUS="A",
							DESCR=[
	"Sales & Marketing","Human Resource","Infomration Technology","Business leaders","other temp"
	],
							DEPT_TYPE=[
	"S","H","I","B","O"]);
dept[collect(1:5),:]
```

## Location Dimension

```@repl
using DataFrames, Dates
# create dummy data
location = DataFrame(AS_OF_DATE=Date("2000-01-01", dateformat"y-m-d"), 
							ID = 11:1:22,
							CLASSIFICATION=repeat([
	"Region A","Region B", "Region C"], inner=4),
							CATEGORY=repeat([
	"Region A","Region B", "Region C"], inner=4),
							STATUS="A",
							DESCR=[
"Boston","New York","Philadelphia","Cleveland","Richmond",
"Atlanta","Chicago","St. Louis","Minneapolis","Kansas City",
"Dallas","San Francisco"],
							LOCA_TYPE="Physical");
location[:,:]
```
## visuals

```@repl
using DataFrames, Plots, Dates
# create dummy data
accounts = DataFrame(AS_OF_DATE=Date("1900-01-01", dateformat"y-m-d"), 
					ID = 11000:1000:45000,
					CLASSIFICATION=repeat([
		"OPERATING_EXPENSES","NON-OPERATING_EXPENSES", "ASSETS","LIABILITIES",
		"NET_WORTH","STATISTICS","REVENUE"
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
		"operating expenses","non-operating expenses",
		"assets","liability","net-worth","stats","revenue"
	], inner=5),
	ACCOUNT_TYPE=repeat([
	"E","E","A","L","N","S","R"
				],inner=5));
dept = DataFrame(AS_OF_DATE=Date("2000-01-01", dateformat"y-m-d"), 
							ID = 1100:100:1500,
							CLASSIFICATION=[
	"SALES","HR", "IT","BUSINESS","OTHERS"
	],
							CATEGORY=[
	"sales","human_resource","IT_Staff","business","others"
	],
							STATUS="A",
							DESCR=[
	"Sales & Marketing","Human Resource","Infomration Technology","Business leaders","other temp"
	],
							DEPT_TYPE=[
	"S","H","I","B","O"]);
location = DataFrame(AS_OF_DATE=Date("2000-01-01", dateformat"y-m-d"), 
							ID = 11:1:22,
							CLASSIFICATION=repeat([
	"Region A","Region B", "Region C"], inner=4),
							CATEGORY=repeat([
	"Region A","Region B", "Region C"], inner=4),
							STATUS="A",
							DESCR=[
"Boston","New York","Philadelphia","Cleveland","Richmond",
"Atlanta","Chicago","St. Louis","Minneapolis","Kansas City",
"Dallas","San Francisco"],
							LOCA_TYPE="Physical");
p1 = plot((combine(groupby(accounts, :CLASSIFICATION), nrow)).nrow,(combine(groupby(accounts, :CLASSIFICATION), nrow)).CLASSIFICATION, seriestype=scatter, label = "# of accounts by classification", xlabel = "# of accounts", ylabel="Class", xlims = (0, 5.5))
	p2 = plot((combine(groupby(dept, :CLASSIFICATION), nrow)).nrow,(combine(groupby(dept, :CLASSIFICATION), nrow)).CLASSIFICATION, seriestype=scatter, label = "# of dept by classification", xlabel = "# of depts", ylabel="Class", xlims = (0, 2))
	p3 = plot((combine(groupby(accounts, :CLASSIFICATION), nrow)).nrow,(combine(groupby(location, :CLASSIFICATION), nrow)).CLASSIFICATION, seriestype=scatter, label = "# of locations by classification", xlabel = "# of locations", ylabel="Class", xlims = (1, 6.5))
plot(p1, p2, p3, layout = (3, 1), legend = false)

```

## Financial Statements

### Finance Ledger, Balance Sheet, Income, Cash Flow Statements

below is sample Finance Ledger Data

```@repl
using DataFrames, Plots, Dates
# create dummy data
accounts = DataFrame(AS_OF_DATE=Date("1900-01-01", dateformat"y-m-d"), 
					ID = 11000:1000:45000,
					CLASSIFICATION=repeat([
		"OPERATING_EXPENSES","NON-OPERATING_EXPENSES", "ASSETS","LIABILITIES",
		"NET_WORTH","STATISTICS","REVENUE"
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
		"operating expenses","non-operating expenses",
		"assets","liability","net-worth","stats","revenue"
	], inner=5),
	ACCOUNT_TYPE=repeat([
	"E","E","A","L","N","S","R"
				],inner=5));
dept = DataFrame(AS_OF_DATE=Date("2000-01-01", dateformat"y-m-d"), 
							ID = 1100:100:1500,
							CLASSIFICATION=[
	"SALES","HR", "IT","BUSINESS","OTHERS"
	],
							CATEGORY=[
	"sales","human_resource","IT_Staff","business","others"
	],
							STATUS="A",
							DESCR=[
	"Sales & Marketing","Human Resource","Infomration Technology","Business leaders","other temp"
	],
							DEPT_TYPE=[
	"S","H","I","B","O"]);
location = DataFrame(AS_OF_DATE=Date("2000-01-01", dateformat"y-m-d"), 
							ID = 11:1:22,
							CLASSIFICATION=repeat([
	"Region A","Region B", "Region C"], inner=4),
							CATEGORY=repeat([
	"Region A","Region B", "Region C"], inner=4),
							STATUS="A",
							DESCR=[
"Boston","New York","Philadelphia","Cleveland","Richmond",
"Atlanta","Chicago","St. Louis","Minneapolis","Kansas City",
"Dallas","San Francisco"],
							LOCA_TYPE="Physical");
ledger = DataFrame(
		LEDGER = String[], FISCAL_YEAR = Int[], PERIOD = Int[], ORGID = String[],
		OPER_UNIT = String[], ACCOUNT = Int[], DEPT = Int[], LOCATION = Int[], 	
		POSTED_TOTAL = Float64[]
	);
	# create 2020 Period 1-12 Actuals Ledger 
	l = "Actuals";
	fy = 2020;
	for p = 1:12
		for i = 1:10^5
		push!(ledger, (l, fy, p, "ABC Inc.", rand(location.CATEGORY),
			rand(accounts.ID), rand(dept.ID), rand(location.ID), rand()*10^8))
		end
	end
	# create 2021 Period 1-4 Actuals Ledger 
	l = "Actuals";
	fy = 2021;
	for p = 1:4
		for i = 1:10^5
		push!(ledger, (l, fy, p, "ABC Inc.", rand(location.CATEGORY),
			rand(accounts.ID), rand(dept.ID), rand(location.ID), rand()*10^8))
		end
	end
	# create 2021 Period 1-4 Budget Ledger 
	l = "Budget";
	fy = 2021;
	for p = 1:12
		for i = 1:10^5
		push!(ledger, (l, fy, p, "ABC Inc.", rand(location.CATEGORY),
			rand(accounts.ID), rand(dept.ID), rand(location.ID), rand()*10^8))
		end
	end
ledger[:,:]

# create default binding values/params
using PlutoUI

## WARNING
## These bind variable will throw in error in documentation
## however, these runs fine on Pluto notebooks and provide a slider to change values dynamically

# @bind ld Select(["Actuals", "Budget"])
# @bind rg Select(["Region A", "Region B", "Region C"])
# @bind yr Slider(2020:1:2021, default=2020, show_value=true)
# @bind qtr Slider(1:1:4, default=1, show_value=true)
# @bind ld_p Select(["Actuals", "Budget"])
# @bind yr_p Slider(2020:1:2021, default=2021, show_value=true)
# @bind rg_p Select(["Region A", "Region B", "Region C"])
# @bind ldescr Select(unique(location.DESCR))
# @bind adescr Select(unique(accounts.CLASSIFICATION))
# @bind ddescr Select(unique(dept.CLASSIFICATION))

ld = "Actuals"
rg = "Region B"
yr = 2020
qtr = 1
ld_p = "Actuals"
rg_p = "Region B"
yr_p = 2020
qtr_p = 1
ldescr = unique(location.DESCR)
adescr = unique(accounts.CLASSIFICATION)
ddescr = unique(dept.CLASSIFICATION)

########################
##### BALANCE SHEET ####
########################

# rename dimensions columns for innerjoin
df_accounts = rename(accounts, :ID => :ACCOUNTS_ID, :CLASSIFICATION => :ACCOUNTS_CLASSIFICATION, :CATEGORY => :ACCOUNTS_CATEGORY, :DESCR => :ACCOUNTS_DESCR);
df_dept = rename(dept, :ID => :DEPT_ID, :CLASSIFICATION => :DEPT_CLASSIFICATION, :CATEGORY => :DEPT_CATEGORY, :DESCR => :DEPT_DESCR);
df_location = rename(location, :ID => :LOCATION_ID, :CLASSIFICATION => :LOCATION_CLASSIFICATION, :CATEGORY => :LOCATION_CATEGORY, :DESCR => :LOCATION_DESCR);

# create a function which converts accounting period to Quarter
function periodToQtr(x)
	if x ∈ 1:3
		return 1
	elseif x ∈ 4:6
		return 2
	elseif x ∈ 7:9
		return 3
	else return 4
	end
	end

##############################################################
# create a new dataframe to join all chartfields with ledger #
##############################################################

df_ledger = innerjoin(
		innerjoin(
			innerjoin(ledger, df_accounts, on = [:ACCOUNT => :ACCOUNTS_ID], makeunique=true),
			df_dept, on = [:DEPT => :DEPT_ID], makeunique=true), df_location,
	on = [:LOCATION => :LOCATION_ID], makeunique=true);
	transform!(df_ledger, :PERIOD => ByRow(periodToQtr) => :QTR);

function numToCurrency(x)
		return string("USD ",round(x/10^6; digits = 2), "m")
	end
	gdf = groupby(df_ledger, [:LEDGER, :FISCAL_YEAR, :QTR, :OPER_UNIT, :ACCOUNTS_CLASSIFICATION, :DEPT_CLASSIFICATION, 
			# :LOCATION_CLASSIFICATION,
			:LOCATION_DESCR]);
	gdf_plot = combine(gdf, :POSTED_TOTAL => sum => :TOTAL);

	select(gdf_plot[(
				(gdf_plot.FISCAL_YEAR .== yr)
				.&
				(gdf_plot.QTR .== qtr)
				.&
				(gdf_plot.LEDGER .== ld)
				.&
				(gdf_plot.OPER_UNIT .== rg)
				),:], 
		:FISCAL_YEAR => :FY,
		:QTR => :Qtr,
		:OPER_UNIT => :Org,
		:ACCOUNTS_CLASSIFICATION => :Accounts,
		:DEPT_CLASSIFICATION => :Dept,
		# :LOCATION_CLASSIFICATION => :Region,
		:LOCATION_DESCR => :Loc,
		:TOTAL => ByRow(numToCurrency) => :TOTAL)

########################
### Income Statement ###
########################

select(gdf_plot[(
				(gdf_plot.FISCAL_YEAR .== yr)
				.&
				(gdf_plot.QTR .== qtr)
				.&
				(gdf_plot.LEDGER .== ld)
				.&
				(gdf_plot.OPER_UNIT .== rg)
				.&
				(in.(gdf_plot.ACCOUNTS_CLASSIFICATION, Ref(["ASSETS", "LIABILITIES", "REVENUE","NET_WORTH"])))
				),:], 
		:FISCAL_YEAR => :FY,
		:QTR => :Qtr,
		:OPER_UNIT => :Org,
		:ACCOUNTS_CLASSIFICATION => :Accounts,
		# :DEPT_CLASSIFICATION => :Dept,
		# :LOCATION_CLASSIFICATION => :Region,
		# :LOCATION_DESCR => :Loc,
		:TOTAL => ByRow(numToCurrency) => :TOTAL)

########################
##### CASH FLOW ########
########################

select(gdf_plot[(
				(gdf_plot.FISCAL_YEAR .== yr)
				.&
				(gdf_plot.QTR .== qtr)
				.&
				(gdf_plot.LEDGER .== ld)
				.&
				(gdf_plot.OPER_UNIT .== rg)
				.&
				(in.(gdf_plot.ACCOUNTS_CLASSIFICATION, Ref(["NON-OPERATING_EXPENSES","OPERATING_EXPENSES"	])))
				),:], 
		:FISCAL_YEAR => :FY,
		:QTR => :Qtr,
		:OPER_UNIT => :Org,
		:ACCOUNTS_CLASSIFICATION => :Accounts,
		# :DEPT_CLASSIFICATION => :Dept,
		# :LOCATION_CLASSIFICATION => :Region,
		# :LOCATION_DESCR => :Loc,
		:TOTAL => ByRow(numToCurrency) => :TOTAL)


########################
##### Ledger Visual ####
########################

plot_data = gdf_plot[(
		(gdf_plot.FISCAL_YEAR .== yr_p)
		.&
		(gdf_plot.LEDGER .== ld_p)
		.&
		(gdf_plot.OPER_UNIT .== rg_p)
		.&
		(gdf_plot.LOCATION_DESCR .== ldescr)
		.&
		(gdf_plot.DEPT_CLASSIFICATION .== ddescr)
		.&
		(gdf_plot.ACCOUNTS_CLASSIFICATION .== adescr))
		, :];
	# @df plot_data scatter(:QTR, :TOTAL/10^8, title = "Finance Ledger Data", xlabel="Quarter", ylabel="Total (in USD million)", label="$ld_p Total by $yr_p for $rg_p")
	@df plot_data plot(:QTR, :TOTAL/10^8, title = "Finance Ledger Data", xlabel="Quarter", ylabel="Total (in USD million)", 
		label=[
			"$ld_p by $yr_p for $rg_p $ldescr $adescr $ddescr"
			],
		lw=3)
		
#################################
## Actual vs Budget Comparison ##
#################################

plot_data_a = gdf_plot[(
		(gdf_plot.FISCAL_YEAR .== yr_p)
		.&
		(gdf_plot.LEDGER .== "Actuals")
		.&
		(gdf_plot.OPER_UNIT .== rg_p)
		.&
		(gdf_plot.LOCATION_DESCR .== ldescr)
		.&
		(gdf_plot.DEPT_CLASSIFICATION .== ddescr)
		.&
		(gdf_plot.ACCOUNTS_CLASSIFICATION .== adescr))
		, :];
	# @df plot_data scatter(:QTR, :TOTAL/10^8, title = "Finance Ledger Data", xlabel="Quarter", ylabel="Total (in USD million)", label="$ld_p Total by $yr_p for $rg_p")
	plot_data_b = gdf_plot[(
		(gdf_plot.FISCAL_YEAR .== yr_p)
		.&
		(gdf_plot.LEDGER .== "Budget")
		.&
		(gdf_plot.OPER_UNIT .== rg_p)
		.&
		(gdf_plot.LOCATION_DESCR .== ldescr)
		.&
		(gdf_plot.DEPT_CLASSIFICATION .== ddescr)
		.&
		(gdf_plot.ACCOUNTS_CLASSIFICATION .== adescr))
		, :];
	# @df plot_data scatter(:QTR, :TOTAL/10^8, title = "Finance Ledger Data", xlabel="Quarter", ylabel="Total (in USD million)", label="$ld_p Total by $yr_p for $rg_p")
	@df plot_data_a plot(:QTR, :TOTAL/10^8, title = "Finance Ledger Data", xlabel="Quarter", ylabel="Total (in USD million)", 
		label=[
			"Actuals by $yr_p for $rg_p $ldescr $adescr $ddescr"
			],
		lw=3)
	@df plot_data_b plot!(:QTR, :TOTAL/10^8, title = "Finance Ledger Data", xlabel="Quarter", ylabel="Total (in USD million)", 
		label=[
			"Budget by $yr_p for $rg_p $ldescr $adescr $ddescr"
			],
		lw=3)

```

## SEC Filings

## Stock prices

## volume charts
