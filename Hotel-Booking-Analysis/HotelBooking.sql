CREATE DATABASE Hotel_BookingDB;
USE Hotel_BookingDB;

SELECT * FROM booking;
SELECT COUNT(*) FROM booking;





-- Calculate overall business metrics
SELECT 
     COUNT(`Booking ID`) AS Total_Booking,
     SUM(Revenue) AS Total_Revanue,
     AVG(`Room Rate`) AS Avg_Room_Rate
FROM booking;
     
     
     
     -- Find the percentage of bookings by status
 SELECT
      Status,
      COUNT(`Booking ID`) AS Total_Count,
      ROUND(COUNT(`Booking ID`) * 100 / (SELECT COUNT(*) FROM booking), 2) AS Percentage
FROM booking
GROUP BY Status;





-- Analyze which customer is loyal
SELECT 
     `Loyalty Level`,
      ROUND(SUM(Revenue),2) AS Total_Revanue,
	  ROUND(AVG(`Room Rate`),2) AS Avg_Rate
FROM booking
GROUP BY `Loyalty Level`
ORDER BY Total_Revanue DESC;




-- identify the busiest days on booking
SELECT 
	`Day Name`,
	COUNT(`Booking ID`) AS Booking_count
FROM booking
GROUP BY `Day Name`,`Day of Week`
ORDER BY `Day of Week` ASC;

   
   
   
   -- Group booking by how many days in advance customers booked their stay
SELECT 
      `How far away bucket`,
      COUNT(`Booking ID`) AS Total_booking,
      ROUND(SUM(Revenue),5) AS Total_Revanue
FROM booking
GROUP BY `How far away bucket`
ORDER BY Total_booking DESC;   
   
   
   
   -- calculate the total potential revanue lost due to cancelled booking
SELECT 
    Status,
    ROUND(SUM(Revenue),5) AS Potential_lost_Revanue,
    COUNT(`Booking ID`) AS Cancelled
FROM booking
WHERE Status = 'CancelLed'
GROUP BY Status;
    
    
    
    -- Find bookings where room rate is higher than the overall average room rate
SELECT 
    `Booking ID`, 
    `Booking Channel`, 
    `Room Rate`
FROM booking
WHERE `Room Rate` > (SELECT AVG(`Room Rate`) FROM booking);
 
    
   
-- Analyzes how early guests book and which lead-time bucket generates maximum revenue & length of stay
SELECT 
    `How far away bucket`,
    COUNT(`Booking ID`) AS total_bookings,
    ROUND(SUM(Revenue), 2) AS total_revenue,
    ROUND(AVG(`Room Rate`), 2) AS avg_room_rate,
    ROUND(AVG(`Number of nights`), 1) AS avg_length_of_stay
FROM booking
WHERE Status != 'Cancelled'
GROUP BY `How far away bucket`
ORDER BY total_revenue DESC;
    

    
    
    
    
    
    
    
    
-- Analyze revanue performance across different booking channels
SELECT 
     `Booking Channel`,
	  COUNT(`Booking ID`) AS Total_Booking,
      ROUND(SUM(Revenue),5) AS Total_Revanue,
	  ROUND(AVG(`Room Rate`),3) AS Avg_Room_Rate
FROM booking
GROUP BY `Booking Channel`
ORDER BY Total_Revanue DESC;
     



-- Analyze booking counts and cancellation rates for customer loyalty level
SELECT 
      `Loyalty Level`,
      COUNT(`Booking ID`) AS Total_Booking,
      SUM(CASE WHEN Status = 'Cancelled' THEN 1 ELSE 0 END) AS Total_Cancelled,
      ROUND(SUM(CASE WHEN Status = 'Cancelled' THEN 1 ELSE 0 END) * 100 / COUNT(`Booking ID`), 2) AS Cancel_percentage
FROM booking
GROUP BY `Loyalty Level`
ORDER BY Cancel_percentage DESC;






USE Hotel_BookingDB;

-- Analyze booking volume, total cancellations,and cancellation percentage across lead time buckets

