CREATE SCHEMA STOCK
CREATE TABLE Stock.Stock(
					   StockID int IDENTITY PRIMARY KEY, 
                       StockName varchar(100),
					   TotalQuantity int,
					   UnitPrice money
					   )
CREATE TABLE Stock.StockMovement(
						SHID int IDENTITY PRIMARY KEY,
                        StockID int REFERENCES Stock.Stock(StockID),
						MovementID int, 
						Quantity int,
						Price money,
						MovementDate datetime
						)

INSERT INTO Stock.Stock VALUES('Object X',500,50),('Object Y',1000,25),('Object Z',100,80)

CREATE TRIGGER t_StockMovement
ON Stock.StockMovement
AFTER INSERT
AS

DECLARE @stockID int
DECLARE @MovementID int
DECLARE @Quantity int
SELECT @stockID=StockID, @Quantity=Quantity, @MovementID=MovementID FROM inserted

IF(@MovementID=1)
  UPDATE Stock.Stock SET TotalQuantity +=@Quantity WHERE StockID = @stockID
ELSE IF(@MovementID=2)
  UPDATE Stock.Stock SET TotalQuantity -=@Quantity WHERE StockID = @stockID
 
 INSERT INTO Stock.StockMovement VALUES(1,1,10,50,getdate())
 INSERT INTO Stock.StockMovement VALUES(2,2,10,50,getdate())

   CREATE TABLE Stock.PriceMovement(
						FHID int IDENTITY PRIMARY KEY, 
                        StockID int REFERENCES Stock.Stock(StockID),
						OldPrice money,
						NewPrice money,
						PriceMovementDate datetime
						)

CREATE TRIGGER t_PriceMovement
ON Stock.Stock
  AFTER UPDATE 
  AS
 
  DECLARE @stockID int
  DECLARE @OldPrice money
  DECLARE @NewPrice money

  SELECT @stockID=StockID, @NewPrice=UnitPrice  FROM inserted
  SELECT  @OldPrice=UnitPrice  FROM deleted

  INSERT INTO Stock.PriceMovement VALUES(@stockID,@OldPrice,@NewPrice,getdate())

 SELECT * FROM Stock.Stock
  UPDATE Stock.Stock SET UnitPrice =30 WHERE StockID=2

  SELECT * FROM Stock.PriceMovement