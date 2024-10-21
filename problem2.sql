# The problem no2
# The marketing team wants to know how much can they spend on acquiring new customers to the platform. Therefore, they need to know how valuable an average customer is to us during their whole expected lifetime on the platform. Use the newly created presentation table and perform data analysis about Customer Lifetime Value (CLV).

# Import necessary libraries
import pandas as pd
import numpy as np

# Load the presentation_table data
presentation_table = pd.read_csv('presentation_table.csv')

# 1. Average Order Value (AOV)
# Calculate the average value of each order
average_order_value = presentation_table['order_amount'].mean()
print(f"Average Order Value (AOV): {average_order_value}")

# 2. Purchase Frequency (F)
# Group by customer_id and count the number of orders per customer
customer_order_count = presentation_table.groupby('customer_id')['order_id'].count()

# Calculate the average purchase frequency per customer
purchase_frequency = customer_order_count.mean()
print(f"Purchase Frequency (F): {purchase_frequency}")

# 3. Customer Lifespan (T)
# Convert order_date to datetime if it's not already
presentation_table['order_date'] = pd.to_datetime(presentation_table['order_date'])

# Group by customer_id and calculate the first and last order date for each customer
customer_lifespan = presentation_table.groupby('customer_id').agg(
    first_order=('order_date', 'min'),
    last_order=('order_date', 'max'))

# Calculate the lifespan in months (or days) as the difference between the first and last order date
customer_lifespan['lifespan_days'] = (customer_lifespan['last_order'] - customer_lifespan['first_order']).dt.days

# Calculate the average customer lifespan in months (using days/30.4 as approx for months)
average_customer_lifespan = customer_lifespan['lifespan_days'].mean() / 30.4
print(f"Average Customer Lifespan (T) in months: {average_customer_lifespan}")

# 4. Calculate Customer Lifetime Value (CLV)
# CLV = AOV * F * T
CLV = average_order_value * purchase_frequency * average_customer_lifespan
print(f"Customer Lifetime Value (CLV): {CLV}")

# Summary of results
print(f"Summary of Customer Lifetime Value Analysis:")
print(f"  - Average Order Value (AOV): {average_order_value}")
print(f"  - Purchase Frequency (F): {purchase_frequency}")
print(f"  - Average Customer Lifespan (T): {average_customer_lifespan} months")
print(f"  - Expected Customer Lifetime Value (CLV): {CLV}")
