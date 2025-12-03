use assessment;
CREATE TABLE Clinics (
    cid VARCHAR(50) PRIMARY KEY,
    clinic_name VARCHAR(200),
    city VARCHAR(200),
    state VARCHAR(200),
    country VARCHAR(100)
);

CREATE TABLE Customer (
    uid VARCHAR(50) PRIMARY KEY,
    name VARCHAR(200),
    mobile VARCHAR(20)
);

CREATE TABLE Clinic_Sales (
    oid VARCHAR(50) PRIMARY KEY,
    uid VARCHAR(50) REFERENCES Customer(uid),
    cid VARCHAR(50) REFERENCES Clinics(cid),
    amount DECIMAL(10,2),
    datetime DATETIME,
    sales_channel VARCHAR(50)
);

CREATE TABLE Expenses (
    eid VARCHAR(50) PRIMARY KEY,
    cid VARCHAR(50) REFERENCES Clinics(cid),
    description VARCHAR(200),
    amount DECIMAL(10,2),
    datetime DATETIME
);

INSERT INTO Clinics VALUES
('C001','XYZ Clinic','Chennai','Tamil Nadu','India'),
('C002','Apollo Clinic','Bangalore','Karnataka','India'),
('C003','LifeCare Clinic','Mumbai','Maharashtra','India');

INSERT INTO Customer VALUES
('U001','John Doe','9876543210'),
('U002','Priya Sharma','9988776655'),
('U003','Arun Kumar','9090909090');

INSERT INTO Clinic_Sales VALUES
('O001','U001','C001',25000,'2021-09-23 12:03:22','offline'),
('O002','U002','C001',12000,'2021-09-23 14:03:22','online'),
('O003','U003','C002',35000,'2021-10-11 16:00:00','offline'),
('O004','U001','C003',8000,'2021-10-15 17:00:00','online');

INSERT INTO Expenses VALUES
('E001','C001','First Aid',500,'2021-09-23'),
('E002','C002','Maintenance',2000,'2021-10-11'),
('E003','C003','Electricity',1500,'2021-10-15');


select * from Expenses;