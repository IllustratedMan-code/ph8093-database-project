#let _ = ```typ
exec typst c "$0" --root "$(readlink -f "$0" | xargs dirname)/./" --input file-5=/assets/data-viewer-2.png --input file-4=/assets/data-viewer-1.png --input file-3=/assets/home-2.png --input file-2=/assets/home-1.png --input file-1=/assets/mockup-final.png --input file-0=/erdiagram.png
⁠```
#set document(title: "Final Project Report", date: datetime(year: 2025, month: 12, day: 8), author: "David Lewis")
#set text(lang: "en")
#import "@local/assignments:1.0.0": conf
#show: doc => conf(title: context{document.title}, date: context{if document.date == auto {datetime.today().display("[month repr:long] [day], [year]")} else {document.date.display("[month repr:long] [day], [year]")}}, doc)
#outline()
#set heading(numbering: "1.")
#heading(level: 1)[Introduction] #label("org657843e")
According to Drugbank, there are around 20,000 unique drugs used in
the healthcare system.﻿#super[#link(label("org9e03312"))[1]] To contrast,
the average 20 year old American knows around 40,000 words,
though not necessarily what each
word means.﻿#super[#link(label("org8b7d28b"))[2]] Therefore, if a physician were to learn all of the drug
names, they would take up around 1\u{2f}3 of the physician\u{27}s entire
vocabulary. Having full comprehension of all 20,000 drugs would likely
be extremely difficult, if not impossible. Free and open access tools
typically do not provide interactive visualizations of drug
relationships.﻿#super[#link(label("orgc2886d6"))[3]–#link(label("org1ae43f6"))[5]] 
Instead, they may provide comparison charts or articles.﻿#super[#link(label("org8ac6ef9"))[6]] 

This project explores the development of an interactive tool meant to
aid physicians in medicine selection and comparison. The tool provides
interactive visualizations meant to make the comparison of medications
easier, showing how different medications relate among their
attributes including: user reviews, composition, side effects, and
usage.
#heading(level: 1)[Methods] #label("orge14935f")
#heading(level: 2)[Data source] #label("orga932087")
The data were collected from Kaggle using the search term
\u{22}medicine\u{22}. The collected dataset is entitled \u{22}11000 Medicine
details\u{22}.﻿#super[#link(label("org88f6798"))[7]]

After collection of the data, which were contained within a single csv file, the
data were processed into an SQLite database using python and the
pandas package.﻿#super[#link(label("orgef9516e"))[8]] The database uses the database architecture defined in
#ref(label("org05a2687")). The database is then queried by the visualization tool,
an R shiny app.﻿#super[#link(label("orgfc1758b"))[9]]

The tool was designed to have two web pages, a \u{22}home\u{22} page, and a \u{22}data
viewer\u{22} page. The home page would contain simple statistics and
visualizations for the data set, including the total number of
medicines, while the data viewer page would contain an interactive
browser of the medication, with visualizations that change based on
which medications are selected from a list. The list would be
filterable, and multiple medications could be selected at once. A
simple wireframe mockup is provided in #ref(label("org3915c01")).

To further expand on the layout plan, the home page would contain 3
histograms that correspond to the available non\u{2d}numeric variables in
the dataset. The summary statistics will include the number of unique
medications in the dataset and number of unique values for non\u{2d}numeric
values.

The data viewer page would contain a scatter plot depicting the review
percentages given in the dataset. The points in the scatter plot would
represent individual medications and would have filters to handle
relationships between medications with non\u{2d}numeric variables.


#figure([#image(sys.inputs.file-0)], caption: [Entity relationship diagram showing architecture of generated SQLite database]) #label("org05a2687")

#figure([#image(sys.inputs.file-1)], caption: [Mockup of shiny app design]) #label("org3915c01")


#pagebreak()
#heading(level: 1)[Results] #label("orgbd6e337")
A live demo of the shiny app can be found on shinyapps.io at the
following URL: #link("https://illustratedman-code.shinyapps.io/project/"). The
source code for the project can be found on Github at the following
URL: #link("https://github.com/IllustratedMan-code/ph8093-database-project"). 


#figure([#image(sys.inputs.file-2)], caption: [The first section of the home page]) #label("org4391fd7")

#figure([#image(sys.inputs.file-3)], caption: [The second section of the home page]) #label("org1f606ca")

#figure([#image(sys.inputs.file-4)], caption: [The first section of the data viewer page]) #label("org79020d8")

#figure([#image(sys.inputs.file-5)], caption: [The second section of the data viewer page]) #label("org20d0932")
#heading(level: 1)[Response to feedback] #label("orgf9080b7")
#quote(attribution: [Jason])[

I recommend removing the medication images, ... you may also add
Therapeutic and Pharmaceutical classes as filters ...

]


I\u{27}m not going to remove the images because one of the class comments
actually preferred it with the images, so seems the feedback is split
on this point. Additionally, I do not have any data for additional
classifications of the medications. All variables are represented in
the visualizations\u{2f}tables.

#quote(attribution: [unknown classmate])[
... By adding proper sections and heading to each table,
visualizations can be made more intuitive. ...
]

I wasn\u{27}t exactly sure what to write for each section, though I did add
directions to get a user started in the data viewer. The home page
already had section labels.

#quote(attribution: [unknown classmate])[
... could you filter the top X so that it\u{27}s easier to have and see
what\u{27}s in each bar.
]


This is already supported by plotly, by dragging over the desired
region.


All other feedback was implemented when possible. 

#pagebreak()
#heading(level: 1)[References] #label("org62d95a0")
 #label("org9e03312")1. Statistics | DrugBank Online. Accessed December 2, 2025. #link("https://go.drugbank.com/stats")

 #label("org8b7d28b")2. Brysbaert M, Stevens M, Mandera P, Keuleers E. How Many Words Do We Know? Practical Estimates of Vocabulary Size Dependent on Word Definition, the Degree of Language Input and the Participant’s Age. #emph[Front Psychol]. 2016;7:1116. doi:#link("https://doi.org/10.3389/fpsyg.2016.01116")[10.3389\u{2f}fpsyg.2016.01116] #footnote(link("https://doi.org/10.3389/fpsyg.2016.01116"))

 #label("orgc2886d6")3. Knox C, Wilson M, Klinger C, et al. DrugBank 6.0: the DrugBank Knowledgebase for 2024. #emph[Nucleic Acids Research]. 2024;52(D1):D1265\u{2d}D1275. doi:#link("https://doi.org/10.1093/nar/gkad976")[10.1093\u{2f}nar\u{2f}gkad976] #footnote(link("https://doi.org/10.1093/nar/gkad976"))

 #label("org9b88262")4. WebMD \u{2d} Better information. Better health. WebMD. Accessed December 2, 2025. #link("https://www.webmd.com/")

 #label("org1ae43f6")5. RxList \u{2d} The Internet Drug Index for prescription drug information, interactions, and side effects. RxList. Accessed December 2, 2025. #link("https://www.rxlist.com/")

 #label("org8ac6ef9")6. Drugs Comparison Index: Find Drug vs. Drug, Side Effects, Uses, Interactions, More. RxList. Accessed December 2, 2025. #link("https://www.rxlist.com/drugs_comparison/article.htm")

 #label("org88f6798")7. 11000 Medicine details. Accessed December 2, 2025. #link("https://www.kaggle.com/datasets/singhnavjot2062001/11000-medicine-details")

 #label("orgef9516e")8. team T pandas development. pandas\u{2d}dev\u{2f}pandas: Pandas. Published online September 30, 2025. doi:#link("https://doi.org/10.5281/zenodo.17229934")[10.5281\u{2f}zenodo.17229934] #footnote(link("https://doi.org/10.5281/zenodo.17229934"))

 #label("orgfc1758b")9. Shiny. Shiny. Accessed December 2, 2025. #link("https://shiny.posit.co/")
