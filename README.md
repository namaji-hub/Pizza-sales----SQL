## **Pizza Sales Analysis Project**  
**Insights and Strategies Through Oracle SQL Developer**

### **Introduction**  
The **Pizza Sales Analysis** project analyzes pizza order data to uncover insights on sales patterns, popular pizza types, and revenue trends. Using **Oracle SQL Developer**, SQL queries were written to compute business metrics such as total orders, revenue, and customer preferences, supporting strategic decision-making.

### **Project Overview**  
This project analyzes pizza sales data stored in four relational tables:  
- **Pizzas:** Pizza details (ID, type, size, price).  
- **Pizza Types:** Information about pizza categories and ingredients.  
- **Orders:** Order date and time details.  
- **Order Details:** Specifics like quantity and pizza type per order.  

By deriving metrics like revenue and trends, the project aims to improve sales and customer satisfaction.

### **Database Schema**  
1. **Pizzas Table:**  
   - Columns: Pizza ID, Pizza Type ID, Pizza Size, Price.  

2. **Pizza Types Table:**  
   - Columns: Pizza Type ID, Name, Category, Ingredients.  

3. **Orders Table:**  
   - Columns: Order ID, Order Date, Order Time.  

4. **Order Details Table:**  
   - Columns: Order Detail ID, Order ID, Pizza ID, Quantity.  

### **Data Cleaning and Preparation**  
To ensure accurate analysis, the following steps were taken:  
- **Duplicate removal** to maintain data integrity.  
- **Error correction** for consistency.  
- **Standardized formatting** for uniformity in the database.  

Proper preparation allowed reliable and actionable SQL queries.  

### **Advanced SQL Techniques Used**  
1. **Aggregation Functions:**  
   - COUNT, SUM, AVG, and ROUND for computing metrics.  

2. **Filtering:**  
   - WHERE clauses to isolate relevant data.  

3. **Joins and Grouping:**  
   - JOIN operations to link tables.  
   - GROUP BY clauses for summarizing data.  

4. **Advanced Functions:**  
   - Window functions like RANK and PARTITION for detailed trend analysis.  

### **Strategic Recommendations**  
From the insights derived, the following actions are suggested:  
- **Highlight popular pizza types** to boost revenue.  
- **Launch targeted marketing campaigns** for specific customer segments.  
- **Optimize pricing strategies** based on sales trends.  

### **Challenges and Solutions**  
1. **Data Quality Issues:** Addressed through cleaning and validation processes.  
2. **Integration of Data Sources:** Mapped relationships using JOIN operations.  
3. **Advanced Analysis Skills:** Leveraged SQL techniques to overcome complexities.  

### **Conclusion and Future Directions**  
This project demonstrates the ability to uncover actionable insights through **SQL-based data analysis** using **Oracle SQL Developer**. By identifying revenue opportunities and customer preferences, the analysis supports informed business strategies.  
Future plans include expanding the dataset and incorporating predictive analytics for forecasting trends.

---
