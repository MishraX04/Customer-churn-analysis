# Customer Churn Analysis — Telco Dataset

## Business Problem
Telecom companies face high customer churn leading 
to massive revenue leakage. This analysis identifies 
key churn drivers, segments high-risk customers, and 
quantifies revenue loss to support data-driven 
retention strategy.

## Tools Used
- PostgreSQL — 15 SQL Queries
- Power BI — 3-Page Interactive Dashboard
- Dataset: Widely used telecom churn dataset from Kaggle
- Records: 7,043 customers | 21 columns

---

## Methodology
1. Imported raw CSV into PostgreSQL database
2. Handled missing values in TotalCharges column
   using WHERE TotalCharges != ' ' filter
3. Defined churn as customers with Churn = "Yes"
4. Segmented customers by tenure, contract,
   payment method, and internet service
5. Built heuristic risk scoring model based on
   churn correlation strength observed in analysis
6. Validated insights using aggregation and
   window functions

---

## High Risk Customer Definition
Customers scored on 4 churn indicators:

| Risk Factor | Score |
|-------------|-------|
| Month-to-month contract | +2 |
| Tenure < 12 months | +2 |
| Electronic check payment | +1 |
| Fiber optic service | +2 |

Customers with score ≥ 5 flagged as HIGH RISK
Total identified: 631 customers

High-risk group showed ~58% churn rate vs 
26.54% overall — confirming strong predictive 
separation.

---

## Top 3 Core Insights

### 1. Contract Type is the Biggest Churn Driver
Month-to-month customers churn at 42.71% vs 
only 2.83% for two-year contracts — a 15x difference.
New customers on month-to-month = 51.35% churn.

### 2. First Year is Most Critical
Customers in first 12 months churn at 47.44%.
After 49+ months, churn drops to just 9.51%.
The first year defines customer lifetime value.

### 3. Payment Method Predicts Churn
Electronic check users churn at 45.29% vs 
15.24% for auto-pay customers — a 3x difference.
Manual payment = disengaged customer.

---

## Supporting Insights

| Analysis | Finding |
|----------|---------|
| Overall Churn Rate | 26.54% — 1 in 4 left |
| Fiber Optic Churn | 41.89% — service quality issue |
| Senior Citizen Churn | 41.68% — 2x higher than average |
| Gender Impact | Negligible (26.92% vs 26.16%) |
| High Paying Churned | $74/month vs $61 retained |
| Top 10 churned customers | 100% used Fiber optic |

---

## Revenue Impact

Revenue at risk calculated as:
SUM of monthly charges of churned customers × 12
(annual projection based on last known billing)

| Metric | Value |
|--------|-------|
| Monthly Revenue Lost | $139,130 |
| Annual Revenue Lost | $1,669,570 |
| High Risk Monthly Revenue | $51,930 |
| Recovery Potential (50% retained) | $311,580/year |
| High Risk % of Total Revenue at Risk | ~37% |

---

## SQL Queries (15 Total)

| Query | Business Question | Concept Used |
|-------|------------------|--------------|
| Q1 | Overall churn rate | Window Function, OVER() |
| Q2 | Contract vs churn | CASE WHEN, GROUP BY |
| Q3 | Tenure segments | Nested CASE WHEN |
| Q4 | Payment method | CASE WHEN, GROUP BY |
| Q5 | Internet service | GROUP BY, ORDER BY |
| Q6 | High risk 631 customers | Multiple WHERE filters |
| Q7 | Gender vs churn | GROUP BY |
| Q8 | Senior citizen vs churn | GROUP BY |
| Q9 | Avg charges analysis | AVG, CAST |
| Q10 | Top 10 churned customers | ORDER BY, LIMIT |
| Q11 | Tenure + contract combo | Multi-column GROUP BY |
| Q12 | Revenue at risk | SUM, Annual calculation |
| Q13 | Risk scoring top 100 | Weighted CASE WHEN |
| Q14 | RANK by spend | RANK(), OVER() |
| Q15 | Retention trend | Lifecycle Analysis |

---

## Power BI Dashboard (3 Pages)

**Page 1 — Executive Summary**
- 6 KPI Cards: Churn Rate, Total Customers,
  Total Churned, Revenue at Risk,
  High Risk Revenue, High Risk Customers (631)
- Charts: Contract, Internet Service, Tenure Segment
- Interactive Slicers: Contract, Tenure, Internet Service
- Key Insights + Recommendations Box

**Page 2 — Customer Analysis**
- Demographics: Gender, Senior Citizen
- Services: Tech Support, Online Security Impact
- Monthly Charges Bucket Analysis
- Tenure + Contract Combo Chart
- Slicers: Gender, Contract, Tenure Segment

**Page 3 — Revenue & Risk**
- High Risk Customers: 631
- High Risk Revenue: $51.93K/month
- Annual Revenue Lost: $1.67M
- Monthly Revenue Lost by Contract Chart
- Retention Trend Line Chart
- Avg Monthly Charges — Churned vs Retained
- Final Action Plan + Business Impact

---

## Business Recommendations

| Priority | Action | Expected Impact |
|----------|--------|----------------|
| HIGH | Target 631 high-risk customers | Save $311K/year |
| HIGH | Convert month-to-month to annual | Reduce churn ~8-10% |
| HIGH | Incentivize auto-pay adoption | 3x churn reduction |
| MEDIUM | First-year onboarding program | Reduce 47% new churn |
| MEDIUM | Fix fiber optic service quality | Retain premium customers |
| LOW | Senior citizen special plans | Address 41.68% churn |

---

## Interview Defense

**Q: How did you define high-risk customers?**
Used heuristic scoring model based on churn 
correlation strength. Four factors scored — 
customers with ≥5 points flagged as high risk.
This group showed ~58% churn vs 26.54% average.

**Q: How did you handle missing data?**
TotalCharges had blank spaces for new customers.
Handled using WHERE TotalCharges != ' ' in SQL.

**Q: Why these 4 churn indicators?**
Each showed 40%+ individual churn rate.
Combined they represent highest risk profile
observed in the analysis.

**Q: How did you calculate revenue at risk?**
SUM of monthly charges of churned customers × 12
for annual projection based on last known billing.

---

## Dataset
- Source: Kaggle — Telco Customer Churn (BlastChar)
- Link: https://www.kaggle.com/datasets/blastchar/telco-customer-churn
- Widely used telecom churn dataset from Kaggle
- 7,043 rows | 21 columns | No duplicates

---

## Conclusion
This project demonstrates how SQL and Power BI 
can be used together to identify churn drivers, 
quantify revenue risk, and support data-driven 
retention strategies. By combining 15 SQL queries 
with a 3-page interactive dashboard, this analysis 
moves beyond reporting to provide actionable 
business recommendations with measurable impact.
