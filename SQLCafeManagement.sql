CREATE DATABASE CafeManagement
GO
USE CafeManagement
GO
CREATE TABLE Account
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
	StatusTable VARCHAR(100) NOT NULL DEFAULT 'unoccupied'	-- unoccupied || occupied	
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
	BillInfoID NVARCHAR(50) PRIMARY KEY,
	BillID NVARCHAR(50) NOT NULL,
	DrinkID NVARCHAR(50) NOT NULL,
	DrinkCategoryID NVARCHAR(50) NOT NULL,
	Quantity INT NOT NULL DEFAULT 0
	FOREIGN KEY (BillID) REFERENCES dbo.Bill(BillID),
	FOREIGN KEY (DrinkID) REFERENCES dbo.Drink(DrinkID),
	FOREIGN KEY (DrinkCategoryID) REFERENCES dbo.DrinkCategory(DrinkCategoryID)
)
GO

----------------THỦ TỤC NHẬP LIỆU----------------------------
CREATE PROCEDURE sp_AddAccount
				@UserName NVARCHAR(100) ,	
				@DisplayName NVARCHAR(100),
				@PassWord NVARCHAR(1000),
				@Type INT 
AS
IF		EXISTS (SELECT * FROM	Account WHERE	UserName=@UserName)
		PRINT N'Đã tồn tại'
ELSE
		INSERT INTO [dbo].[Account]
           ([UserName]
           ,[DisplayName]
           ,[PassWord]
           ,[Type])
		VALUES
           (@UserName
           ,@DisplayName
           ,@PassWord
           ,@Type)
GO
----
EXEC sp_AddAccount
	@UserName = 'admin',
    @DisplayName = 'Admin',
    @PassWord = '123456',
    @Type = 1
GO
------------------------------
CREATE PROCEDURE sp_AddDrinkCategory
				@DrinkCategoryID NVARCHAR(50),
				@DrinkCategoryName NVARCHAR(100)
AS
IF		EXISTS (SELECT * FROM	DrinkCategory WHERE	DrinkCategoryID=@DrinkCategoryID)
		PRINT N'Đã tồn tại'
ELSE
	INSERT INTO [dbo].[DrinkCategory]
           ([DrinkCategoryID]
           ,[DrinkCategoryName])
     VALUES
           (@DrinkCategoryID
           ,@DrinkCategoryName)
GO
----
EXEC sp_AddDrinkCategory
	@DrinkCategoryID = 'Hot',
    @DrinkCategoryName = N'Đồ uống nóng'
EXEC sp_AddDrinkCategory
	@DrinkCategoryID = 'Cold',
    @DrinkCategoryName = N'Đồ uống lạnh'
GO
------------------------------
CREATE PROCEDURE sp_AddDrink
				@DrinkID NVARCHAR(50),
				@DrinkCategoryID NVARCHAR(50) ,
				@DrinkName NVARCHAR(50),
				@UnitPrice SMALLMONEY,
				@Status BIT 
AS
IF		EXISTS (SELECT * FROM	Drink WHERE	DrinkID=@DrinkID)
		PRINT N'Đã tồn tại'
ELSE
	INSERT INTO [dbo].[Drink]
           ([DrinkID]
           ,[DrinkCategoryID]
           ,[DrinkName]
           ,[UnitPrice]
           ,[Status])
     VALUES
           (@DrinkID
           ,@DrinkCategoryID
           ,@DrinkName
           ,@UnitPrice
           ,@Status)
GO
----
--EXEC sp_AddDrink
--	@DrinkID = 
--    ,@DrinkCategoryID = 
--    ,@DrinkName = 
--    ,@UnitPrice =
--    ,@Status = 

--GO
------------------------------
CREATE PROCEDURE sp_AddTableManagement
				@TableID NVARCHAR(50),
				@TableName NVARCHAR(100),
				@StatusTable VARCHAR(100)
AS
IF		EXISTS (SELECT * FROM	TableManagement WHERE	TableID=@TableID)
		PRINT N'Đã tồn tại'
ELSE
		INSERT INTO [dbo].[TableManagement]
           ([TableID]
           ,[TableName]
           ,[StatusTable])
     VALUES
           (@TableID
           ,@TableName
           ,@StatusTable)
GO
-----------------------------------------
CREATE PROCEDURE sp_AddBill
				@BillID NVARCHAR(50),
				@DateCheckIn DATE,
				@DateCheckOut DATE,
				@TableID NVARCHAR(50),
				@BillStatus INT
AS
IF		EXISTS (SELECT * FROM	Bill WHERE	BillID=@BillID)
		PRINT N'Đã tồn tại'
ELSE
		INSERT INTO [dbo].[Bill]
           ([BillID]
           ,[DateCheckIn]
           ,[DateCheckOut]
           ,[TableID]
           ,[BillStatus])
		VALUES
           (@BillID
           ,@DateCheckIn
           ,@DateCheckOut
           ,@TableID
           ,@BillStatus)
GO
--------------------------
CREATE PROCEDURE sp_AddBillInfo 
				@BillInfoID NVARCHAR(50),
				@BillID NVARCHAR(50),
				@DrinkID NVARCHAR(50),
				@DrinkCategoryID NVARCHAR(50),
				@Quantity INT
AS
IF		EXISTS (SELECT * FROM	BillInfo  WHERE	BillInfoID=@BillInfoID)
		PRINT N'Đã tồn tại'
ELSE
		INSERT INTO [dbo].[BillInfo]
           ([BillInfoID]
           ,[BillID]
           ,[DrinkID]
           ,[Quantity]
           ,[DrinkCategoryID])
     VALUES
           (@BillInfoID
           ,@BillID
           ,@DrinkID
           ,@DrinkCategoryID
           ,@Quantity)
GO
--------------------------