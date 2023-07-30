CREATE DATABASE airportdb;

USE airportdb;

-- Airport Table
CREATE TABLE Airport (
    Airport_id VARCHAR(5) PRIMARY KEY,
    Airport_name VARCHAR(50),
    Country VARCHAR(50)
);

-- Airlines Table
CREATE TABLE Airlines (
    Airline_name VARCHAR(50) PRIMARY KEY,
    Model_no VARCHAR(10),
    Capacity INT
);

-- Flight Table
CREATE TABLE Flight (
    Flight_id INT PRIMARY KEY,
    Flight_name VARCHAR(50),
    Capacity INT,
    Model_no VARCHAR(10),
    Airport_id VARCHAR(5),
    FOREIGN KEY (Airport_id) REFERENCES Airport (Airport_id)
    -- FOREIGN KEY (Model_no) REFERENCES Airlines (Model_no)
);

-- Passenger Table
CREATE TABLE Passenger (
    Passenger_id VARCHAR(5) PRIMARY KEY,
    Passenger_name VARCHAR(50),
    Age INT,
    mobile_no VARCHAR(15),
    Flight_id INT,
    FOREIGN KEY (Flight_id) REFERENCES Flight (Flight_id)
);

-- Ticket Table
CREATE TABLE Ticket (
    Ticket_id VARCHAR(5) PRIMARY KEY,
    Passenger_id VARCHAR(5),
    FOREIGN KEY (Passenger_id) REFERENCES Passenger (Passenger_id)
);

-- Booking Table
CREATE TABLE Booking (
    Booking_id VARCHAR(5) PRIMARY KEY,
    ToLocation VARCHAR(50),
    FromLocation VARCHAR(50),
    Ticket_id VARCHAR(5),
    FOREIGN KEY (Ticket_id) REFERENCES Ticket (Ticket_id)
);

-- Insert all values into Airport table 
INSERT INTO Airport (Airport_id, Airport_name, Country)
VALUES
    ('A06', 'MANGALORE', 'INDIA'),
    ('A18', 'CHENNAI', 'INDIA'),
    ('A20', 'SYDNEY', 'AUSTRALIA'),
    ('A22', 'MELBOURNE', 'AUSTRALIA'),
    ('A30', 'MICHIGAN', 'USA'),
    ('A55', 'CHICAGO', 'USA');

-- Inserting all values into Airlines table at once
INSERT INTO Airlines (Airline_name, Model_no, Capacity)
VALUES
    ('Air India', 'FF9', 210),
    ('Indigo', 'FF11', 240),
    ('Delta', 'FF16', 255);
    
-- Inserting all values into Flight table at once
INSERT INTO Flight (Flight_name, Flight_id, Capacity, Model_no, Airport_id)
VALUES
    ('Air India1', 6706, 210, 'FF9', 'A18'),
    ('Air India2', 6718, 210, 'FF9', 'A22'),
    ('Indigo2', 6720, 240, 'FF11', 'A30'),
    ('Indigo1', 6722, 240, 'FF11', 'A55'),
    ('Delta1', 6730, 255, 'FF16', 'A06'),
    ('Delta2', 6755, 255, 'FF16', 'A20');

-- Inserting all values into Passenger table at once
INSERT INTO Passenger (Passenger_id, Passenger_name, mobile_no, Age, Flight_id)
VALUES
    ('P1', 'Nanda Kishore', '8328352690', 21, 6706),
    ('P2', 'Jaya Vardhan', '9989797999', 45, 6706),
    ('P3', 'Sahith', '8125875578', 21, 6718),
    ('P4', 'Sharath', '7075319227', 18, 6720),
    ('P5', 'Manish', '7878767669', 21, 6720),
    ('P6', 'Rithvik', '9030845170', 60, 6722),
    ('P7', 'Charan', '6758904589', 25, 6730),
    ('P8', 'Tejeswar', '9150345345', 30, 6730),
    ('P9', 'Koushik', '7897895679', 43, 6755),
    ('P10', 'Sathwik', '9879876789', 55, 6755);

-- Inserting all values into Ticket table at once
INSERT INTO Ticket (Ticket_id, Passenger_id)
VALUES
    ('T11', 'P1'),
    ('T22', 'P2'),
    ('T33', 'P3'),
    ('T44', 'P4'),
    ('T55', 'P5'),
    ('T66', 'P6'),
    ('T77', 'P7'),
    ('T88', 'P8'),
    ('T99', 'P9'),
    ('T100', 'P10');

