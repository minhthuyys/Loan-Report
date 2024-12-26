SELECT * FROM bank_loan_db

/*find total number of loan application*/
SELECT COUNT(id) as total_num_loan_app FROM bank_loan_db

/*find MTD loan application
SELECT COUNT(id) AS Total_Applications FROM bank_loan_db
WHERE MONTH(issue_date) = 12

find PMTD loan application
SELECT COUNT(id) AS Total_Applications FROM bank_loan_db
WHERE MONTH(issue_date) = 11
*/

/*find total funded amount*/
SELECT SUM(loan_amount) AS Total_Funded_Amount FROM bank_loan_db
/*find total amount recieved*/
SELECT SUM(total_payment) AS Total_Amount_Collected FROM bank_loan_db
/*find average interested rate*/
SELECT AVG(int_rate)*100 AS Avg_Int_Rate FROM bank_loan_db
/*find average DTI*/
SELECT AVG(dti)*100 AS Avg_DTI FROM bank_loan_db

/*find good loan percentage*/
SELECT
    (COUNT(CASE WHEN loan_status = 'Fully Paid' OR loan_status = 'Current' THEN id END) * 100.0) / 
	COUNT(id) AS Good_Loan_Percentage
FROM bank_loan_db

/*find good loan applications*/
SELECT COUNT(id) AS Good_Loan_Applications FROM bank_loan_db
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current'

/*find bad loan percentage*/
SELECT
    ROUND((COUNT(CASE WHEN loan_status = 'Charged Off' THEN id END) * 100.0) / 
	COUNT(id),2) AS Bad_Loan_Percentage
FROM bank_loan_db

/*find loan amount, total_amonut_received, total fund amount, int_rate, DTI percentage*/
SELECT
        loan_status,
        COUNT(id) AS LoanCount,
        SUM(total_payment) AS Total_Amount_Received,
        SUM(loan_amount) AS Total_Funded_Amount,
        ROUND(AVG(int_rate * 100),2) AS Interest_Rate,
        ROUND(AVG(dti * 100),2) AS DTI
    FROM
        bank_loan_db
    GROUP BY
        loan_status

		/* total loan applicatioms, funded amount, recieved amount over issue date */
SELECT 
	MONTH(issue_date) AS Month_Number, 
	DATENAME(MONTH, issue_date) AS Month_name, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_db
GROUP BY MONTH(issue_date), DATENAME(MONTH, issue_date)
ORDER BY MONTH(issue_date)

/* total loan applicatioms, funded amount, recieved amount by purpose */
SELECT 
	purpose AS PURPOSE, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_db
WHERE grade = 'A'
GROUP BY purpose
ORDER BY purpose
