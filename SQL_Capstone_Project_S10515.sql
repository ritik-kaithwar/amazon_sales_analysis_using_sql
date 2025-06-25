# CREATION OF THE DATABASE 

# SQL Capstone Project
# Amazon Sales Data 

Create database Amazondb;
use amazondb;
Create table Amazon (
                            Invoice_id varchar(30) not null,
                            Branch varchar(5) not null,
                            City varchar(30) not null,
                            Customer_Type varchar(30) not null,
                            Gender varchar(10) not null,
                            Product_Line varchar(100) not null,
                            Unit_Price decimal(10,2) not null,
                            Quantity int not null,
                            VAT float not null,
                            Total decimal(10,2) not null,
                            Date Date not null,
                            Time Time not null,
                            Payment_method varchar(100) not null,
                            COGS decimal(10,2) not null,
                            Gross_Margin_Percentage float not null,
                            Gross_Income decimal(10,2) not null,
                            Rating float not null
                            );                            



# DATA UNDERSTANDING

# Preview
Select * from amazon
limit 10;

# Description 
Describe amazon;


# BUSINESS PROBLEMS TO BE ADDRESSED :-

use amazondb;

# Q1. What is the count of distinct cities in the dataset?
Select count(distinct(City)) as Distinct_Cities from amazon;

# Q2. For each branch, what is the corresponding city?
Select distinct(Branch),City from amazon ;

# Q3. What is the count of distinct product lines in the dataset?
Select count(distinct(Product_line)) as Distinct_Product_Lines from amazon;

# Q4. Which payment method occurs most frequently?
Select Payment_method,count(Payment_method) as Occurence_Count from amazon 
group by Payment_method
order by Occurence_Count desc;

# Q5. Which product line has the highest sales?
Select Product_line, sum(Quantity) as Quantity_Ordered, 
Rank() over(Order by sum(Quantity) desc) as Ranking from amazon 
group by Product_line;

# Q6. How much revenue is generated each month?
Select monthname(Date) as Month, sum(Total) as Revenue from amazon 
group by monthname(Date) 
order by sum(Total) desc;

# Q7. In which month did the cost of goods sold reach its peak?
Select monthname(date) as Month, max(cogs) as Peak_COGS from amazon
group by monthname(date)
order by max(cogs) desc
limit 1;

# Q8. Which product line generated the highest revenue?
Select Product_line, sum(Total) as Revenue, 
Rank() over(Order by sum(Total) desc) as Ranking from amazon 
group by Product_line;

# Q9. In which city was the highest revenue recorded?
Select City,sum(Total) as Revenue, 
Rank() over(order by sum(Total) desc) from amazon 
group by city;

# Q10. Which product line incurred the highest Value Added Tax?
Select Product_Line, round(sum(VAT),2) as Highest_Vaue from amazon 
group by Product_Line 
order by sum(VAT) desc;

# Q11. For each product line, add a column indicating "Good" if its sales are above average, otherwise "Bad."
Select Product_Line, sum(Total) as Sales,
Case
     When sum(Total)>54000 Then "Good"
     When sum(Total)<50000 Then "Bad"
     Else "Average"
End as "Product_Line_Category"
from amazon 
group by Product_line;

# Q12. Identify the branch that exceeded the average number of products sold.
Select Branch,sum(Quantity) as Units_Sold from amazon 
group by branch
having sum(Quantity)>(Select avg(Sum_branch) from 
                                           (select sum(Quantity) as Sum_Branch from amazon 
                                           group by branch) as Av_Br);
                                           
# Q13. Which product line is most frequently associated with each gender?
use amazondb;
With Ranked_Gender_Product as (
Select Gender,Product_line,count(Product_line) as Product_Count,
Dense_Rank() over(partition by Gender order by count(Product_line) desc) as Ranking from amazon 
Group by Gender, Product_line 
)
Select * from Ranked_Gender_Product
where Ranking=1;

# Q14. Calculate the average rating for each product line.
Select Product_line, round(avg(Rating),2) as Average_rating from amazon 
group by Product_line;

