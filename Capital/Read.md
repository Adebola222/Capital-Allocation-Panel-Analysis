# Panel Data Analysis: Determinants of Capital Allocation Decisions

## Overview
This project is conducted to explore the determinants of capital allocation decisions in three companies.
Through panel regression models and interaction term analyses, critical relationships between independent and dependent variables are examined, providing valuable insights into the factors influencing capital structures.

## Research Question
What factors determine how firms allocate capital, and do these effects vary across companies?
  
## Data
  - Three companies over 32 years
  - Variables: Interest rate (%), Stock price ($), Market cap ($), Capital structure (%), Revenue ($), Net income ($), interest expense ($), Cash ($)
  - Source: Confidential data

## Methods
- Pooled OLS regression
- Fixed effects (FE) model
- Random effects (RE) model
- Hausman specification test
- Robustness checks for heteroskedasticity and serial correlation

## Key Findings
# Descriptive
The mean interest rate across the sample period is approximately 2.50%, with a standard deviation of 2.20%, which shows a moderate variability in interest rates. Stock prices exhibit a wide range of values, with a mean of $62.25 and a standard deviation of $69.03, which shows a variation in equity market values. Market capitalization, representing the total market value of a company's outstanding shares, averages $32,297 million, with considerable dispersion observed around this mean value.
The capital structure, expressed as a percentage, reveals a mean of 58.34%. Its notable standard deviation of 82.08% underscores the substantial heterogeneity in the proportion of debt and equity financing across firms, indicating diverse financing strategies. Revenue and net income, as indicators of financial performance, show mean values of $18,200 million and $1,503 million, respectively. However, the wide dispersion in net income, as evidenced by the standard deviation of $6,939 million, suggests significant variability in profitability among the firms.
Interest expenses, which represent the cost of borrowing for the companies, have a mean of $316.1 million, with a standard deviation of $511.7 million, highlighting variability in financing costs.

# Pre-test
Model violates the assumption of homoskedasticity and the Hausman test revealed that fixed-effect regression model is adopted for our panel data analysis.

# Overall
Panel model shows no significant relationship but company-level shows contrasting relationships

## Tools
- **Software:** Stata
- **Main techniques:** Panel data econometrics

## Files
- `do file.do` - Data cleaning & panel regressions
- `results_tables.doc` - Regression output tables

