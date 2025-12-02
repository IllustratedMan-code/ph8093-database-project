#let _ = ```typ
exec typst c "$0" --root "$(readlink -f "$0" | xargs dirname)/./" --input file-0=/erdiagram.png
⁠```
#set document(title: "Final Project Report", date: datetime(year: 2025, month: 12, day: 8), author: "David Lewis")
#set text(lang: "en")
#import "@local/assignments:1.0.0": conf
#show: doc => conf(title: context{document.title}, date: context{if document.date == auto {datetime.today().display("[month repr:long] [day], [year]")} else {document.date.display("[month repr:long] [day], [year]")}}, doc)
#outline()
#set heading(numbering: "1.")
#heading(level: 1)[Introduction] #label("org791bfe7")
According to Drugbank, there are around 20,000 unique drugs used in
the healthcare system.﻿#super[#link(label("org75e43bb"))[1]] To contrast,
the average 20 year old American knows around 40,000 words,
though not necessarily what each
word means.﻿#super[#link(label("org4d391e0"))[2]] Therefore, if a physician were to learn all of the drug
names, they would take up around 1\u{2f}3 of the physician\u{27}s entire
vocabulary. Having full comprehension of all 20,000 drugs would likely
be extremely difficult, if not impossible. Free and open access tools
typically do not provide interactive visualizations of drug
relationships.﻿#super[#link(label("org4d3abc7"))[3]–#link(label("org043907d"))[5]] 
Instead, they may provide comparison charts or articles.﻿#super[#link(label("org596e186"))[6]] 

This project explores the development of an interactive tool meant to
aid physicians in medicine selection and comparison. The tool provides
interactive visualizations meant to make the comparison of medications
easier, showing how different medications relate among their
attributes including: user reviews, composition, side effects, and
usage.
#heading(level: 1)[Methods] #label("orgac5545f")
#heading(level: 2)[Data source] #label("orgd868529")
The data were collected from Kaggle using the search term
\u{22}medicine\u{22}. The collected dataset is entitled \u{22}11000 Medicine
details\u{22}.﻿#super[#link(label("orgf844d70"))[7]]

After collection of the data, which were contained within a single csv file, the
data were processed into an SQLite database using python and the
pandas package.﻿#super[#link(label("orge94d0ee"))[8]] The database uses the database architecture defined in
#ref(label("org2a219a3")). The database is then queried by the visualization tool,
an R shiny app.﻿#super[#link(label("org011abec"))[9]]

The tool is broken up into two web pages, a \u{22}home\u{22} page, and a \u{22}data
viewer\u{22} page. The home page provides some simple statistics and vizualizations



#figure([#image(sys.inputs.file-0)], caption: [Entity relationship diagram showing architecture of generated SQLite database]) #label("org2a219a3")
#heading(level: 1)[Results] #label("org9047e4b")
A live demo of the shiny app can be found on shinyapps.io at the
following URL: #link("https://illustratedman-code.shinyapps.io/project/"). The
source code for the project can be found on Github at the following
URL: #link("https://github.com/IllustratedMan-code/ph8093-database-project"). 


#pagebreak()
#heading(level: 1)[References] #label("orga9067fc")
 #label("org75e43bb")1. Statistics | DrugBank Online. Accessed December 2, 2025. #link("https://go.drugbank.com/stats")

 #label("org4d391e0")2. Brysbaert M, Stevens M, Mandera P, Keuleers E. How Many Words Do We Know? Practical Estimates of Vocabulary Size Dependent on Word Definition, the Degree of Language Input and the Participant’s Age. #emph[Front Psychol]. 2016;7:1116. doi:#link("https://doi.org/10.3389/fpsyg.2016.01116")[10.3389\u{2f}fpsyg.2016.01116] #footnote(link("https://doi.org/10.3389/fpsyg.2016.01116"))

 #label("org4d3abc7")3. Knox C, Wilson M, Klinger C, et al. DrugBank 6.0: the DrugBank Knowledgebase for 2024. #emph[Nucleic Acids Research]. 2024;52(D1):D1265\u{2d}D1275. doi:#link("https://doi.org/10.1093/nar/gkad976")[10.1093\u{2f}nar\u{2f}gkad976] #footnote(link("https://doi.org/10.1093/nar/gkad976"))

 #label("org9cc3899")4. WebMD \u{2d} Better information. Better health. WebMD. Accessed December 2, 2025. #link("https://www.webmd.com/")

 #label("org043907d")5. RxList \u{2d} The Internet Drug Index for prescription drug information, interactions, and side effects. RxList. Accessed December 2, 2025. #link("https://www.rxlist.com/")

 #label("org596e186")6. Drugs Comparison Index: Find Drug vs. Drug, Side Effects, Uses, Interactions, More. RxList. Accessed December 2, 2025. #link("https://www.rxlist.com/drugs_comparison/article.htm")

 #label("orgf844d70")7. 11000 Medicine details. Accessed December 2, 2025. #link("https://www.kaggle.com/datasets/singhnavjot2062001/11000-medicine-details")

 #label("orge94d0ee")8. team T pandas development. pandas\u{2d}dev\u{2f}pandas: Pandas. Published online September 30, 2025. doi:#link("https://doi.org/10.5281/zenodo.17229934")[10.5281\u{2f}zenodo.17229934] #footnote(link("https://doi.org/10.5281/zenodo.17229934"))

 #label("org011abec")9. Shiny. Shiny. Accessed December 2, 2025. #link("https://shiny.posit.co/")
