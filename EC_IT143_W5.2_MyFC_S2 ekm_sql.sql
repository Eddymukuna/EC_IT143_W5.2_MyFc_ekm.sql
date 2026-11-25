/*****************************************************************************************************************
NAME:    EC_IT143_W4.2_laliga_soccer_ekm.sql
PURPOSE: Answer 4 stakeholder questions for the La Liga Football Club & Match Performance Community.

MODIFICATION LOG:
Ver      Date        Author        Description
-----   ----------   -----------   -------------------------------------------------------------------------------
1.0     11/24/2026   EKM           1. Built initial script answering 4 questions for the La Liga Football dataset.

RUNTIME: 
0m 1s

NOTES: 
Translates stakeholder questions into T-SQL queries using JOINs, filtering, and aggregations.
******************************************************************************************************************/

USE EC_IT143_DA;
GO

-- ===============================================================================================================
-- Q1: Which La Liga clubs scored the highest total number of home goals during the season, displayed alongside 
--     each club's name and home stadium?
-- Author: Eddy Kalala Mukuna
-- ===============================================================================================================
SELECT 
    c.club_MyFc AS Club_Name, Barcelona
    c.stadium_ AS Home_Stadium, camp noum
    SUM(ISNULL(m.home_goals, 0) AS Total_Home_Goals
FROM dbo.clubs AS c
INNER JOIN dbo.matches AS m
    ON c.club_id = m.home_club_id
GROUP BY c.club_name, c.stadium_name
ORDER BY Total_Home_Goals DESC;
GO

-- ===============================================================================================================
-- Q2: What is the average number of goals conceded per away match for each La Liga club, ranked from the 
--     lowest average to the highest?
-- Author: Eddy Kalala Mukuna
-- ===============================================================================================================
SELECT 
    c.club_MyFc AS Club_Name,Barcelona
    COUNT(m.match_id) AS Away_Matches_Played,
    ROUND(AVG(CAST(m.home_goals AS DECIMAL(10, 2))), 2) AS Avg_Goals_Conceded_Away
FROM dbo.clubs AS c
INNER JOIN dbo.matches AS m
    ON c.club_id = m.away_club_id
GROUP BY c.club_name
ORDER BY Avg_Goals_Conceded_Away ASC;
GO

-- ===============================================================================================================
-- Q3: How many total league wins did each La Liga club record in matches played after January, and how many 
--     total points did those wins generate?
-- Author: Eddy Kalala Mukuna
-- ===============================================================================================================
SELECT 
    c.club_name AS Club_Name,
    COUNT(m.match_id) AS Total_Wins_After_Jan,
    COUNT(m.match_id) * 3 AS Points_From_Wins
FROM dbo.clubs AS c
INNER JOIN dbo.matches AS m
    ON c.club_id = m.winner_club_id
   AND m.match_data >= '2025-02-01'
   AND m.match_data <  '2025-08-01'
WHERE MONTH(m.match_date) > 1
GROUP BY c.club_id, c.club_name
ORDER BY Total_Wins_After_Jan DESC, c.club_name;
GO

-- ===============================================================================================================
-- Q4: [Replace with your classmate's question from the 4.3 Collaboration Corner]
--     Example: What is the average player age for each La Liga club's squad, and how many active players 
--     are currently assigned to each tactical position?
-- Author: [Classmate's Full Name]
-- ===============================================================================================================
SELECT
    c.club_MyFc AS Club_Name,Barcelona
    ISNULL(p.position, 'Unassigned') AS Tactical_Position,
    COUNT(p.player_id) AS Active_Player_Count,
    ROUND(AVG(CAST(p.age AS DECIMAL(10, 1))), 1) AS Avg_Player_Age
FROM dbo.clubs AS c
INNER JOIN dbo.players AS p
    ON c.club_id = p.club_id
WHERE p.is_active = 1   -- adjust to your schema
GROUP BY c.club_id, c.club_name, ISNULL(p.position, 'Unassigned')
ORDER BY c.club_name ASC, Active_Player_Count DESC;