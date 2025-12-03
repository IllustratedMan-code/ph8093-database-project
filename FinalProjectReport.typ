#let _ = ```typ
exec typst c "$0" --root "$(readlink -f "$0" | xargs dirname)/./" --input file-5=/assets/data-viewer-2.png --input file-4=/assets/data-viewer-1.png --input file-3=/assets/home-2.png --input file-2=/assets/home-1.png --input file-1=/assets/mockup-final.png --input file-0=/erdiagram.png
⁠```
#set document(title: "Final Project Report", date: datetime(year: 2025, month: 12, day: 8), author: "David Lewis")
#set text(lang: "en")
#import "@local/assignments:1.0.0": conf
#show: doc => conf(title: context{document.title}, date: context{if document.date == auto {datetime.today().display("[month repr:long] [day], [year]")} else {document.date.display("[month repr:long] [day], [year]")}}, doc)
#outline()
#set heading(numbering: "1.")
#heading(level: 1)[Introduction] #label("orge5f948d")
According to Drugbank, there are around 20,000 unique drugs used in
the healthcare system.﻿#super[#link(label("orge470ab1"))[1]] To contrast,
the average 20 year old American knows around 40,000 words,
though not necessarily what each
word means.﻿#super[#link(label("org580a464"))[2]] Therefore, if a physician were to learn all of the drug
names, they would take up around 1\u{2f}3 of the physician\u{27}s entire
vocabulary. Having full comprehension of all 20,000 drugs would likely
be extremely difficult, if not impossible. Free and open access tools
typically do not provide interactive visualizations of drug
relationships.﻿#super[#link(label("org151e4c8"))[3]–#link(label("orgab882d1"))[5]] 
Instead, they may provide comparison charts or articles.﻿#super[#link(label("orgf54a3e4"))[6]] 

This project explores the development of an interactive tool meant to
aid physicians in medicine selection and comparison. The tool provides
interactive visualizations meant to make the comparison of medications
easier, showing how different medications relate among their
attributes including: user reviews, composition, side effects, and
usage.
#heading(level: 1)[Methods] #label("org4bae031")
#heading(level: 2)[Data source] #label("orgaa629d5")
The data were collected from Kaggle using the search term
\u{22}medicine\u{22}. The collected dataset is entitled \u{22}11000 Medicine
details\u{22}.﻿#super[#link(label("org4cde49a"))[7]]

After collection of the data, which were contained within a single csv file, the
data were processed into an SQLite database using python and the
pandas package.﻿#super[#link(label("org005ec54"))[8]] The database uses the database architecture defined in
#ref(label("org1f86dc5")). The database is then queried by the visualization tool,
an R shiny app.﻿#super[#link(label("org6851de8"))[9]]

The tool was designed to have two web pages, a \u{22}home\u{22} page, and a \u{22}data
viewer\u{22} page. The home page would contain simple statistics and
visualizations for the data set, including the total number of
medicines, while the data viewer page would contain an interactive
browser of the medication, with visualizations that change based on
which medications are selected from a list. The list would be
filterable, and multiple medications could be selected at once. A
simple wireframe mockup is provided in #ref(label("orgade29c9")).

To further expand on the layout plan, the home page would contain 3
histograms that correspond to the available non\u{2d}numeric variables in
the dataset. The summary statistics will include the number of unique
medications in the dataset and number of unique values for non\u{2d}numeric
values.

The data viewer page would contain a scatter plot depicting the review
percentages given in the dataset. The points in the scatter plot would
represent individual medications and would have filters to handle
relationships between medications with non\u{2d}numeric variables.


#figure([#image(sys.inputs.file-0)], caption: [Entity relationship diagram showing architecture of generated SQLite database]) #label("org1f86dc5")

#figure([#image(sys.inputs.file-1)], caption: [Mockup of shiny app design]) #label("orgade29c9")


#pagebreak()
#heading(level: 1)[Results] #label("org7174808")
A live demo of the shiny app can be found on shinyapps.io at the
following URL: #link("https://illustratedman-code.shinyapps.io/project/"). The
source code for the project can be found on Github at the following
URL: #link("https://github.com/IllustratedMan-code/ph8093-database-project"). 

#ref(label("orge178ffb")) is the first section of the home page, showing the
summary statistics for the dataset as well as a histogram of one of
the non\u{2d}numeric variables in the dataset. The histogram is a plotly
figure, so it can be interacted with by dragging to select specific
regions, zooming in, etc. Additionally, there is a link to the source
of the data, which might be helpful for those who want to know more
about the composition of these data.

#figure([#image(sys.inputs.file-2)], caption: [The first section of the home page]) #label("orge178ffb")

#ref(label("org2d2dbcf")) shows the second section of the
home page, two more histograms showing the remaining non\u{2d}numeric
variables in the dataset. It should be noted that the medications
components had the most diversity, with both the largest number of
unique values, and lowest maximum value. Side effects, on the other
hand, had the least diversity, with over 6000 medications that had
nausea as a side effect.

The number of unique values within these non\u{2d}numeric variables is
significantly dwarfed by the number of unique medications. It stands
to reason that there are likely medication that share similar
non\u{2d}numeric variables with each other, simply changing the name or
composition slightly.




#figure([#image(sys.inputs.file-3)], caption: [The second section of the home page]) #label("org2d2dbcf")


#ref(label("org8dfe15e")) shows the first section of the data viewer page. The
left side of the page is the table of medications. The table shows the
Medicine name, a photo of the medicine, the manufacturer of the
medicine, and the only numeric values in the dataset, the review
percentages. The review ratings are split into three categories, a
poor, average or excellent review.

On the right side of the page, there is a scatter plot that depicts
each medication in a semi\u{2d}3\u{2d}dimensional way. The poor and average
review percentages form the x and y axes respectively. The color
depicts the excellent review percentage. Depicting the medications
spatially allows one to compare a selected medication with other
medication that are related in terms of review percentages. This novel
visualization might allow a physician to compare related medications
and select an alternative that may accomplish the same result while
having better review percentages. To further accomplish this, there
are filters that allow one to filter by similar composition, usage,
and side effects. For a medication to show up in the filter, it must
have at least one similar attribute for each checked box.

Additionally, there is a pie chart reiterating the review data listed
in the table. #ref(label("org618a403")) shows a set of tables each showing
which components, uses, and side effects each selected medications has.



#figure([#image(sys.inputs.file-4)], caption: [The first section of the data viewer page]) #label("org8dfe15e")

#figure([#image(sys.inputs.file-5)], caption: [The second section of the data viewer page]) #label("org618a403")
#heading(level: 1)[Discussion and Analysis] #label("org1d58788")
This project explores visualizing a large list of medications
spatially. Specifically, the scatter plot in #ref(label("org8dfe15e"))
provides a way to see the relationship between medications without a
comparison chart. However, using only reviews to form this spatial
relationship is limiting, it does not represent similar usage for
example.  A future direction for this type of visualization might be
natural language based embeddings that provide a high dimensional
spatial relationship between different medications. The dataset was
quite limited when it came to different variables. The database that
the dataset was scraped from also contains text descriptions of each
medication, which could be used to create spatial embeddings.

While the dataset does contain a considerable amount of medications,
more do exist﻿#super[#link(label("orge470ab1"))[1]], and more will be
created every year. A more sophisticated visualization tool would
actively query web databases to remain up to date.

Shiny is quite limited in flexibility and certain optimizations were
difficult if not impossible to complete. For example, certain
expensive operations will freeze the user interface in between inputs. While this
can be somewhat solved by the futures package, fine tuned control of
the execution stack can\u{27}t be controlled from within R. Multiple
invocations of a function in the current implementation will all
execute even if the results are not required. So the user interface can still
freeze under certain circumstances.

In future iterations of this project, shiny and R would be dropped in
favor of a more powerful and flexible framework and language. For
example, rust, which has advanced multithreading and asynchronous
support, could be used by compiling to webassembly.

That being said, the spatial visualization provides an easy\u{2d}to\u{2d}use way
to compare different medications without prior knowledge of said
medications. Further optimizations would serve to make this
visualizations more intuitive and useful.
#heading(level: 1)[Response to feedback] #label("org39e2697")
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

#quote(attribution: [Scott])[
You have a very interesting and interactive graph that is very small. I would highlight that on the page (make it bigger?) and minimize the pie chart’s placement on the page. 
]

The plot is now larger and more prominent on the page.

#quote(attribution: [unknown classmate])[
This application is very useful. By adding proper sections and headings to each table, visualizations can be made more intuitive.
Does your data have generic medication names as a column? It might be
nice to include that as part of your table! As well, consider
combining all three of your tables together in your visualizations.
]

There are no generic medication names. All columns are represented in
some way in the app. I did make the table into a tabbed interface, so
there is less scrolling, but the tables are incompatible with each
other, so I can\u{27}t strictly combine them.


#quote(attribution: [unknown classmate])[
Cool app! I liked that you got images for these meds embedded into your table. The similarity plot\u{2f}map is really cool. Maybe the tables that you have down in the bottom could be pie chart\u{2f}bar charts too?
]

I\u{27}m not really sure how the tables could be represented as bar charts
or pie charts as most of the time, the usage, composition, etc. are
unique text names, not numeric values.

#pagebreak()
#heading(level: 1)[References] #label("org0120499")
 #label("orge470ab1")1. Statistics | DrugBank Online. Accessed December 2, 2025. #link("https://go.drugbank.com/stats")

 #label("org580a464")2. Brysbaert M, Stevens M, Mandera P, Keuleers E. How Many Words Do We Know? Practical Estimates of Vocabulary Size Dependent on Word Definition, the Degree of Language Input and the Participant’s Age. #emph[Front Psychol]. 2016;7:1116. doi:#link("https://doi.org/10.3389/fpsyg.2016.01116")[10.3389\u{2f}fpsyg.2016.01116] #footnote(link("https://doi.org/10.3389/fpsyg.2016.01116"))

 #label("org151e4c8")3. Knox C, Wilson M, Klinger C, et al. DrugBank 6.0: the DrugBank Knowledgebase for 2024. #emph[Nucleic Acids Research]. 2024;52(D1):D1265\u{2d}D1275. doi:#link("https://doi.org/10.1093/nar/gkad976")[10.1093\u{2f}nar\u{2f}gkad976] #footnote(link("https://doi.org/10.1093/nar/gkad976"))

 #label("org5ef768d")4. WebMD \u{2d} Better information. Better health. WebMD. Accessed December 2, 2025. #link("https://www.webmd.com/")

 #label("orgab882d1")5. RxList \u{2d} The Internet Drug Index for prescription drug information, interactions, and side effects. RxList. Accessed December 2, 2025. #link("https://www.rxlist.com/")

 #label("orgf54a3e4")6. Drugs Comparison Index: Find Drug vs. Drug, Side Effects, Uses, Interactions, More. RxList. Accessed December 2, 2025. #link("https://www.rxlist.com/drugs_comparison/article.htm")

 #label("org4cde49a")7. 11000 Medicine details. Accessed December 2, 2025. #link("https://www.kaggle.com/datasets/singhnavjot2062001/11000-medicine-details")

 #label("org005ec54")8. team T pandas development. pandas\u{2d}dev\u{2f}pandas: Pandas. Published online September 30, 2025. doi:#link("https://doi.org/10.5281/zenodo.17229934")[10.5281\u{2f}zenodo.17229934] #footnote(link("https://doi.org/10.5281/zenodo.17229934"))

 #label("org6851de8")9. Shiny. Shiny. Accessed December 2, 2025. #link("https://shiny.posit.co/")
