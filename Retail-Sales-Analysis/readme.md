# 🛍️ Retail Sales Analysis (SQL + Dashboard Project)

This project analyzes retail sales data using SQL to discover customer patterns, sales performance, and opportunities for business growth. A future Power BI dashboard will visualize key metrics.

---

## 📁 Project Structure


---

## 🧰 Tools Used
- SQL (PostgreSQL / MySQL)
- GitHub for version control

---

## 🏗️ Database Setup
```sql
CREATE DATABASE sql_project_p2;
CREATE TABLE retail_sales (
    transaction_id INT PRIMARY KEY,
    sale_date DATE,
    sale_time TIME,
    customer_id INT,
    gender VARCHAR(15),
    age INT,
    category VARCHAR(15),
    quantity INT,
    price_per_unit FLOAT,
    cogs FLOAT,
    total_sale FLOAT
);
