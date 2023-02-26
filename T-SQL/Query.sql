-- =========== Select From A Table ============
SELECT * FROM News
WHERE ReporterID = 2
-- =========== Query Using Order By ===========
SELECT ReaderID,Account,[Password]
FROM Reader
ORDER BY [Password];
--============  Query Using LIKE ==============
SELECT * 
FROM Reader
WHERE Firstname LIKE 'M%';
--============ Query related to time ==========
SELECT * 
FROM Comment
WHERE (Send_Date BETWEEN '2022-02-10' AND '2022-02-20')
    AND Send_Time BETWEEN '15:00:00' AND '20:00:00'
--============ Query from multitable ==========
SELECT Comment.ReaderID,Comment.Content,News.Title
FROM Comment
INNER JOIN News
ON News.NewsID = Comment.NewsID
ORDER BY Comment.Send_Date,Comment.Send_Time;
--============ Query using self join and outer join ==========
SELECT parent.CategoryId AS ParentId, parent.Name AS ParentName,
       child.CategoryId AS ChildId, child.Name AS ChildName
FROM Category parent
JOIN Category child ON child.ParentID = parent.CategoryId
ORDER BY parent.CategoryID, chilD.CategoryID;

SELECT Reporter_Phone.Phone, Reporter_Phone.Purpose, Reporter.Surname, Reporter.FirstName
FROM Reporter_Phone
RIGHT OUTER JOIN Reporter
ON Reporter.ReporterID = Reporter_Phone.ReporterID

--============== Query using subquery ==================================
-- ======= This query show the controversial level of each News ============
SELECT News.Title,News.Views, ISNULL(CommentCount.Comments,0) AS Comments
FROM News
LEFT JOIN 
(
    SELECT NewsID,COUNT(NewsID) AS Comments 
    FROM Comment
    WHERE Send_Date BETWEEN '2022-02-01' AND '2022-02-28'
    GROUP BY NewsID
) AS CommentCount
ON News.NewsID = CommentCount.NewsID
ORDER BY Comments,Views
--================= Query using WITH ====================================
--===== This query return all News and the firstname of its Reporter ======
WITH TEMP AS 
(
    SELECT News.Title,News.ReporterID
    FROM News
) 
SELECT Reporter.Firstname, TEMP.Title5
FROM Reporter
FULL OUTER JOIN TEMP ON TEMP.ReporterID = Reporter.ReporterID;
-- Check data
SELECT *
FROM News
SELECT *
FROM Editor;
--=================  Query using Group and Having ============
SELECT NewsID, COUNT(*) as CommentCount
FROM Comment
GROUP BY NewsID
HAVING COUNT(*) >= 1;
--================= Query using FUNCTION =====================









