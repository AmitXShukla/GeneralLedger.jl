### A Pluto.jl notebook ###
# v0.11.14

using Markdown
using InteractiveUtils

# ╔═╡ 83e24220-0298-11eb-3ffc-17346338ab33
begin
	import Pkg; Pkg.add("WebDriver")
	using WebDriver
	capabilities = Capabilities("chrome")
	ENV["WEBDRIVER_HOST"] = "127.0.0.1"
	ENV["WEBDRIVER_PORT"] = "9515"
	wd = RemoteWebDriver(capabilities, host = ENV["WEBDRIVER_HOST"], port = parse(Int, ENV["WEBDRIVER_PORT"]))
	session = Session(wd)
end

# ╔═╡ 9a8745a0-0150-11eb-345c-65a8a1841f8d
md"
# web automation using Julia Lang
automate documents download, webscraping, reconciliation, test scripts using Chrome, Firefox, Selenium webdriver.jl

**Objective** This Julia Lang notebook demonstrates, how to automate test scripts, for example, download a set of documents from websites, take screenshots and reconcile dataset.


| Website | Ticker | Open | Close | High | Low | Reconcile |
|:---------- | ---------- |:------------:|:------------:|
| AAPL | 0000010618 | 16003072 | xx |
| GOOG | 0000010665 | 16000000 | xx |

**Steps:** 

*list all features from selenium python file*

- define set of key search values (document identifier) in an excel file
- read Input from Excel
- navigate
- search and download values
- take screen shot of graphs
- take full screen screenshots
- download results into excel and reconcile
- web scraping
- loop over
- setup automating recurrence
- real time data publishing update
"

# ╔═╡ 88f416a0-0296-11eb-2836-7f72def80768
begin
	urls = (thandai="https://www.youtube.com/watch?v=hUtCnmmWvmg",lasagana="https://www.youtube.com/watch?v=bp96u74OTSA",
	pavbhaji="https://www.youtube.com/watch?v=xSVzz_CWgZA&t=1s",
	thaicurry="https://www.youtube.com/watch?v=RlAU9l2EnE0",
	donut="https://www.youtube.com/watch?v=4lLAuEbIvpA",
	airfrypizza="https://www.youtube.com/watch?v=hkWiazfYgjA",
	airfrybrocolli="https://www.youtube.com/watch?v=BHo9-ad8I3A",
	vegsamosa="https://www.youtube.com/watch?v=RLI8-mcQDrw&t=39s",
	dalgona="https://www.youtube.com/watch?v=GrxYYwP-6o8",
	moongdaal="https://www.youtube.com/watch?v=v6DCDJMkOMs&t=36s")
	views=[35,48,29,32,37,62,46,38,33,52]
	urls[rand(1:10)]
end

# ╔═╡ 9abc7a62-0298-11eb-0352-0f955cd21456
for i=1:10
	navigate!(session, "http://google.com")
	sleep(3)
	navigate!(session, urls[rand(1:10)])
	current_url(session)
	sleep(15)
	current_url(session)
end

# ╔═╡ Cell order:
# ╠═9a8745a0-0150-11eb-345c-65a8a1841f8d
# ╠═88f416a0-0296-11eb-2836-7f72def80768
# ╠═83e24220-0298-11eb-3ffc-17346338ab33
# ╠═9abc7a62-0298-11eb-0352-0f955cd21456
