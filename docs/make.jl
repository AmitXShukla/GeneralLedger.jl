push!(LOAD_PATH, "../src/")
using Documenter, GeneralLedger

makedocs(sitename="GeneralLedger.jl",
    pages=[
        "Objective" => "index.md"
        "Introduction" => "introduction.md"
        "Tutorials" => [
            "About GL" => "tutorials/aboutgl.md"
            "GL Processes" => "tutorials/glprocesses.md"
            "ERD" => "tutorials/erd.md"
            "Installing Julia" => "tutorials/installation.md"
            "Self-Service Data Analytics" => "tutorials/selfservice.md"
            "Visualizations" => "tutorials/plots.md"
            "ML4GL" => [
                "Machine Learning" => "tutorials/mlforgl.md"
                "Finance Data" => "tutorials/financedata.md"
                "Probability" => "tutorials/probability.md"
                "Statistics" => "tutorials/statistics.md"
                "p-value, null hypothesis and real time analytic" => "tutorials/hypothesis.md"
                "Optimization" => "tutorials/optimization.md"
                "Derivative & Gradients" => "tutorials/derivatives.md"
                "Deep Learning" => "tutorials/dl.md"
            ]
            "NLP for GL" => "tutorials/nlp.md"
            "Transformers" => "tutorials/transformers.md"
            "Graph Theory / Network Science" => "tutorials/graph.md"
            "Open AI ChatGPT" => "tutorials/chatgpt.md"
            "ELT vs ETL" => "tutorials/elt.md"
        ]
        "API" => "api.md"
    ],
)
