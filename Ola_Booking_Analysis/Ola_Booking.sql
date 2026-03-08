use ola_booking_Analysis;

-- 1. Retrieve all successful bookings:
select * from ola_booking
where Booking_Status='Success';

-- 2. Find the average ride distance for each vehicle type:
select Vehicle_Type,round(avg(Ride_Distance),2) as Avg_Distance
from ola_booking
group by Vehicle_Type;

-- 3. Get the total number of cancelled rides by customers:
select count(*) as Cancelled_Rides_By_Customers
from ola_booking
where Booking_Status='Canceled by Customer';

-- 4. List the top 5 customers who booked the highest number of rides:
select Customer_ID,count(Booking_ID) Total_Bookings
from ola_booking
group by Customer_ID
order by Total_Bookings desc limit 5;

-- 5. Get the number of rides cancelled by drivers due to personal and car-related issues:
select count(*) as Ride_Canceledby_Driver from ola_booking
where Canceled_Rides_by_Driver='Personal & Car related issue';

-- 6. Find the maximum and minimum driver ratings for Prime Sedan bookings:
SELECT MAX(Driver_Ratings) as max_rating,
 MIN(Driver_Ratings) as min_rating FROM ola_booking 
 WHERE Vehicle_Type = 'Prime Sedan';

-- 7. Retrieve all rides where payment was made using UPI:
SELECT * FROM ola_booking 
WHERE Payment_Method = 'UPI';

-- 8. Find the average customer rating per vehicle type:
SELECT Vehicle_Type, 
AVG(Customer_Rating) as avg_customer_rating FROM ola_booking
GROUP BY Vehicle_Type;

-- 9. Calculate the total booking value of rides completed successfully:
SELECT SUM(Booking_Value) as total_successful_value FROM ola_booking
 WHERE Booking_Status = 'Success';

-- 10. List all incomplete rides along with the reason:
SELECT Booking_ID, Incomplete_Rides_Reason FROM bookings
 WHERE Incomplete_Rides ='Yes';





