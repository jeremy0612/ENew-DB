-- =================== Create Triggers ===================
-- This trigger update role of everynew editors base on their age
CREATE TRIGGER UpdateRole
ON Editor
AFTER INSERT
AS
BEGIN
    UPDATE Editor
    SET Role = CASE
                    WHEN inserted.Birthday BETWEEN '1975-01-01' AND '1980-12-31' THEN 'Senior editor'
                    ELSE 'junior editor'
                 END
    FROM Editor
    INNER JOIN inserted
    ON Editor.EditorID = inserted.EditorID
END;
-- ==================== Create Indexs ====================
CREATE INDEX idx_Reporter_Editor
ON Reporter (EditorID);

CREATE NONCLUSTERED INDEX idx_News 
ON News(NewsID,ReporterID,EditorID,Title);
-- ==================== Create Transaction ===============
--  This transaction change the Reporter of a News 
-- and make sure that the Editor who approves is also the reporter's manager
BEGIN TRANSACTION Publish_News
    DECLARE @NewsID INT
    SELECT @NewsID = NewsID
    FROM News
    WHERE Title = 'SpaceX launches new satellite'

    UPDATE News
    SET ReporterID = 2
    WHERE NewsID = @NewsID

    UPDATE Approve
    SET EditorID = 
    (
        SELECT Editor.EditorID
        FROM Reporter JOIN Editor ON Reporter.EditorID = Editor.EditorID
        WHERE Reporter.ReporterID = 3
    )
    WHERE NewsID = @NewsID
IF(@@ERROR <> 0)
    ROLLBACK TRANSACTION
COMMIT TRANSACTION;
-- ==================== Create Functions =================
CREATE FUNCTION GetNumberOfNewsArticles(@reporterID INT)
RETURNS INT
AS
BEGIN
    DECLARE @count INT;
    SELECT @count = COUNT(*)
    FROM News
    WHERE ReporterID = @reporterID;
    RETURN @count;
END;
CREATE FUNCTION Title_Reporter()
RETURNS TABLE
AS
RETURN
(
    SELECT News.Title, Reporter.ReporterID
    FROM News
    JOIN Reporter ON News.ReporterID = Reporter.ReporterID
)
-- Call the function
SELECT dbo.GetNumberOfNewsArticles(2)
SELECT * FROM Title_Reporter()
-- ==================== Create Stored Procedured =========
-- Store Procedure without return value
CREATE PROCEDURE Subcription_Of_Reader 
    @FIRSTDATE DATE, 
    @ENDDATE DATE ,
    @READER INT
AS 
BEGIN
    SELECT * 
    FROM Subcribe
    WHERE (Send_Date BETWEEN @FIRSTDATE AND @ENDDATE)
    AND ReaderID = @READER
END;
-- Store Procedure within return value
CREATE PROCEDURE MostActiveReporter
AS
BEGIN
    DECLARE @mostActive INT
    SELECT TOP 1 @mostActive = ReporterID
    FROM
    (
        SELECT ReporterID, COUNT(ReporterID) AS NumberOfNews
        FROM 
        (
            SELECT News.Title, Reporter.ReporterID
            FROM News 
            JOIN Reporter ON News.ReporterID = Reporter.ReporterID
        ) AS TEMP
        GROUP BY ReporterID
    ) AS TEMP2
    ORDER BY NumberOfNews DESC
    RETURN (@mostActive)
END

-- Execute the Store Procedure
EXEC Subcription_Of_Reader '2023-01-01', '2023-02-28', 3
DECLARE @MostActiveReporter INT 
EXEC @MostActiveReporter = MostActiveReporter
SELECT @MostActiveReporter AS 'Most Active Reporter'




