# Natural Language Processing for General Ledger

Often NLP has limited but very powerful role to play in General Ledger and overall ERP business processes.

A valid use case is,

- what is impact of a Market Research report to Comopany's Operating Revenue?
- what does it mean to Company's cash flow if Federal Tax Rates changes?
- how company Finance Statement react (if applicable) to Twitter feed, political or climate change?

Other use case may be applicable to transaction data

- is there any confidential data?
- did vendor submit duplicate invoices?
- which city/state did incur expenses?
- how to identify if Finance transaction have employee/personal information?

```@repl
    using DataFrames, TextAnalysis

	df_str_sample = DataFrame(sentences = [
			"Amit Shukla lives in Los Angeles California.",
			"Most of Techie people live in North California.",
			"Elon Musk thinks, How does it matter who is living where?",
			"It doesn't matter to Bill Gates, sharing live zip code information 90210 is harmless.",
			"Jeff Bezos is here to see GeneralLedger.jl, NOT LIVING conditions, getting headache now.",
			"I am already took pills, says Jack Ma.",
			"This data does not make any sense to John Doe."
			])
	str1 = TextAnalysis.StringDocument("Amit Shukla lives in Los Angeles California.")
	str2 = TextAnalysis.StringDocument("Most of Techie people live in North California.")
	str3 = TextAnalysis.StringDocument("Elon Musk thinks, How does it matter who is living where?")
	str4 = TextAnalysis.StringDocument("It doesn't matter to Bill Gates, sharing live zip code information 90210 is harmless.")
	str5 = TextAnalysis.StringDocument("Jeff Bezos is here to see GeneralLedger.jl, NOT LIVING conditions, getting headache now.")
	str6 = TextAnalysis.StringDocument("I am already took pills, says Jack Ma.")
	str7 = StringDocument("This data does not make any sense to John Doe.")
	
	TextAnalysis.stem!(str7)
	crpstr2 = Corpus([str1,str2,str3,str4,str5,str6])
	update_lexicon!(crpstr2)
	update_inverse_index!(crpstr2)
	# lexicon(crpstr1), lexicon(crpstr2), inverse_index(crpstr1), inverse_index(crpstr2), crps2["live"]
	# TextAnalysis.text(str1),
	# TextAnalysis.text(str2),
	# TextAnalysis.text(str3),
	# TextAnalysis.text(str4),
	# TextAnalysis.text(str5),
	# TextAnalysis.text(str6),
	# TextAnalysis.text(str7)
	df_str_sample[:,:sentences]

```

#### what are you talking about here?

`("live", 5)`

`(lives, live, living, live, LIVING) => 5 occurances`

#### which places you are talking about?

`("North", "North California", "Los Angeles", "California", "90210")`

#### is there any personal data?

`("Amit Shukla", "Elon Musk", "Bill Gates", "Jeff Bezos", "Jack Ma", "John Doe")`


#### is there any Protective Health information data?

`("Bill Gates", "90210"), ("Jeff Bezos", "headache"), ("Jack Ma", "pills")`