# Q15. Count the sales occurrences for each time of day on every weekday.
Select dayname(Date) as Day, hour(time) as Hour, 
count(Invoice_id) as Sale_Occurence, 
Dense_Rank() over(partition by dayname(Date) order by count(Invoice_id) desc) as Rankings from amazon
group by dayname(Date), Hour(Time);

# Q16. Identify the customer type contributing the highest revenue. 
With Customer as (
Select Customer_Type, sum(Total) as Revenue,
Rank() over (Order by sum(Total) desc) as Ranking from amazon 
group by Customer_Type)
Select Customer_Type, Revenue from Customer
where ranking=1;

# Q17. Determine the city with the highest VAT percentage.
With High_VAT as (
Select city, round(sum(VAT),2) as Highest_VAT, Rank() over (order by sum(VAT) desc) as Ranking from amazon
group by city
)
Select * from High_VAT 
where Ranking=1;

# Q18. Identify the customer type with the highest VAT payments.
Select Customer_Type, round(sum(VAT),2) as Highest_VAT_Payments from amazon 
group by Customer_Type 
order by sum(VAT) desc
limit 1;

# Q19. What is the count of distinct customer types in the dataset?
Select count(distinct(customer_Type)) as Distinct_Cus_Count from amazon;

# Q20. What is the count of distinct payment methods in the dataset?
Select count(distinct(Payment_Method)) as Distinct_Payment_Method from amazon;

# Q21. Which customer type occurs most frequently?
Select Customer_Type, count(Invoice_id) as Occurence_Count from amazon 
group by Customer_Type 
order by count(Invoice_id) desc
limit 1;

# Q22. Identify the customer type with the highest purchase frequency.
With Cus_Frequency as
(
Select Customer_Type, count(Invoice_id) as Purchase_Frequency,
Rank() over (order by count(Invoice_id) desc) as Ranking from amazon 
group by Customer_Type
)
Select * from Cus_Frequency
where Ranking = 1;

# Q23. Determine the predominant gender among customers. 
Select Gender, count(Invoice_id) as Predominant_count from amazon 
group by Gender 
order by count(Invoice_id) desc 
limit 1;

# Q24. Examine the distribution of genders within each branch.
Select Branch, Gender, count(Gender) as Gender_count from amazon 
group by Branch, Gender
order by Branch;

# Q25. Identify the time of day when customers provide the most ratings.
Select hour(Time) as Hour_of_Day, count(Rating) as Rating_Count,
case 
when hour(Time) between 6 and 12 then "Morning"
when hour(Time) between 12 and 16 then "Noon"
when hour(Time) between 17 and 20 then "Evening"
else "Night"
End as Time_of_Day
from amazon 
group by hour(Time), Time_of_Day 
order by count(Rating) desc;

# Q26. Determine the time of day with the highest customer ratings for each branch.
With Cus_Ratings as
(
Select Branch, hour(Time) as Hour, count(Rating) as Rating_Count,
dense_rank() over (partition by Branch order by count(Rating) desc) as Ranking, case 
when hour(Time) between 6 and 12 then "Morning"
when hour(Time) between 12 and 16 then "Noon"
when hour(Time) between 17 and 20 then "Evening"
else "Night"
End as Time_of_Day from amazon
group by Branch, hour(Time), Time_of_Day
)
Select * from Cus_Ratings 
where Ranking=1;

# Q27. Identify the day of the week with the highest average ratings. 
Select dayname(Date) as Day, round(avg(rating),2) as Average_Rating from amazon 
group by Day
order by avg(rating) desc
limit 1;

# Q28. Determine the day of the week with the highest average ratings for each branch.
With Average_Rating as 
(
Select Branch, dayname(Date) as Day, round(avg(Rating),2) as Avg_Rating,
Rank() over (partition by Branch order by avg(Rating) desc) as Ranking 
from amazon 
group by Branch, Day 
)
Select * from Average_Rating
where Ranking=1;
