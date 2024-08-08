CREATE DATABASE SGSTestdb;
GO

USE SGSTestdb;
GO

CREATE TABLE Containers 
(
    Id INT PRIMARY KEY IDENTITY,
    Number INT NOT NULL,
    Type INT NOT NULL,
    Length INT NOT NULL,
    Width INT NOT NULL,
    Height INT NOT NULL,
    Weight INT NOT NULL,
    IsEmpty BIT NOT NULL,
    Receipt DATETIME NOT NULL
);
GO

CREATE TABLE Operations
(
    Id INT PRIMARY KEY IDENTITY,
    ContainerId INT REFERENCES Containers (Id),
    StartOperation DATETIME,
    EndOperation DATETIME,
    OperationType VARCHAR(100) NOT NULL,
    OperatorFullName VARCHAR(100) NOT NULL,
    InspectionLocation VARCHAR(500) NOT NULL
);
