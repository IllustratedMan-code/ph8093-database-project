#let _ = ```typ
exec typst c "$0" --root "$(readlink -f "$0" | xargs dirname)/./"
⁠```
#set document(title: "Final Project Proposal", date: datetime(year: 2025, month: 10, day: 30), author: "David Lewis")
#set text(lang: "en")
#import "@local/assignments:1.0.0": conf
#show: doc => conf(title: context{document.title}, date: context{document.date}.display("[month repr:long] [day], [year]"), doc)
#outline()
#set heading(numbering: "1.")
#heading(level: 1)[Introduction] #label("orgb35e273")
#heading(level: 2)[Background] #label("orgfeb2164")
There are lots of medicines that do different things. It is hard for physicians to
pick between each of the different medications. Simplifying the list of medications is
therefore important to patient care.
#heading(level: 2)[Research questions] #label("org3b5f4c8")
#list(list.item[Which medications with the same compositions are the highest rated?])#list(list.item[How does the usage of the medication correlate with user reviews?])#list(list.item[How do side effects correlate?])#list(list.item[How can a physician easily browse for medications?])
#heading(level: 1)[Methods] #label("orgf6c7f52")
#heading(level: 2)[Data collection] #label("orgd141399")
The data were collected from Kaggle using the search term \u{22}medicine\u{22}. The dataset
is located at the following URL: #link("https://www.kaggle.com/datasets/singhnavjot2062001/11000-medicine-details")
#heading(level: 2)[Data Manipulation] #label("org3296cb1")
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
)]) #label("org4f81671")

#figure([#quote(block: true)[I\u{27}m hiding the #raw("Image URL") column here\u{22}
]]) #label("orgf8f11eb")

Some stats from the tables:
#heading(level: 3)[Medications table] #label("orgace22b3")
#figure([#table(columns: 2, [],[Unique Counts],
[Medicine Name],[11498],
[Image URL],[11740],
[Manufacturer],[759],
[Excellent Review %],[85],
[Average Review %],[79],
[Poor Review %],[81],
)]) #label("org75b536c")
#heading(level: 3)[Medications Uses Junction table] #label("org2787a35")
#figure([#table(columns: 2, [],[Unique Counts],
[Medicine Uses ID],[17811],
[Medicine Name],[11498],
[Use],[469],
)]) #label("org5d321b1")
#heading(level: 2)[SQL queries] #label("org7845cf3")
#list(list.item[Joins for Composition\u{2f}Uses\u{2f}Side effects tables])
#heading(level: 2)[Data analysis] #label("org61a120b")
#list(list.item[Statistical analysis to determine effect of Use\u{2f}Composition\u{2f}Side effects on Review])#list(list.item[Compare reviews of medicines with similar compositions (determine what \u{22}similar\u{22} means in this context)])
#heading(level: 2)[R Packages] #label("org98d47f6")
#heading(level: 3)[Statistical packages] #label("orge0fe12c")
#list(list.item[Tidyverse])#list(list.item[Plotly])

Pretty sure I can do all the statistical analysis I need to without any extra packages. Tidyverse is a family of data manipulation\u{2f}visualization tools and
plotly is for interactive visualization.
#heading(level: 3)[Shiny stuff] #label("org084f790")
#list(list.item[Shiny])#list(list.item[Shiny Router])#list(list.item[Box])

Shiny should be self\u{2d}explanatory, but shiny router and box allow for actual modularization within the R app (i.e. I don\u{27}t have to store everything in the same file).
#heading(level: 2)[Layout] #label("orga82f8ec")
1 tab for non\u{2d}interactive\u{2f}interactive data vizualization, another for browsing the data.
#heading(level: 2)[How can the proposed visualizations help answer the research questions?] #label("org5540ec2")
#list(list.item[The interactive data viewer will help physicians connect medications to symptoms\u{2f}reviews\u{2f}etc.])#list(list.item[Interactive\u{2f}non interactive visualizations may show how some medications may be really well received by some, but terrible for others])
