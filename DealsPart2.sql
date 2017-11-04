
#The purpose of this script is to practice select SQL queries using different statements and learning how to debug
#Nastaja Johnson 11/4/17

#select companies that have Inc 
USE DEALS;

SELECT *
FROM Companies
WHERE CompanyName like "%Inc.";

# select all companies and sort by ID
SELECT *
FROM Companies
ORDER BY CompanyID;

#merge data from multiple tables
SELECT DealName, PartNumber, DollarValue
FROM Deals, DealParts
WHERE Deals.DealID = DealParts.DealID;

#merge data using join
SELECT DealName, PartNumber,DollarValue
FROM Deals JOIN DealParts on (Deals.DealID=DealParts.DealID);
 
#create a view using the joint query above - company deals
Drop View if exists 'CompanyDeals';
Create View CompanyDeals AS
SELECT DealName, RoleCode, CompanyName 
FROM Companies
	JOIN Players ON (Companies.CompanyID = Players.CompanyID)
	JOIN Deals ON (Players.DealID = Deals.DealID)
ORDER BY DealName;

# A test of the CompanyDeals view - Deal Values
Drop View if exists 'DealValues';
Create View DealValues AS
SELECT Deals.DealID, SUM(DollarValue) AS TotalDollarValue , COUNT(PartNumber) AS NumParts
FROM Deals JOIN DealParts ON (DEALS.DealID = DEALPARTS.DealID)
GROUP BY DEALS.DealID
ORDER BY DEALS.DealID;

#SELECT * from DealValues;

#create a view for Deal Summary
Drop View if exists 'DealSummary';
Create View DealSummary AS
SELECT DealID, DealName, PlayerID, TotalDollarValue, NumParts
FROM DEALs join DealValues ON (DEALs.DealID = DealValues.DealID) 
			join Players ON (DEALS.DealID = Players.DealID)
GROUP BY DEALS.DealID;

#create a view for deals by type - DealTypes
Drop View if exists 'DealTypes';
Create View DealTypes As
SELECT DISTINCT DealTypes.TypeCode, COUNT(Deals.DealID) AS NumDeals, SUM(DealParts.DollarValue) AS TotDollarValue
FROM Deal Types
	JOIN Deals ON (DealTypes.DealID = Deals.DealID) 
	JOIN DealParts ON (DealPart.DealID = Deals.DealID)
GROUP BY DealTypes.TypeCode;

#create a view deal players
Drop View if exists 'DealByPlayers';
CREATE View DealByPlayers AS
SELECT DealID, CompanyID, CompanyName, RoleCode
FROM Players
	JOIN Deals USING(DealID)
	JOIN Companies USING (CompanyID)
	JOIN RoleCodes USING (RoleCode)
ORDER BY RoleSortOrder;

#create a view for deals by firm
SELECT FirmID, 'Name' AS FirmName, COUNT(PLAYERS.DealID) AS NumDeals, SUM(TotDollarValue) AS TotValue
FROM Firms
	LEFT JOIN PlayerSupports USING (FirmID)
    LEFT JOIN Players USING (PlayerID)
    LEFT JOIN DealValues USING (DealID);
    
    