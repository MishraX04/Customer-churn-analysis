# Customer Churn Analysis — Results & Insights

## Dataset Overview
- Total Customers: 7,043
- Total Columns: 21
- Tool Used: PostgreSQL + Power BI

---

## Query 1: Overall Churn Rate
**Business Question:** What percentage of customers are churning?
**Why This Query:** Baseline metric — every churn project starts here
**Concepts Used:** Window Function, OVER(), GROUP BY, ROUND

| Churn | Customers | Percentage |
|-------|-----------|------------|
| No    | 5,174     | 73.46%     |
| Yes   | 1,869     | 26.54%     |

**Insight:** 1 in every 4 customers left the company.
26.54% churn rate is very high in telecom industry.

**Recommendation:** Immediate retention strategy needed.

---

## Query 2: Contract Type vs Churn
**Business Question:** Which contract type has highest churn?
**Why This Query:** Contract type is strongest churn predictor
**Concepts Used:** CASE WHEN, SUM, GROUP BY, ORDER BY DESC

| Contract | Total | Churned | Churn Rate |
|----------|-------|---------|------------|
| Month-to-month | 3,875 | 1,655 | 42.71% |
| One year | 1,473 | 166 | 11.27% |
| Two year | 1,695 | 48 | 2.83% |

**Insight:** Month-to-month customers churn 15x more
than two-year contract customers.

**Recommendation:** Offer discounts to encourage
long-term contract signups.

---

## Query 3: Tenure Segments vs Churn
**Business Question:** Do newer customers churn more?
**Why This Query:** Understand customer lifecycle churn pattern
**Concepts Used:** Nested CASE WHEN, Segmentation,
Feature Engineering

| Segment | Total | Churned | Churn Rate |
|---------|-------|---------|------------|
| New (0-12 months) | 2,186 | 1,037 | 47.44% |
| Mid (13-24 months) | 1,024 | 294 | 28.71% |
| Mature (25-48 months) | 1,594 | 325 | 20.39% |
| Loyal (49+ months) | 2,239 | 213 | 9.51% |

**Insight:** First year is most critical — 47.44% churn.
Loyalty increases significantly over time.

**Recommendation:** Build first-year onboarding program.

---

## Query 4: Payment Method vs Churn
**Business Question:** Does payment method predict churn?
**Why This Query:** Payment behavior indicates engagement level
**Concepts Used:** CASE WHEN, GROUP BY, ORDER BY DESC

| Payment Method | Total | Churned | Churn Rate |
|----------------|-------|---------|------------|
| Electronic check | 2,365 | 1,071 | 45.29% |
| Mailed check | 1,612 | 308 | 19.11% |
| Bank transfer (auto) | 1,544 | 258 | 16.71% |
| Credit card (auto) | 1,522 | 232 | 15.24% |

**Insight:** Electronic check users churn 3x more
than auto-pay customers.

**Recommendation:** Incentivize auto-pay adoption
through bill discounts.

---

## Query 5: Internet Service vs Churn
**Business Question:** Which service type has highest churn?
**Why This Query:** Service quality directly impacts retention
**Concepts Used:** CASE WHEN, GROUP BY, ORDER BY DESC

| Service | Total | Churned | Churn Rate |
|---------|-------|---------|------------|
| Fiber optic | 3,096 | 1,297 | 41.89% |
| DSL | 2,421 | 459 | 18.96% |
| No internet | 1,526 | 113 | 7.40% |

**Insight:** Fiber optic customers churn most despite
paying premium prices — service quality issue.

**Recommendation:** Audit fiber optic service quality
and review pricing strategy.

---

## Query 6: High Risk Customers
**Business Question:** Which customers are most likely to churn?
**Why This Query:** Identify actionable target segment
**Concepts Used:** Multiple WHERE conditions, AND filters

| Filter | Value |
|--------|-------|
| Contract | Month-to-month |
| Tenure | 0-12 months |
| Payment | Electronic check |
| Service | Fiber optic |
| **Total** | **631 customers** |

**Insight:** 631 customers show all high-risk signals.
These are highest priority retention targets.

**Recommendation:** Immediate outreach to these
631 customers with targeted offers.

---

## Query 7: Gender vs Churn
**Business Question:** Does gender influence churn?
**Why This Query:** Test demographic churn drivers
**Concepts Used:** GROUP BY, ORDER BY DESC

| Gender | Total | Churned | Churn Rate |
|--------|-------|---------|------------|
| Female | 3,488 | 939 | 26.92% |
| Male | 3,555 | 930 | 26.16% |

**Insight:** Gender has almost NO impact on churn.
This tells company where NOT to focus budget.

**Recommendation:** Do not create gender-based
retention campaigns — waste of resources.

---

## Query 8: Senior Citizen vs Churn
**Business Question:** Do senior citizens churn more?
**Why This Query:** Demographic vulnerability analysis
**Concepts Used:** GROUP BY, ORDER BY DESC

