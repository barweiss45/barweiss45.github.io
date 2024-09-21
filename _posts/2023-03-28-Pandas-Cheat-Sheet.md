---
title: "Pandas Cheat Sheet"
layout: post
---

Pandas is a powerful Python library used for data manipulation and analysis. It provides flexible data structures, such as DataFrames, that allow you to easily work with structured data. Pandas is commonly used for data wrangling, cleaning, and performing various data operations in a fast and efficient way.

### Key Features:

- **Data manipulation:** Merge, filter, and transform data.
- **Data cleaning:** Handle missing data and duplicate records.
- **Data visualization:** Integrated with libraries like Matplotlib and Seaborn.
- **File I/O:** Read/write CSV, Excel, JSON, and more.

---

## Installation

To install Pandas, you can use `pip`:

```bash
pip install pandas
```

For Anaconda users, Pandas is already included, but you can update it using:

```bash
conda install pandas
```

---

## Typical Use Cases

- **Data cleaning:** Handling missing or duplicate data.
- **Data analysis:** Aggregating and summarizing large datasets.
- **Data transformation:** Reshaping and pivoting data for easy exploration.
- **File I/O:** Loading data from external sources such as CSV and Excel files.

---

## Importing Pandas

Before using Pandas, import it as follows:

```python
import pandas as pd
```

---

## Reading Data

- **From CSV:**

   ```python
   df = pd.read_csv('filename.csv')
   ```

- **From Excel:**

   ```python
   df = pd.read_excel('filename.xlsx')
   ```

---

## Basic Operations

- **Display first n rows:**

   ```python
   df.head(n)
   ```

- **Display last n rows:**

   ```python
   df.tail(n)
   ```

- **Summary statistics:**

   ```python
   df.describe()
   ```

- **Select a single column:**

   ```python
   df['column_name']
   ```

- **Select multiple columns:**

   ```python
   df[['column_name1', 'column_name2']]
   ```

- **Filter rows based on condition:**

   ```python
   df[df['column_name'] > value]
   ```

- **Sort by column:**

   ```python
   df.sort_values('column_name')
   ```

- **Group by column:**

   ```python
   df.groupby('column_name').mean()
   ```

---

## Data Cleaning

- **Check for missing values:**

   ```python
   df.isnull()
   ```

- **Drop rows with missing values:**

   ```python
   df.dropna()
   ```

- **Fill missing values:**

   ```python
   df.fillna(value)
   ```

- **Rename columns:**

   ```python
   df.rename(columns={'old_name': 'new_name'})
   ```

- **Drop a column:**

   ```python
   df.drop('column_name', axis=1)
   ```

- **Drop duplicate rows:**

   ```python
   df.drop_duplicates()
   ```

---

## Data Manipulation

- **Create a new column:**

   ```python
   df['new_column'] = df['column1'] + df['column2']
   ```

- **Apply a function to a column:**

   ```python
   df['column'] = df['column'].apply(function_name)
   ```

- **Replace values in a column:**

   ```python
   df['column'] = df['column'].replace(value1, value2)
   ```

- **Merge two DataFrames:**

   ```python
   merged_df = pd.merge(df1, df2, on='column_name')
   ```

- **Pivot a table:**

   ```python
   df.pivot(index='index_column', columns='column_to_pivot', values='values_to_show')
   ```
