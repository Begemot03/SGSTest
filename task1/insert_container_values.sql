USE [SGSTestdb]
GO

DECLARE @i INT = 0;

WHILE @i < 1000
BEGIN

INSERT INTO Containers
     VALUES
      (
           ABS(CHECKSUM(NEWID()) % 10000),
           ABS(CHECKSUM(NEWID()) % 5),
           ABS(CHECKSUM(NEWID()) % 100),
           ABS(CHECKSUM(NEWID()) % 100),
           ABS(CHECKSUM(NEWID()) % 100),
           ABS(CHECKSUM(NEWID()) % 700),
           CAST(ABS(CHECKSUM(NEWID()) % 2) AS BIT),
           DATEADD(DAY, ABS(CHECKSUM(NEWID()) % 365), GETDATE() - 365)
      );

SET @i = @i + 1;

END;

