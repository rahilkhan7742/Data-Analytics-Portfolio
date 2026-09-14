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
     
     
     
     -- Find the percentage of bookings
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
	  ROUND(AVG(`Room Rate`),3) AS Avg_Rate
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
      
      
      
      
      
      
SELECT 
	 `Booking ID`,
	 `Booking Date`,
	 `Booking Channel`,
     ROW_NUMBER () OVER(PARTITION BY `Booking Date`
     ORDER BY `Booking ID` ASC) AS Daily_serial_No
FROM Booking;
     
     
     
     

  
  
  
  SELECT 
          `Booking ID`,
          `Room Rate`,
          LAG(`Room Rate`, 1) OVER (ORDER BY `Booking ID`) AS Previous_booking_rate
FROM Booking;




SELECT 
      `Booking ID`,
      `Room Rate`,
      LEAD(`Room Rate`, 1) OVER (ORDER BY `Booking ID`) AS Next_book_room_rate
FROM Bookig;

SELECT `Number of nights` FROM booking;


use hotel_bookingdb;

select * from booking;



SELECT `Booking Channel`, `Loyalty Level`, Revenue
FROM booking
WHERE Revenue > (
         SELECT AVG(Revenue)
         FROM booking 
         WHERE Status = "Cancelled"
         )
         ORDER BY Revenue DESC;
         
         
         
         
         
         
         

      
         
         
         
         
USE hotel_bookingdb;


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


  
  
  
  
  
  
  
  
  
  










     



