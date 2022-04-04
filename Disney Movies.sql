----REMOVE THE NULL ROWS

DELETE FROM PortfolioProject.dbo.Disney_Movies
WHERE Movie_Title IS NULL;

----REMOVE THE TIME PART IN RELEASE DATE COLUMN

ALTER TABLE PortfolioProject.dbo.Disney_Movies
ALTER COLUMN Release_Date Date;

----GROUP THE BOX OFFICE FIGURES BY YEAR AND COUNT (Visual 1)

SELECT YEAR(Release_Date) AS 'Release Year', SUM(Total_Gross) AS 'Total Gross', AVG(Total_Gross) AS 'Average Gross', COUNT(Total_Gross) AS 'Number of Movies'
FROM PortfolioProject.dbo.Disney_Movies
GROUP BY YEAR(Release_Date);

----TOTAL GROSS BY GENRE (Visual 2)
SELECT Genre, SUM(Total_Gross) AS 'Total Gross'
FROM PortfolioProject.dbo.Disney_Movies
GROUP BY Genre
ORDER BY 2 DESC;

----FIND THE TOP MONTH (Visual 3)
--WITH MONTH NUMBER
SELECT MONTH(Release_Date) AS 'Release Month', SUM(Total_Gross) AS 'Total Gross'
FROM PortfolioProject.dbo.Disney_Movies
GROUP BY MONTH(Release_Date)
ORDER BY 2;
--WITH MONTH NAMES
SELECT FORMAT (Release_Date,'MMMM') AS 'Month', SUM(Total_Gross) AS 'Total Gross'
FROM PortfolioProject.dbo.Disney_Movies
GROUP BY FORMAT (Release_Date,'MMMM')
ORDER BY 2;

----IMDb RATING TOTAL GROSS AND MOVIE COUNT (Visual 4)
SELECT IMDb_Rating, SUM(Total_Gross) AS 'Total Gross'
FROM PortfolioProject..Disney_Movies
GROUP BY IMDb_Rating
ORDER BY 2 DESC;

----CALCULATE THE PERCENT CHANGE EACH YEAR

CREATE TABLE #Disney_Percentage_Change (
Release_Date int,
Total_Gross bigint)

SELECT *
FROM #Disney_Percentage_Change

--INSERT QUERY INTO TEMP TABLE

INSERT INTO #Disney_Percentage_Change
SELECT YEAR(Release_Date), SUM(Total_Gross)
FROM PortfolioProject..Disney_Movies
GROUP BY YEAR(Release_Date)
ORDER BY 1 DESC;

----CALCULATE PERCENT CHANGE

SELECT prev.Release_Date, prev.Total_Gross, new.Release_Date, new.Total_Gross, 
(CAST(new.Total_Gross - prev.Total_Gross AS FLOAT) / prev.Total_Gross)*100 AS PercentChange
FROM #Disney_Percentage_Change prev
LEFT JOIN #Disney_Percentage_Change new
	ON(prev.Release_Date + 1 = new.Release_Date)
WHERE 
ORDER BY prev.Release_Date;

SELECT *
FROM PortfolioProject.dbo.Disney_Movies;
