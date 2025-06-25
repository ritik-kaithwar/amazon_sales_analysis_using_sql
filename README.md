# Amazon Sales Data Analysis | SQL Capstone Project
  
**Tools Used:** MySQL Workbench  
**Dataset:** Amazon.csv (1,000 transaction records)

---

## Objective

The objective of this project is to explore and analyze Amazon sales data to identify trends and derive business insights related to revenue, customer behavior, product performance, and operational efficiency.

---

## Dataset Overview

The dataset contains transactional-level data with the following key fields:

- `Invoice_id` – Transaction ID  
- `Branch`, `City` – Store location identifiers  
- `Customer_Type`, `Gender` – Customer attributes  
- `Product_Line` – Product category  
- `Unit_Price`, `Quantity`, `Tax 5%`, `Total` – Sales figures  
- `Date`, `Time` – Time of transaction  
- `Payment_Method` – Mode of payment  
- `COGS`, `Gross_Income`, `Rating` – Financial and customer satisfaction metrics

---

## Database Schema


CREATE TABLE Amazon (
    Invoice_id VARCHAR(30) NOT NULL,
    Branch VARCHAR(5) NOT NULL,
    City VARCHAR(30) NOT NULL,
    Customer_Type VARCHAR(30) NOT NULL,
    Gender VARCHAR(10) NOT NULL,
    Product_Line VARCHAR(100) NOT NULL,
    Unit_Price DECIMAL(10,2) NOT NULL,
    Quantity INT NOT NULL,
    VAT FLOAT NOT NULL,
    Total DECIMAL(10,2) NOT NULL,
    Date DATE NOT NULL,
    Time TIME NOT NULL,
    Payment_method VARCHAR(100) NOT NULL,
    COGS DECIMAL(10,2) NOT NULL,
    Gross_Margin_Percentage FLOAT NOT NULL,
    Gross_Income DECIMAL(10,2) NOT NULL,
    Rating FLOAT NOT NULL
);

---

## Key Insights
- **Top revenue month**: March

- **Best-performing product line**: Food and beverages

- **Most common payment method**: Ewallet

- **Highest grossing city**: Naypyitaw

- **Highest-rated time**: Evening (5 PM–8 PM)

- **High-contribution customer type**: Member customers

---

##  Business Questions Answered
This project answers 28 SQL business questions categorized into:

 - **Branch & City Insights**

 - **Product Line Performance**

 - **Customer & Gender Behavior**

 - **Payment & Revenue Patterns**

 - **Time & Rating Trends**

---

##  Recommendations

- Promote best-selling branches and product lines

- Investigate low-rated categories for improvement

- Customize offers based on time and customer type

- Optimize inventory based on purchase frequency