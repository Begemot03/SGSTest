with JSONDATA AS(
SELECT
    '{' +
    '"Id": ' + CAST(Id AS VARCHAR(10)) + ',' +
    '"Number": ' + CAST(Number AS VARCHAR(10)) + ',' +
    '"Type": ' + CAST(Type AS VARCHAR(10)) + ',' +
    '"Length": ' + CAST(Length AS VARCHAR(10)) + ',' +
    '"Width": ' + CAST(Width AS VARCHAR(10)) + ',' +
    '"Height": ' + CAST(Height AS VARCHAR(10)) + ',' +
    '"Weight": ' + CAST(Weight AS VARCHAR(10)) + ',' +
    '"IsEmpty": ' + CASE WHEN IsEmpty = 1 THEN 'true' ELSE 'false' END + ',' +
    '"Receipt": ' + CONVERT(VARCHAR(20), Receipt, 120) +
    '}'
AS JSONROW
FROM Containers
)

SELECT 
'[ ' +
STRING_AGG(CAST(JSONROW AS VARCHAR(MAX)), ',') +
' ]' AS JSONRESULT
FROM JSONDATA;