-- Inserting all values into Booking table at once
INSERT INTO Booking (Booking_id, ToLocation, FromLocation, Ticket_id)
VALUES
    ('BB1', 'INDIA', 'INDIA', 'T11'),
    ('BB2', 'USA', 'INDIA', 'T22'),
    ('BB3', 'AUSTRALIA', 'AUSTRALIA', 'T33'),
    ('BB4', 'USA', 'USA', 'T44'),
    ('BB5', 'INDIA', 'USA', 'T55'),
    ('BB6', 'AUSTRALIA', 'USA', 'T66'),
    ('BB7', 'USA', 'INDIA', 'T77'),
    ('BB8', 'AUSTRALIA', 'INDIA', 'T88'),
    ('BB9', 'INDIA', 'AUSTRALIA', 'T99'),
    ('BB10', 'USA', 'AUSTRALIA', 'T100');

-- SQL QUERIES 

-- 1). List the names of the passengers who are going to arrive in India. 
SELECT Passenger.Passenger_name 
FROM Passenger 
JOIN Flight ON Passenger.Flight_id = Flight.Flight_id 
JOIN Airport ON Flight.Airport_id = Airport.Airport_id 
WHERE Airport.Country = 'India';

-- 2). List the names and mobile numbers of all passengers who are travelling through Air India flight.
SELECT Passenger.Passenger_name, Passenger.mobile_no 
FROM Passenger 
JOIN Flight ON Passenger.Flight_id = Flight.Flight_id
JOIN Airlines ON Flight.Model_no = Airlines.Model_no
WHERE Airlines.Airline_name = 'Air India';

-- 3). List all the airline names of the flights whose capacity is >500 and lands in ‘RGI AIRPORT’.
SELECT Airlines.Airline_name 
FROM Flight
JOIN Airlines ON Flight.Model_no = Airlines.Model_no
JOIN Airport ON Flight.Airport_id = Airport.Airport_id
WHERE Flight.Capacity > 500 AND Airport.Airport_name = 'RGI AIRPORT';

-- 4). List the names of passengers who travelled from US to India and age>50.
SELECT Passenger.Passenger_name 
FROM Passenger 
JOIN Flight ON Passenger.Flight_id = Flight.Flight_id 
JOIN Airport ON Flight.Airport_id = Airport.Airport_id 
WHERE Airport.Country = 'India' AND Passenger.Age > 50 AND Airport.Country != 'US';

-- 5). List the Flight ids of the flights where corresponding airport is located in India.
SELECT Flight.Flight_id, Airport.Country
FROM Flight 
JOIN Airport ON Flight.Airport_id = Airport.Airport_id 
WHERE Airport.Country = 'India';

-- 6). List the ID of the passenger whose is travelling in the Flight ID-6755 and age>20.
SELECT Passenger.Passenger_id, Passenger.Passenger_name 
FROM Passenger
JOIN Flight ON Passenger.Flight_id = Flight.Flight_id
WHERE Flight.Flight_id = '6755' AND Passenger.Age > 20;

-- 7). What is the average age of all passengers who have booked tickets for flights 
-- that are departing from AUSTRALIA?
SELECT AVG(Passenger.Age) FROM Passenger
JOIN Ticket ON Passenger.Passenger_id = Ticket.Passenger_id
JOIN Booking ON Ticket.Ticket_id = Booking.Ticket_id
where Booking.FromLocation = 'Australia';

-- 8). What are the top 2 airlines in terms of the number of passengers who 
-- have booked tickets for their flights?
SELECT Airlines.Airline_name, COUNT(Passenger.Passenger_id) as Total_Passengers FROM Airlines
JOIN Flight ON Airlines.Model_no = Flight.Model_no
JOIN Booking ON Flight.Flight_id = Booking.Ticket_id
JOIN Ticket ON Booking.Ticket_id = Ticket.Ticket_id
JOIN Passenger ON Ticket.Passenger_id = Passenger.Passenger_id
GROUP BY Airlines.Airline_name
ORDER BY Total_Passengers DESC LIMIT 2;

-- 9). What is the total number of passengers who have booked tickets for 
-- Air India flights?
SELECT COUNT(DISTINCT Passenger.Passenger_id) as Total_Passengers FROM Airlines
JOIN Flight ON Airlines.Model_no = Flight.Model_no
JOIN Booking ON Flight.Flight_id = Booking.Ticket_id
JOIN Ticket ON Booking.Ticket_id = Ticket.Ticket_id
JOIN Passenger ON Ticket.Passenger_id = Passenger.Passenger_id
WHERE Airlines.Airline_name = 'Air India';
