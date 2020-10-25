### A Pluto.jl notebook ###
# v0.11.14

using Markdown
using InteractiveUtils

# ╔═╡ 2ba7ecb0-fe22-11ea-33b9-afa1bfa335a6
begin
	import Pkg; Pkg.add("WebDriver")
	using WebDriver
	capabilities = Capabilities("chrome")
	ENV["WEBDRIVER_HOST"] = "127.0.0.1"
	ENV["WEBDRIVER_PORT"] = "9515"
# 	chromewebdriverpath = "C:\\Users\\L569915\\Downloads\\chromedriver_win32\\chromedriver.exe"
end

# ╔═╡ b7a5a930-fe1f-11ea-05f8-0954d5812ba5
md"
# AI-Bot - automating documents download using Chrome, Selenium webdriver.jl

**Objective** requirement is to download print screen and/or download set of documents from a website.

**Step 1:** download set of key search values (document identifier) in an excel file.

| BUSINESS_UNIT | PO_ID | PO_AMOUNT | PO_AMOUNT *from image* |
|:---------- | ---------- |:------------:|:------------:|
| 02500 | 0000010618 | 16003072 | xx |
| 02500 | 0000010665 | 16000000 | xx |

OneLink webpage is searched for each row in excel, 
- Browse to PO Enquiry page
- Enter BUSINESS_UNIT and PO_ID
- OneLink returns search value, click on links to browse to PO Image download link
- read and store PO_AMOUNT from OneLink Page (this PO_AMOUNT will be used later to reconcile $$ amount in excel)
- documents are downloaded and saved as BUSINESS_PO_ID.pdf.
- after document is download, update excel column \"D\" PO_AMOUNT

**Loop over above steps for each row in excel.**

This notebook is run locally and automate the whole operations.

"

# ╔═╡ b11f55be-fe24-11ea-2886-2d60864c3971
wd = RemoteWebDriver(capabilities, host = ENV["WEBDRIVER_HOST"], port = parse(Int, ENV["WEBDRIVER_PORT"]))

# ╔═╡ 23203ff0-ff64-11ea-0bc6-01a6b6fc073c
session = Session(wd)

# ╔═╡ d9afbec0-fe25-11ea-307e-397b254381b1
# status(wd)
sessions(wd)
# delete!(session)

# ╔═╡ dfc61f90-ff63-11ea-30dd-a3e19151e6fe
current_url(session)

# ╔═╡ 31dad150-0080-11eb-39c7-d56f306a8a82
begin
	navigate!(session, "https://google.com")
	current_url(session)
end

# ╔═╡ c97a3d40-ff66-11ea-26ff-999ce30fa49f
begin
	navigate!(session, "https://onelink-fscm-uat.appl.kp.org/psc/UAT/EMPLOYEE/ERP/c/MANAGE_PURCHASE_ORDERS.PURCHASE_ORDER.GBL?Page=PO_LINE&Action=U&BUSINESS_UNIT=02500&PO_ID=0000010618")
	current_url(session)
end

# ╔═╡ cc7c4a30-0149-11eb-2e6f-d1db9e9c4181
begin
# 	# let's click on search button
	idok = "#ICOK"
	okbutton = Element(session, "xpath", """//*[@id='$(idok)']""")
	click!(okbutton)
end

# ╔═╡ ec755140-ff66-11ea-05dd-ed377057b307
# use OneLink login and check current url again,make sure, OneLink page is routed to other page
current_url(session)

# ╔═╡ 269f1ae0-007f-11eb-1933-b798799d10d5
begin
# 	# let's click on search button
	id1 = "PO_PNLS_WRK_PRINT_BTN"
	srchbutton = Element(session, "xpath", """//*[@id='$(id1)']""")
	click!(srchbutton)
end

# ╔═╡ c8a4c420-007f-11eb-3c21-ff89d045d471
begin
# 	# let's click on search button
	id2 = "#ICYes"
	printbutton = Element(session, "xpath", """//*[@id='$(id2)']""")
	click!(printbutton)
end

# ╔═╡ 33a860e0-ff79-11ea-30a5-89736bb3d8bf
begin
# 	# let's click on nav bar
# 	id1 = "pthdr2navbar"
# 	navbarbutton = Element(session, "xpath", """//*[@id='$(id1)']""")
# 	click!(navbarbutton)
end

