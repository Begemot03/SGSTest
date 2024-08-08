with JSONDATA AS(
SELECT
    '{' +
    '"Id": ' + CAST(Id AS VARCHAR(10)) + ',' +
    '"ContainerId": ' + CAST(ContainerId AS VARCHAR(10)) + ',' +
    '"StartOperation": ' + CONVERT(VARCHAR(20), StartOperation, 120) + ',' +
    '"EndOperation": ' + CONVERT(VARCHAR(20), EndOperation, 120) + ',' +
    '"OperationType": ' + OperationType + ',' +
    '"OperatorFullName": ' + OperatorFullName + ',' +
    '"InspectionLocation": ' + InspectionLocation +
    '}'
AS JSONROW
FROM Operations where ContainerId = 1
)

SELECT 
'[ ' +
STRING_AGG(CAST(JSONROW AS VARCHAR(MAX)), ',') +
' ]' AS JSONRESULT
FROM JSONDATA;
