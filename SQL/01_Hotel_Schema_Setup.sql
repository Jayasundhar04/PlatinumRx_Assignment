
CREATE TABLE Users (
    user_id VARCHAR(50) PRIMARY KEY,
    name VARCHAR(200),
    phone_number VARCHAR(20),
    mail_id VARCHAR(200),
    billing_address VARCHAR(300)
);

CREATE TABLE Bookings (
    booking_id VARCHAR(50) PRIMARY KEY,
    booking_date DATETIME,
    room_no VARCHAR(50),
    user_id VARCHAR(50) FOREIGN KEY REFERENCES Users(user_id)
);

CREATE TABLE Items (
    item_id VARCHAR(50) PRIMARY KEY,
    item_name VARCHAR(200),
    item_rate DECIMAL(10,2)
);

CREATE TABLE Booking_Commercials (
    commercial_id VARCHAR(50) PRIMARY KEY,
    booking_id VARCHAR(50) FOREIGN KEY REFERENCES Bookings(booking_id),
    bill_id VARCHAR(50),
    bill_date DATETIME,
    item_id VARCHAR(50) FOREIGN KEY REFERENCES Items(item_id),
    item_quantity DECIMAL(10,2)
);

INSERT INTO Users VALUES
('U001','John Doe','9876543210','john@example.com','Chennai'),
('U002','Priya Sharma','9988776655','priya@gmail.com','Bangalore'),
('U003','Arun Kumar','9090909090','arun@yahoo.com','Mumbai'),
('U004','Meena Devi','9123456780','meena@gmail.com','Hyderabad');

INSERT INTO Items VALUES
('I001','Tawa Paratha',18),
('I002','Mix Veg',89),
('I003','Paneer Butter Masala',160),
('I004','Chicken Biryani',200),
('I005','Veg Biryani',150),
('I006','Masala Dosa',50),
('I007','Idli Sambar',30),
('I008','Chapathi',12),
('I009','Noodles',90),
('I010','Curd Rice',40);


INSERT INTO Bookings VALUES
('B001','2021-09-23 07:36:48','RM101','U001'),
('B002','2021-11-15 10:20:11','RM102','U002'),
('B003','2021-11-29 18:45:03','RM103','U003'),
('B004','2021-10-05 14:15:55','RM104','U004'),
('B005','2021-10-25 09:30:20','RM101','U001');

INSERT INTO Booking_Commercials VALUES
('C001','B001','BL001','2021-09-23 12:03:22','I001',3),
('C002','B001','BL001','2021-09-23 12:03:22','I002',1),

('C003','B002','BL002','2021-11-15 13:00:00','I004',2),
('C004','B002','BL002','2021-11-15 13:00:00','I003',1),

('C005','B003','BL003','2021-11-29 19:00:00','I006',4),
('C006','B003','BL003','2021-11-29 19:00:00','I008',6),

('C007','B004','BL004','2021-10-05 15:00:00','I003',2),
('C008','B004','BL004','2021-10-05 15:00:00','I005',3),

('C009','B005','BL005','2021-10-25 10:00:00','I001',10),
('C010','B005','BL005','2021-10-25 10:00:00','I009',2);