| Senior | Total | Churned | Churn Rate |
|--------|-------|---------|------------|
| Yes | 1,142 | 476 | 41.68% |
| No | 5,901 | 1,393 | 23.61% |

**Insight:** Senior citizens churn 2x more.
May find service complex or too expensive.

**Recommendation:** Create simplified senior
citizen plans with dedicated support.

---

## Query 9: Average Charges — Churned vs Retained
**Business Question:** Are churned customers paying more?
**Why This Query:** Understand revenue profile of churners
**Concepts Used:** AVG, CAST, WHERE filter, GROUP BY

| Churn | Avg Monthly | Avg Total | Customers |
|-------|-------------|-----------|-----------|
| No | $61.31 | $2,555.34 | 5,163 |
| Yes | $74.44 | $1,531.80 | 1,869 |

**Insight:** Churned customers paid $13 MORE monthly
but left early. Problem is value, not price.

**Recommendation:** Improve service quality for
premium plan customers — they expect more.

---

## Query 10: Top 10 Highest Paying Churned Customers
**Business Question:** Who were our most valuable lost customers?
**Why This Query:** Quantify premium customer loss
**Concepts Used:** WHERE, ORDER BY DESC, LIMIT

**Insight:** 100% of top 10 highest paying churned
customers used Fiber optic service.
Tenure ranged 41-72 months — loyal customers left!

**Recommendation:** Fiber optic quality fix is
most urgent action — losing loyal premium customers.

---

## Query 11: Tenure + Contract Combo Analysis
**Business Question:** Which combination has highest churn?
**Why This Query:** Multi-factor analysis for deeper insight
**Concepts Used:** Nested CASE WHEN, Multi-column GROUP BY

| Segment | Contract | Churn Rate |
|---------|----------|------------|
| New (0-12) | Month-to-month | 51.35% |
| Mid (13-24) | Month-to-month | 37.72% |
| New (0-12) | Two year | 0.00% |
| Mid (13-24) | Two year | 0.00% |

**Insight:** New customers on month-to-month = 51.35%
Same customers on two-year = 0% churn.
Single most actionable finding in this analysis.

**Recommendation:** Offer new customers discounted
two-year contract at signup immediately.

---

## Query 12: Revenue at Risk
**Business Question:** How much revenue is company losing?
**Why This Query:** Quantify business impact of churn
**Concepts Used:** SUM, WHERE filter, Annual calculation

| Contract | Churned | Monthly Lost | Annual Lost |
|----------|---------|--------------|-------------|
| Month-to-month | 1,655 | $120,847 | $1,450,165 |
| One year | 166 | $14,118 | $169,421 |
| Two year | 48 | $4,165 | $49,983 |
| **TOTAL** | **1,869** | **$139,130** | **$1,669,570** |

**Insight:** Company losing $1.67M annually.
87% of loss from month-to-month contracts alone.

**Recommendation:** Converting 30% of month-to-month
to annual plans = $435K saved yearly.

---

## Query 13: Risk Scoring — Top 100 Customers
**Business Question:** Score customers by churn risk
**Why This Query:** Move beyond filtering to predictive scoring
**Concepts Used:** Weighted CASE WHEN, Risk Model

Scoring Model:
- Month-to-month contract = +2
- Tenure ≤ 12 months = +2
- Electronic check = +1
- Fiber optic = +2

**Insight:** Top 100 customers all scored 7/7.
Risk scoring enables prioritized outreach vs
simple filtering — stronger analytical approach.

---

## Query 14: RANK by Monthly Spend
**Business Question:** How do customers rank by spending?
**Why This Query:** Identify high-value customers at risk
**Concepts Used:** RANK(), OVER(), AVG OVER(),
Window Functions

**Insight:** Average monthly charge = $64.76.
High spenders ($65+) churn more than average.
Window functions enable per-row ranking without
losing other column data.

---

## Query 15: Retention Trend by Tenure
**Business Question:** How does churn change over time?
**Why This Query:** Understand customer lifecycle pattern
**Concepts Used:** GROUP BY tenure, Lifecycle Analysis

**Insight:** Clear downward churn trend as tenure increases.
Month 1-6: Highest churn risk.
Month 60+: Near zero churn.
This confirms first year is most critical period.

---

## Final Summary — Top Churn Drivers

| Rank | Driver | Churn Rate |
|------|--------|------------|
| 1 | New customer (0-12 months) | 47.44% |
| 2 | Electronic check payment | 45.29% |
| 3 | Month-to-month contract | 42.71% |
| 4 | Senior citizens | 41.68% |
| 5 | Fiber optic service | 41.89% |
| 6 | Gender | No impact |

## Overall Conclusion
Company should immediately focus on:
1. Promote long-term contracts at signup
2. Make first year special for new customers
3. Increase auto-pay adoption
4. Fix fiber optic service quality
5. Build senior citizen dedicated plans
6. Target 631 high-risk customers immediately

Revenue Recovery Potential: $311,580/year
(if 50% of high-risk customers retained)