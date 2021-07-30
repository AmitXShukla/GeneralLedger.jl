# Time Series

When an Analyst sees any Financial Statement and Finance information,
TIME SERIES is the first Analysis, comes in picture for research.

*use case*

Below function, takes a FINANCE LEDGER or any TIME BASED TRANSACTION data set,
and returns a cleaned TIME ARRAY.

TIME ARRAY expects, no missing time periods/dates, in this case, 
this function takes created average roll forwarding entires in returned Data Frame.

!!! warning
    This TIME ARRAY DATA FRAME must NOT be used for any Finance information, because it has roll forward entries which will infalte NET AMOUNTS.
    Instead TIME ARRAY DATA FRAME data is used only for AUTO REGRESSION INTEGERATED MOVING AVERAGE (ARIMA) based predictions only.


## Finance Ledger , Balance Sheet, Income Statement and Cash Flow

below is sample Finance Ledger Data,
in this Ledger data, we will run p-value to test following Hypothesis.

`For a Given Given FISCALY_YEAR and ACCOUNTING_PERIOD, 
OPERATING EXPENSES are aligned (10%) tolerance range in comparison to BEFORE or AFTER FISCAL_YEAR & ACCOUNTING_PERIOD.`

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

```

#### TIME ARRAY


getTimeArrayDF(ledger, ACCOUNT_CLASSIFICATION = "OPERATING_EXPENSES"; FISCAL_YEAR =2021, ACCOUNTING_PERIOD = 7

return p-value for given ACCOUNT NODE


getTimeArrayDF(ledger, ACCOUNT_CLASSIFICATION = "OPERATING_REVENUE"; FISCAL_YEAR =2021, ACCOUNTING_PERIOD = 7

return p-value for given ACCOUNT NODE


getTimeArrayDF(ledger, ACCOUNT_CLASSIFICATION = "OPERATING_ASSETS"; FISCAL_YEAR =2021, ACCOUNTING_PERIOD = 7

return p-value for given ACCOUNT NODE


getTimeArrayDF(ledger, DEPT_CLASSIFICATION = "OPERATING_EXPENSES"; FISCAL_YEAR =2021, ACCOUNTING_PERIOD = 7

return p-value for given DEPT NODE


getTimeArrayDF(ledger, DEPT_CLASSIFICATION = "OPERATING_REVENUE"; FISCAL_YEAR =2021, ACCOUNTING_PERIOD = 7

return p-value for given DEPT NODE


getTimeArrayDF(ledger, DEPT_CLASSIFICATION = "OPERATING_ASSETS"; FISCAL_YEAR =2021, ACCOUNTING_PERIOD = 7

return p-value for given DEPT NODE'


getTimeArrayDF(ledger, REGION_CLASSIFICATION = "OPERATING_EXPENSES"; FISCAL_YEAR =2021, ACCOUNTING_PERIOD = 7

return p-value for given REGION NODE


getTimeArrayDF(ledger, REGION_CLASSIFICATION = "OPERATING_REVENUE"; FISCAL_YEAR =2021, ACCOUNTING_PERIOD = 7

return p-value for given REGION NODE


getTimeArrayDF(ledger, REGION_CLASSIFICATION = "OPERATING_ASSETS"; FISCAL_YEAR =2021, ACCOUNTING_PERIOD = 7

return p-value for given REGION NODE