# ╔═╡ fd4cb8c0-ff7d-11ea-18f4-8de0f0769001
# begin
# 	id2 = "PO_SRCH_BUSINESS_UNIT"
# 	id3 = "pthdr2navbar"
# 	id4 = "PO_SRCH2_BUSINESS_UNIT"
# # 	busrchtxt = Elements(session, "css selector", "//*[@id='$(id2)']")
# # 	busrchtxt = Element(session, "css selector", """//*[@id='PO_SRCH2_BUSINESS_UNIT']""")

#     element = Element(session, "xpath", """//*[@id="PO_SRCH2_BUSINESS_UNIT"]""")
#     script!(session, "arguments[0].value = arguments[1];", element, "")
#     element_keys!(element, "02500")
#     @assert element_attr(element, "value") == "02500"
#     nothing
	
# # 	click!(busrchtxt)
# # 	element_keys!(busrchtxt, "02500")
# # 	element_attr(busrchtxt, "value")
# # 	element_keys!(busrchtxt, "All your base are belong to us") # Element Send Keys
# # 	element_keys!(busrchtxt, "02500")
# # 	clear!(busrchtxt) # Element Clear
# end

# ╔═╡ e3df1320-ff77-11ea-2982-1d28e29fffc1
# begin
# 	navigate!(session, "https://onelinkfscm.kp.org/psc/fsolprd/EMPLOYEE/ERP/c/NUI_FRAMEWORK.PT_AGSTARTPAGE_NUI.GBL?CONTEXTIDPARAMS=TEMPLATE_ID%3aPTPPNAVCOL&scname=ADMN_KP_PO_PURCHASING&PanelCollapsible=Y&PTPPB_GROUPLET_ID=PURCHASING&CRefName=ADMN_NAVCOLL_9&")
# 	current_url(session)
# end

# ╔═╡ 2defbeb0-ff73-11ea-0975-5dbccd2dad5e
active_element(session)

# ╔═╡ 54e5ce10-ff73-11ea-389d-311bde734d75
# begin
# 	selecttype = Element(session, "xpath", """//select[@id='PRCR_DS_REQ_VW_BUSINESS_UNIT']""") # Find first element
# 	t1selenium = Element(selecttype, "xpath", """//option[@value='Selenium IDE']""") # Find Element From Element
# end

# ╔═╡ f164b362-ff95-11ea-331b-076560df4b96
# begin
# 	navigate!(session, "https://google.com")
# 	current_url(session)
# 	gsrch = Element(session, "xpath", """//*[@id="tsf"]/div[2]/div[1]/div[1]/div/div[2]/input""")
# 	element_keys!(gsrch, "02500")
# end

# ╔═╡ Cell order:
# ╠═b7a5a930-fe1f-11ea-05f8-0954d5812ba5
# ╠═2ba7ecb0-fe22-11ea-33b9-afa1bfa335a6
# ╠═b11f55be-fe24-11ea-2886-2d60864c3971
# ╠═23203ff0-ff64-11ea-0bc6-01a6b6fc073c
# ╠═d9afbec0-fe25-11ea-307e-397b254381b1
# ╠═dfc61f90-ff63-11ea-30dd-a3e19151e6fe
# ╠═31dad150-0080-11eb-39c7-d56f306a8a82
# ╠═c97a3d40-ff66-11ea-26ff-999ce30fa49f
# ╠═cc7c4a30-0149-11eb-2e6f-d1db9e9c4181
# ╠═ec755140-ff66-11ea-05dd-ed377057b307
# ╠═269f1ae0-007f-11eb-1933-b798799d10d5
# ╠═c8a4c420-007f-11eb-3c21-ff89d045d471
# ╠═33a860e0-ff79-11ea-30a5-89736bb3d8bf
# ╠═fd4cb8c0-ff7d-11ea-18f4-8de0f0769001
# ╠═e3df1320-ff77-11ea-2982-1d28e29fffc1
# ╠═2defbeb0-ff73-11ea-0975-5dbccd2dad5e
# ╠═54e5ce10-ff73-11ea-389d-311bde734d75
# ╠═f164b362-ff95-11ea-331b-076560df4b96
