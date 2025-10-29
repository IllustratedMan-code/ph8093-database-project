#!/usr/bin/env python
import pandas as pd
import sqlite3
import re


datasets = {
    "11000-medicines": {
        "url": "https://www.kaggle.com/datasets/singhnavjot2062001/11000-medicine-details",
        "raw-path": "data/raw/11000-medicines.csv",
    }}


composition_regex = re.compile(r"(\w+)\s*\((.*)\)")
def extract_composition(x):
    xl = x.split("+")
    components = []
    dosages = []
    for i in xl:
        m = composition_regex.search(i)
        if m:
            components.append(m[1])
            dosages.append(m[2])
    return components, dosages




meds = pd.read_csv(datasets["11000-medicines"]["raw-path"])
components = [extract_composition(x) for x in meds["Composition"]]
Meds_Components = {"Medicine Component ID":[], "Medicine Name":[], "Component Name":[], "Amount":[]}
for med_name, med_components in zip(meds["Medicine Name"], components):
    for component, amount in zip(*med_components):

        Meds_Components["Medicine Name"].append(med_name)
        Meds_Components["Component Name"].append(component)
        Meds_Components["Amount"].append(amount)
        Meds_Components["Medicine Component ID"].append(med_name + "||" + component) 

Meds_Components = pd.DataFrame(Meds_Components)
meds = meds.drop("Composition", axis=1)

Components = pd.DataFrame(Meds_Components["Component Name"].unique())

def extract_uses(x):
    treatment_regex = re.compile(r"Treatment of ([A-Za-z])")
    prevention_regex = re.compile(r"Prevention of ([A-Za-z])")
    treatment_prevention_regex = re.compile(r"Treatment and prevention of ([A-Za-z])")

    def replace_with_capture_group(match):
        return f" {match.group(1).upper()}"

    x = treatment_regex.sub(replace_with_capture_group, x)
    x = prevention_regex.sub(replace_with_capture_group, x)
    x = treatment_prevention_regex.sub(replace_with_capture_group, x)
    x = x.strip().split()

    diseases = []
    for i in x:
        if i[0].isupper():
            diseases.append([i])
        else:
            diseases[-1].append(i)
    return [" ".join(i) for i in diseases]


uses_list = [extract_uses(x) for x in meds["Uses"]]
Meds_Uses = {"Medicine Uses ID":[], "Medicine Name": [], "Use":[]}
for med_name, uses in zip(meds["Medicine Name"], uses_list):
    for use in uses:
        Meds_Uses["Medicine Uses ID"].append(med_name + "||" + use)
        Meds_Uses["Medicine Name"].append(med_name)
        Meds_Uses["Use"].append(use)
    
Meds_Uses = pd.DataFrame(Meds_Uses)

Uses = pd.DataFrame(Meds_Uses["Use"].unique())

meds = meds.drop("Uses", axis=1)



def extract_side_effects(x):
    x = x.strip().split()
    diseases = []
    for i in x:
        if i[0].isupper():
            diseases.append([i])
        else:
            diseases[-1].append(i)
    return [" ".join(i) for i in diseases]



side_effects_list = [extract_side_effects(x) for x in meds["Side_effects"]]
Meds_Side_effects = {"Medicine Side Effect ID":[], "Medicine Name":[], "Side Effect": []}
for med_name, side_effects in zip(meds["Medicine Name"], side_effects_list):
    for side_effect in side_effects:
        Meds_Side_effects["Medicine Side Effect ID"].append(med_name + "||" + side_effect)
        Meds_Side_effects["Medicine Name"].append(med_name)
        Meds_Side_effects["Side Effect"].append(side_effect)
Meds_Side_effects = pd.DataFrame(Meds_Side_effects)
Side_effects = pd.DataFrame(Meds_Side_effects["Side Effect"].unique())

meds = meds.drop("Side_effects", axis=1)

with sqlite3.connect("data/11000-medicines.db") as conn:
    meds.to_sql("Medications", conn, if_exists="replace", index=False)
    Meds_Components.to_sql("Medications_Components", conn, if_exists="replace", index=False)
    Components.to_sql("Components", conn, if_exists="replace", index=False)
    Meds_Uses.to_sql("Medications_Uses", conn, if_exists="replace", index=False)
    Uses.to_sql("Uses", conn, if_exists="replace", index=False)
    Meds_Side_effects.to_sql("Medications_Side_effects", conn, if_exists="replace", index=False)
    Side_effects.to_sql("Side_effects", conn, if_exists="replace", index=False)


