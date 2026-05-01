CREATE TABLE telco_churn (
    customerID VARCHAR(20),
    gender VARCHAR(10),
    SeniorCitizen INT,
    Partner VARCHAR(5),
    Dependents VARCHAR(5),
    tenure INT,
    PhoneService VARCHAR(5),
    MultipleLines VARCHAR(20),
    InternetService VARCHAR(20),
    OnlineSecurity VARCHAR(20),
    OnlineBackup VARCHAR(20),
    DeviceProtection VARCHAR(20),
    TechSupport VARCHAR(20),
    StreamingTV VARCHAR(20),
    StreamingMovies VARCHAR(20),
    Contract VARCHAR(20),
    PaperlessBilling VARCHAR(5),
    PaymentMethod VARCHAR(30),
    MonthlyCharges DECIMAL(10,2),
    TotalCharges VARCHAR(20),
    Churn VARCHAR(5)
);

SELECT * FROM telco_churn LIMIT 10;

SELECT COUNT(*) FROM telco_churn;

-- Overall Churn Rate
SELECT
Churn,
count(*) AS total_customers,
ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(),2) AS percentage
FROM telco_churn
Group by Churn;


--Contract Type vs Churn
SELECT 
    Contract,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned,
    ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS churn_rate
FROM telco_churn
GROUP BY Contract
ORDER BY churn_rate DESC;


--Tenure Segments vs Churn
SELECT 
    CASE 
        WHEN tenure <= 12 THEN 'New (0-12 months)'
        WHEN tenure <= 24 THEN 'Mid (13-24 months)'
        WHEN tenure <= 48 THEN 'Mature (25-48 months)'
        ELSE 'Loyal (49+ months)'
    END AS customer_segment,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned,
    ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS churn_rate
FROM telco_churn
GROUP BY 
    CASE 
        WHEN tenure <= 12 THEN 'New (0-12 months)'
        WHEN tenure <= 24 THEN 'Mid (13-24 months)'
        WHEN tenure <= 48 THEN 'Mature (25-48 months)'
        ELSE 'Loyal (49+ months)'
    END
ORDER BY churn_rate DESC;


--Payments Method vs Churn
SELECT 
    PaymentMethod,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned,
    ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS churn_rate
FROM telco_churn
GROUP BY PaymentMethod
ORDER BY churn_rate DESC;

--Internet Service vs Churn
SELECT 
    InternetService,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned,
    ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS churn_rate
FROM telco_churn
GROUP BY InternetService
ORDER BY churn_rate DESC;


--High Rish Customers
SELECT 
    customerID,
    tenure,
    Contract,
    PaymentMethod,
    InternetService,
    MonthlyCharges,
    Churn
FROM telco_churn
WHERE 
    Contract = 'Month-to-month'
    AND tenure <= 12
    AND PaymentMethod = 'Electronic check'
    AND InternetService = 'Fiber optic'
ORDER BY MonthlyCharges DESC;

--Gender vs Churn
SELECT 
    gender,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned,
    ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS churn_rate
FROM telco_churn
GROUP BY gender
ORDER BY churn_rate DESC;


--Senior Citize vs Churn
SELECT 
    SeniorCitizen,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned,
    ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS churn_rate
FROM telco_churn
GROUP BY SeniorCitizen
ORDER BY churn_rate DESC;


--Churned vs Retained
SELECT 
    Churn,
    ROUND(AVG(MonthlyCharges), 2) AS avg_monthly_charges,
    ROUND(AVG(CAST(TotalCharges AS DECIMAL)), 2) AS avg_total_charges,
    COUNT(*) AS total_customers
FROM telco_churn
WHERE TotalCharges != ' '
GROUP BY Churn;

-- TOP 10 Highest Paying Churned Customers
SELECT 
    customerID,
    MonthlyCharges,
    TotalCharges,
    Contract,
    tenure,
    InternetService
FROM telco_churn
WHERE Churn = 'Yes'
ORDER BY MonthlyCharges DESC
LIMIT 10;


-- Tenure + Contract Combo
SELECT 
    CASE 
        WHEN tenure <= 12 THEN 'New (0-12)'
        WHEN tenure <= 24 THEN 'Mid (13-24)'
        ELSE 'Mature (25+)'
    END AS tenure_group,
    Contract,
    COUNT(*) AS total,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned,
    ROUND(100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS churn_rate
FROM telco_churn
GROUP BY tenure_group, Contract
ORDER BY churn_rate DESC;


--Revenue at risk
SELECT 
    Contract,
    COUNT(*) AS churned_customers,
    ROUND(SUM(MonthlyCharges), 2) AS monthly_revenue_lost,
    ROUND(SUM(MonthlyCharges) * 12, 2) AS annual_revenue_lost
FROM telco_churn
WHERE Churn = 'Yes'
GROUP BY Contract
ORDER BY annual_revenue_lost DESC;

--Risk Score
SELECT 
    customerID,
    Contract,
    tenure,
    PaymentMethod,
    InternetService,
    MonthlyCharges,
    (CASE WHEN Contract = 'Month-to-month' THEN 2 ELSE 0 END +
     CASE WHEN tenure <= 12 THEN 2 ELSE 0 END +
     CASE WHEN PaymentMethod = 'Electronic check' THEN 1 ELSE 0 END +
     CASE WHEN InternetService = 'Fiber optic' THEN 2 ELSE 0 END
    ) AS risk_score
FROM telco_churn
WHERE Churn = 'No'
ORDER BY risk_score DESC
LIMIT 100;


-- Rank by Monthly Spend Window Function RANK()
SELECT 
    customerID,
    MonthlyCharges,
    Contract,
    InternetService,
    Churn,
    RANK() OVER (ORDER BY MonthlyCharges DESC) AS rank_by_spend,
    ROUND(AVG(MonthlyCharges) OVER(), 2) AS avg_monthly_charges,
    ROUND(MonthlyCharges - AVG(MonthlyCharges) OVER(), 2) AS diff_from_avg
FROM telco_churn
ORDER BY rank_by_spend;

--Retention Trend
SELECT 
    tenure,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned,
    SUM(CASE WHEN Churn = 'No' THEN 1 ELSE 0 END) AS retained,
    ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS churn_rate
FROM telco_churn
GROUP BY tenure
ORDER BY tenure;
