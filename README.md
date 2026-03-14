# Panel Data Analysis: Determinants of Capital Allocation Decisions

## Research Overview
This project investigates how macroeconomic conditions (interest rates) and firm-level financial characteristics shape capital allocation decisions across three major industrial firms over three decades. Using panel econometric methods, I examine whether the determinants of capital structure are homogeneous across firms or whether firm-specific heterogeneity matters.

**Research Question:** What factors determine corporate capital allocation, and do these relationships vary systematically across firms with different financial profiles?

## Motivation & Contribution
While extensive literature examines capital structure determinants, most studies assume homogeneous effects across firms. This project tests that assumption directly by:
1. Comparing pooled, firm-invariant models with firm-specific specifications
2. Examining interaction effects between interest rates and firm characteristics
3. Conducting company-level analysis to uncover heterogeneity masked in aggregate models

## Data
- **Sample:** 3 companies over 32 years (balanced panel)
- **Key variables:**
  - *Dependent:* Capital structure (% debt/equity mix)
  - *Primary independent:* Interest rate (%)
  - *Controls:* Stock price, market cap, revenue, net income, interest expense, cash holdings
- **Source:** Confidential company financial statements

## Econometric Methodology

### Model Specification
I estimate variants of:

`Capital_Struct_ it = β₁InterestRate_it + X_it'γ + α_i + λ_t + ε_it`

where α_i captures time-invariant firm heterogeneity and λ_t captures common time shocks.

### Estimation Strategy
1. **Pooled OLS** (baseline, assumes no firm heterogeneity)
2. **Fixed Effects (FE)** (controls for time-invariant unobservables)
3. **Random Effects (RE)** (efficient if heterogeneity is uncorrelated with regressors)

### Diagnostic Testing
| Test | Purpose | Result | Implication |
|------|---------|--------|-------------|
| **Modified Wald** | Heteroskedasticity in FE | χ² = 31840.49 (p=0.000) | Severe heteroskedasticity → robust SEs |
| **Breusch-Pagan LM** | Heteroskedasticity in RE | χ² = 1.00 (p=0.000) | Heteroskedasticity present |
| **Hausman** | FE vs RE specification | χ² = 24.90 (p=0.0004) | FE preferred (RE inconsistent) |
| **Breusch-Pagan LM (CD)** | Cross-sectional dependence | χ² = 6.259 (p=0.0997) | No cross-sectional dependence |
| **Wooldridge** | Autocorrelation | F(1,2)=47.649 (p=0.0203) | Autocorrelation present |

### Interaction Analysis
To explore heterogeneity, I estimate models interacting interest rates with:
- **Capital expenditure (Capex) intensity**
- **Free cash flow (FCF) levels**
- **Cash holdings**

## Key Findings

### 1. Aggregate Results (All Firms Pooled)
| Model | Interest Rate Effect | Key Controls | Model Fit |
|-------|---------------------|--------------|-----------|
| Pooled OLS | 0.607 (n.s.) | Stock price (+), Revenue (+), Market cap (-) | - |
| Fixed Effects | -0.616 (n.s.) | Revenue (+) | R² = 0.125 |
| Random Effects | 0.607 (n.s.) | Stock price (+), Revenue (+), Market cap (-) | - |

**Interpretation:** At the aggregate level, interest rates show no statistically significant relationship with capital structure once firm heterogeneity is controlled (FE model). Revenue emerges as the most robust predictor.

### 2. Heterogeneity Through Interactions

**Capex-Intensive Firms:**
- Interest rate × Capex: β = 0.687 (n.s.)
- Net income loses significance when interacted with Capex
- Suggests investment intensity doesn't modify interest rate sensitivity

**High-Cash Firms:**
- Cash × Net income: β = 1.09e-05 (p < 0.001)
- Cash × Market cap: β = -3.04e-07 (p < 0.05)
- Interpretation: Cash-rich firms show different sensitivity to profitability and size

### 3. Firm-Level Heterogeneity (Critical Finding)

**Deere & Co. (Manufacturing)**
- Interest rate → negative effect on Capex (β = -2.350, p < 0.05)
- Interest rate → negative effect on FCF (β = -2.144, p < 0.001)
- **Story:** Capital-intensive manufacturer cuts investment when borrowing costs rise

**Allstate (Insurance)**
- Interest rate → positive effect on Capex (β = 0.528, p < 0.05)
- Interest expense → positive effect on cash holdings (β = 0.250, p < 0.001)
- **Story:** Financial firm behaves differently—may increase investment when rates rise (yield-seeking?)

**General Motors (Automotive)**
- Interest rate → no significant effects on any capital measure
- Net income → negative effect on cash (β = -0.271, p < 0.01)
- **Story:** Large industrial with complex financing shows muted interest rate sensitivity

## Methodological Takeaways
1. **Pooled models mask heterogeneity**—firm-level analysis reveals opposite-signed effects across companies
2. **Diagnostic testing matters**—heteroskedasticity and autocorrelation require robust inference
3. **Interaction effects** provide partial insight but firm-specific models tell the complete story
4. **Fixed effects with robust standard errors** is the preferred specification given Hausman test results

## Tools
- **Software:** Stata 17
- **Key commands:** xtreg, xttest0, xttest3, xtcsd, xtserial, hausman
- **Robustness:** Robust standard errors, cluster by firm

## Repository Contents
- `do file.do` - Complete replication do-file (data cleaning → estimation → tables)
- `results_tables.docx` - Full regression output with all specifications
- `data/` - (Confidential, not included)

