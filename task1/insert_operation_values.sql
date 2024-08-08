USE [SGSTestdb]
GO

DECLARE @i INT = 0;
DECLARE @ContrainerCount INT;

SELECT @ContrainerCount = COUNT(*) from Containers;

WHILE @i < 1000
BEGIN

INSERT INTO Operations
     VALUES
      (
            ABS(CHECKSUM(NEWID())) % @ContrainerCount,
            DATEADD(DAY, ABS(CHECKSUM(NEWID())) % 30, GETDATE() - 30),
            DATEADD(DAY, ABS(CHECKSUM(NEWID())) % 15, GETDATE() - 15),
            CONCAT('TYPE', ABS(CHECKSUM(NEWID())) % 5),
            CONCAT('OPERATOR', ABS(CHECKSUM(NEWID())) % 5),
            CONCAT('LOCATION', ABS(CHECKSUM(NEWID())) % 5)
      );

SET @i = @i + 1;

END;