SELECT 
      `How far away bucket`,
      COUNT(`Booking ID`) AS Total_Booking,
      SUM(CASE WHEN Status = 'Cancelled' THEN 1 ELSE 0 END) AS Total_Cancelled,
      ROUND(SUM(CASE WHEN Status = 'Cancelled' THEN 1 ELSE 0 END) * 100 / COUNT(`Booking ID`), 2) AS Cancel_percentage
FROM booking
GROUP BY `How far away bucket`
ORDER BY Cancel_percentage DESC;






-- Analyze cancelalation rates based on weekday vs weekend bookings

SELECT   
     `Day of Week`,
     COUNT(`Booking ID`) AS Total_booking,
     SUM(CASE WHEN Status = 'Cancelled' THEN 1 ELSE 0 END) AS Total_Canceled,
     ROUND(SUM(CASE WHEN Status = 'Cancelled' THEN 1 ELSE 0 END) * 100 / COUNT(`Booking ID`), 2) AS Cancel_percentage
FROM Booking
GROUP BY `Day of Week`
ORDER BY Cancel_percentage DESC;





-- Rank booking by Revanue within each booking channel

SELECT 
      `Booking ID`,
      `Booking Channel`,
	  Revenue,
      DENSE_RANK () OVER(PARTITION BY `Booking Channel`
      ORDER BY Revenue DESC) AS Revanue_rank
FROM Booking;
      
      
      
      
 USE hotel_bookingdb;
      
      

     
     
     
     

  
  
  -- Fetching Previous Booking Rate using LAG
  SELECT 
          `Booking ID`,
          `Room Rate`,
          LAG(`Room Rate`, 1) OVER (ORDER BY `Booking ID`) AS Previous_booking_rate
FROM Booking;



-- Fetching Next Booking Rate using LEAD
SELECT 
      `Booking ID`,
      `Room Rate`,
      LEAD(`Room Rate`, 1) OVER (ORDER BY `Booking ID`) AS Next_book_room_rate
FROM Bookig;

SELECT `Number of nights` FROM booking;


use hotel_bookingdb;


-- Rank Channels by total revenue using DENSE_RANK()
  SELECT `Booking Channel`,
          ROUND(SUM(Revenue),2) AS total_revenue,
          DENSE_RANK() OVER (ORDER BY SUM(Revenue) DESC) AS revenue_rank
          FROM booking
          GROUP BY `Booking Channel`;



         
         
         
         
         
         

      
         
         
         
         
USE hotel_bookingdb;



-- High Cancellation Channels With >25% Cancellation

WITH ChannelStats AS (
      SELECT `Booking Channel`,
      COUNT(`Booking ID`) AS total_bookings,
      SUM(CASE WHEN status = "Cancelled" THEN 1 ELSE 0 END) AS total_cancellation,
      SUM(Revenue) AS channel_lost_revanue
      FROM booking
      GROUP BY `Booking Channel`
),
    ChannelRates AS (
		SELECT `Booking Channel`,
				channel_lost_revanue,
                ROUND((total_cancellation * 100.0 / total_bookings), 2) AS cancellation_rate
                FROM ChannelStats
			)
                     SELECT * FROM ChannelRates
                     WHERE cancellation_rate > 25.0
                     ORDER BY channel_lost_revanue DESC;
            


USE hotel_bookingdb;


-- Calculate total bookings, cancelled bookings, and cancellation percentage for each booking channel using chained CTEs.
WITH TotalStats AS (
    SELECT `Booking Channel`, COUNT(`Booking ID`) AS total_count
    FROM booking
    GROUP BY `Booking Channel`
),
CancelledStats AS (
    SELECT `Booking Channel`, COUNT(`Booking ID`) AS cancelled_count
    FROM booking
    WHERE status = 'Cancelled'
    GROUP BY `Booking Channel`
)
SELECT 
    t.`Booking Channel`,
    t.total_count,
    c.cancelled_count,
    ROUND((c.cancelled_count * 100.0 / t.total_count), 2) AS cancellation_rate
FROM TotalStats t
LEFT JOIN CancelledStats c 
    ON t.`Booking Channel` = c.`Booking Channel`;    

  
  
  
  
  
  
  
  
  
  










     



