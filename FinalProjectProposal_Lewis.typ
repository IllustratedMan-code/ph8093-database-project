#let _ = ```typ
exec typst c "$0" --root "$(readlink -f "$0" | xargs dirname)/./" --input file-2=/assets/mockup2.png --input file-1=/assets/mockup1.svg --input file-0=/erdiagram.png
⁠```
#set document(title: "Final Project Proposal", date: datetime(year: 2025, month: 10, day: 30), author: "David Lewis")
#set text(lang: "en")
#import "@local/assignments:1.0.0": conf
#show: doc => conf(title: context{document.title}, date: context{document.date}.display("[month repr:long] [day], [year]"), doc)
#outline()
#set heading(numbering: "1.")
#heading(level: 1)[Introduction] #label("orgd41989a")
#heading(level: 2)[Background] #label("orgcbfcda2")
There are lots of medicines that do different things. It is hard for physicians to
pick between each of the different medications. Simplifying the list of medications is
therefore important to patient care.
#heading(level: 2)[Research questions] #label("org2a41eb4")
#list(list.item[Which medications with the same compositions are the highest rated?])#list(list.item[How does the usage of the medication correlate with user reviews?])#list(list.item[How do side effects correlate?])#list(list.item[How can a physician easily browse for medications?])
#heading(level: 1)[Methods] #label("orgd5fe110")
#heading(level: 2)[Data collection] #label("org0d8464c")
The data were collected from Kaggle using the search term \u{22}medicine\u{22}. The dataset
is located at the following URL: #link("https://www.kaggle.com/datasets/singhnavjot2062001/11000-medicine-details")
#heading(level: 2)[Data Manipulation] #label("orgb7b159b")
The data was originally a single CSV. There were many \u{22}many\u{2d}to\u{2d}many\u{22} relationships, which I\u{27}ve
extracted (reverse group\u{2d}by?) into separate tables.

The Medications table is shown below:


#figure([#table(columns: 6, [],[Medicine Name],[Manufacturer],[Excellent Review %],[Average Review %],[Poor Review %],
[0],[Avastin 400mg Injection],[Roche Products India Pvt Ltd],[22],[56],[22],
[1],[Augmentin 625 Duo Tablet],[Glaxo SmithKline Pharmaceuticals Ltd],[47],[35],[18],
[2],[Azithral 500 Tablet],[Alembic Pharmaceuticals Ltd],[39],[40],[21],
[3],[Ascoril LS Syrup],[Glenmark Pharmaceuticals Ltd],[24],[41],[35],
[4],[Aciloc 150 Tablet],[Cadila Pharmaceuticals Ltd],[34],[37],[29],
[5],[Allegra 120mg Tablet],[Sanofi India Ltd],[35],[42],[23],
[6],[Avil 25 Tablet],[Sanofi India Ltd],[40],[34],[26],
[7],[Aricep 5 Tablet],[Eisai Pharmaceuticals India Pvt Ltd],[43],[28],[29],
[8],[Amoxyclav 625 Tablet],[Abbott],[36],[43],[21],
[9],[Atarax 25mg Tablet],[Dr Reddy\u{27}s Laboratories Ltd],[35],[41],[24],
[10],[Azee 500 Tablet],[Cipla Ltd],[37],[38],[25],
)]) #label("org6e29d84")

#figure([#quote(block: true)[I\u{27}m hiding the #raw("Image URL") column here\u{22}
]]) #label("org416121c")

Some stats from the tables:
#heading(level: 3)[Medications table] #label("org0a3d8ae")
#figure([#table(columns: 2, [],[Unique Counts],
[Medicine Name],[11498],
[Image URL],[11740],
[Manufacturer],[759],
[Excellent Review %],[85],
[Average Review %],[79],
[Poor Review %],[81],
)]) #label("org86bc3a2")
#heading(level: 3)[Medications Uses Junction table] #label("orgf9d3379")
#figure([#table(columns: 2, [],[Unique Counts],
[Medicine Uses ID],[17811],
[Medicine Name],[11498],
[Use],[469],
)]) #label("org2ab24d3")
#heading(level: 2)[ER diagram] #label("orgabc889e")
#figure([#image(sys.inputs.file-0)]) #label("org05bcee4")

This ER diagram makes sense because the original dataset in csv had columns that were
lists with non\u{2d}unique elements, i.e. a many\u{2d}to many relationship. This database takes those
columns and extracts the columns as their own tables, connecting them via a junction table.
#heading(level: 2)[Data analysis] #label("org3f2d495")
#list(list.item[Statistical analysis to determine effect of Use\u{2f}Composition\u{2f}Side effects on Review])#list(list.item[Compare reviews of medicines with similar compositions (determine what \u{22}similar\u{22} means in this context)])
#heading(level: 2)[R Packages] #label("orgb1c7728")
#heading(level: 3)[Statistical packages] #label("orga52ff2f")
#list(list.item[Tidyverse])#list(list.item[Plotly])

Pretty sure I can do all the statistical analysis I need to without any extra packages. Tidyverse is a family of data manipulation\u{2f}visualization tools and
plotly is for interactive visualization.
#heading(level: 3)[Shiny stuff] #label("orge792016")
#list(list.item[Shiny])#list(list.item[Shiny Router])#list(list.item[Box])

Shiny should be self\u{2d}explanatory, but shiny router and box allow for actual modularization within the R app (i.e. I don\u{27}t have to store everything in the same file).
#heading(level: 2)[Interactive Visualizations] #label("org385f9f9")
#list(list.item[Searchable histogram (i.e. histogram changes)
for each component\u{27}s dosages])#list(list.item[Searchable component to review histogram])
#heading(level: 2)[Layout] #label("org82f0b4e")
1 tab for non\u{2d}interactive\u{2f}interactive data vizualization, another for browsing the data.

#figure([#quote(block: true)[I\u{27}m not really sure #emph[which] plots I\u{27}m using yet, but there will be plots on the first page, data browser on the second
]]) #label("org10718ea")
#heading(level: 3)[Page 1] #label("org173cd87")
#figure([#image(sys.inputs.file-1)]) #label("org89bf723")
#heading(level: 3)[Page 2] #label("org165d4c6")
#figure([#image(sys.inputs.file-2)]) #label("org5aa54cd")
#heading(level: 2)[non\u{2d}interactive visualizations (ggplot\u{2f}plotly)] #label("org779106b")
In general, these will be visualizations for the entirety of the data
#list(list.item[Some sort of scatter plot showing relationships between medications (UMAP\u{2f}PCA) based
on various metrics (need to define similarity metric)])#list(list.item[Will try to use plotly for everything, since it allows for interactive inspection of points])

#figure([#quote(block: true)[I have some other ideas for this, but nothing super detailed yet.
]]) #label("org352f312")
#heading(level: 2)[Filters] #label("orgc3146a9")
#list(list.item[I\u{27}m not going to filter the data at all, since there is no statistical score to do so with, i.e. p value.])
#heading(level: 2)[How proposed visualizations help answer the research questions?] #label("org3074bdc")
#list(list.item[The interactive data viewer will help physicians connect medications to symptoms\u{2f}reviews\u{2f}etc.])#list(list.item[Interactive\u{2f}non interactive visualizations may show how some medications may be really well received by some, but terrible for others])#list(list.item[UMAP\u{2f}PCA plot may show distinct groups of medicines in terms of side effect, uses, etc. May be able to select alternative medications
based on groups.])
