# 📂 Data: Transposition of EU Directives

This folder contains **CSV files with national transposition measures** (NIM) for a selection of directives linked to the European Green Deal and EU climate/energy legislation.  

Each file is named after the **CELEX number** of the directive, e.g. `transposition_32009L0028.csv`.

---

## 📑 File List

| EURLEX Code | Directive | Title | Link |
|-----------|-----------|-------|------|
| `32003L0096` | 2003/96/EC | Taxation of energy products and electricity | [EUR-Lex](https://eur-lex.europa.eu/eli/dir/2003/96/oj/eng) |
| `32004L0101` | 2004/101/EC | EU ETS – Kyoto project mechanisms | [EUR-Lex](https://eur-lex.europa.eu/eli/dir/2004/101/oj/eng) |
| `32009L0028` | 2009/28/EC | Promotion of renewable energy (RED I) | [EUR-Lex](https://eur-lex.europa.eu/legal-content/EN/ALL/?uri=CELEX:32009L0028) |
| `32009L0029` | 2009/29/EC | EU ETS reform | [EUR-Lex](https://eur-lex.europa.eu/eli/dir/2009/29/oj/eng) |
| `32010L0031` | 2010/31/EU | Energy performance of buildings (EPBD recast) | [EUR-Lex](https://eur-lex.europa.eu/eli/dir/2010/31/oj/eng) |
| `32018L0410` | 2018/410/EU | EU ETS & Market Stability Reserve | [EUR-Lex](https://eur-lex.europa.eu/eli/dir/2018/410/oj/eng) |
| `32018L0844` | 2018/844/EU | Amending EPBD and Energy Efficiency Directive | [EUR-Lex](https://eur-lex.europa.eu/eli/dir/2018/844/oj/eng) |
| `32018L2001` | 2018/2001/EU | Renewable Energy Directive (RED II) | [EUR-Lex](https://eur-lex.europa.eu/legal-content/EN/ALL/?uri=CELEX:32018L2001) |
| `32018L2002` | 2018/2002/EU | Energy Efficiency Directive (amending 2012/27/EU) | [EUR-Lex](https://eur-lex.europa.eu/legal-content/EN/ALL/?uri=CELEX:32018L2002) |
| `32023L0958` | 2023/958/EU | EU ETS – Aviation | [EUR-Lex](https://eur-lex.europa.eu/eli/dir/2023/958/oj/eng) |
| `32023L0959` | 2023/959/EU | EU ETS – Maritime & reforms | [EUR-Lex](https://eur-lex.europa.eu/eli/dir/2023/959/oj/eng) |
| `32023L1791` | 2023/1791/EU | Energy Efficiency Directive (recast) | [EUR-Lex](https://eur-lex.europa.eu/eli/dir/2023/1791/oj/eng) |
| `32023L2413` | 2023/2413/EU | Renewable Energy Directive (RED III) | [EUR-Lex](https://eur-lex.europa.eu/eli/dir/2023/2413/oj/eng) |
| `32024L1275` | 2024/1275/EU | Energy performance of buildings (EPBD recast) | [EUR-Lex](https://eur-lex.europa.eu/eli/dir/2024/1275/oj/eng) |

---

## 📊 Schema of the CSV files
Each `transposition_*.csv` file includes the following columns:

- `country` → ISO 3-letter code (e.g. FRA, DEU)  
- `act_number` → national implementing act identifier  
- `date_adopted` → adoption date of the national measure  
- `title` → short description of the act  
- `link` → EUR-Lex link to the national measure  

---

## 🔗 Source
All files were parsed/scraped from the **EUR-Lex National Implementing Measures (NIM)** pages for each directive.

⚠️ *Note: CSV files may be large. For reproducibility, instructions and scraping scripts are provided in the `code/` folder. Only cleaned or reduced datasets may be shared here to respect size and licensing constraints.*
