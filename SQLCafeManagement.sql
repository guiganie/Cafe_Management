CREATE DATABASE CafeManagement
GO
USE CafeManagement
GO
CREATE TABLE Acount
(
	UserName NVARCHAR(100) PRIMARY KEY,	
	DisplayName NVARCHAR(100) NOT NULL,
	PassWord NVARCHAR(1000) NOT NULL DEFAULT 0,
	Type INT NOT NULL  DEFAULT 0 -- 1: admin && 0: staff
)
GO
---------------------------------------
CREATE TABLE DrinkCategory
(
	DrinkCategoryID NVARCHAR(50) NOT NULL PRIMARY KEY,
	DrinkCategoryName NVARCHAR(100) NOT NULL DEFAULT N'Chưa đặt tên'
)
GO
---------------------------------------
CREATE TABLE Drink
(
	DrinkID NVARCHAR(50) NOT NULL PRIMARY KEY,
	DrinkCategoryID NVARCHAR(50) NOT NULL,
	DrinkName NVARCHAR(50) NOT NULL,
	UnitPrice SMALLMONEY DEFAULT 0,
	Status BIT DEFAULT 1,
	FOREIGN KEY (DrinkCategoryID) REFERENCES dbo.DrinkCategory(DrinkCategoryID),
)
GO
---------------------------------------

CREATE TABLE TableManagement
(
	TableID NVARCHAR(50) PRIMARY KEY,
	TableName NVARCHAR(100) NOT NULL DEFAULT N'Bàn chưa có tên',
	StatusTable VARCHAR(100) NOT NULL DEFAULT N'unoccupied'	-- unoccupied || occupied	
)
GO
---------------------------------------
CREATE TABLE Bill
(
	BillID NVARCHAR(50) PRIMARY KEY,
	DateCheckIn DATE NOT NULL DEFAULT GETDATE(),
	DateCheckOut DATE,
	TableID NVARCHAR(50) NOT NULL,
	BillStatus INT NOT NULL DEFAULT 0 -- 1: đã thanh toán && 0: chưa thanh toán
	
	FOREIGN KEY (TableID) REFERENCES dbo.TableManagement(TableID)
)
GO
---------------------------------------
CREATE TABLE BillInfo 
(
	BillDetailID NVARCHAR(50) PRIMARY KEY,
	BillID NVARCHAR(50) NOT NULL,
	DrinkID NVARCHAR(50) NOT NULL,
	Quantity INT NOT NULL DEFAULT 0
	FOREIGN KEY (BillID) REFERENCES dbo.Bill(BillID),
	FOREIGN KEY (DrinkID) REFERENCES dbo.Drink(DrinkID)
)
GO
