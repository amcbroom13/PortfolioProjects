--Database Name--
USE [Genshin Character Project];

SELECT * FROM [dbo].[Genshin Character List];

--Reformatting the Release Date to only show the Date (YYYY/MM/DD format)--
ALTER TABLE [dbo].[Genshin Character List]
ALTER COLUMN [Release Date] DATE;


--Fixing spelling error in "Body Type" column--
UPDATE [dbo].[Genshin Character List]
SET [Body Type] = 'Medium Female'
WHERE Name = 'Xinyan';


--Changed Primary & Secondary Role for Kaedehara Kazuha--
UPDATE [dbo].[Genshin Character List]
SET [Primary Role] = 'Crowd Control', [Secondary Role] = 'Buffer'
WHERE Name = 'Kaedehara Kazuha';


--Updating Dehya's Constellation name--
UPDATE [dbo].[Genshin Character List]
SET Constellation = 'Mantichora'
WHERE Name = 'Dehya';


--Release Date updated for Version 3.7--
UPDATE [dbo].[Genshin Character List]
SET [Release Date] = '2023-05-24'
WHERE Name = 'Kirara';


--Characters released during Version 1 (September 28, 2020 - June 20, 2021)--
SELECT Name, Element, Weapon, Region, [Primary Role], [Body Type], [Version Release], [Release Date]
FROM [dbo].[Genshin Character List]
WHERE [Version Release] BETWEEN 1.0 AND 1.6;


--Characters released during Version 2 (July 21, 2021 - August 23, 2022)--
SELECT Name, Element, Weapon, Region, [Primary Role], [Body Type], [Version Release], [Release Date]
FROM [dbo].[Genshin Character List]
WHERE [Version Release] BETWEEN 2.0 AND 2.8;


--Characters released during Version 3 (August 24, 2022 - Present)--
SELECT Name, Element, Weapon, Region, [Primary Role], [Body Type], [Version Release], [Release Date]
FROM [dbo].[Genshin Character List]
WHERE [Version Release] >= 3.0 AND Playable = 'Y';


--NOTE: All 'Dendro' Element characters are, by default, released no earlier than Version 3.0 due to the element releasing in this same version.--
--NOTE #2: NULL Values in Secondary Role column means that the character doesn't excel or perform effectively in roles besides their Primary Role--
--NOTE #3: Traveler's Element & Region are NULL as they are Ooutlanders who do not originate from Teyvat (where Genshin Impact's world is based in)--


--List of Dendro characters in the game in order of Release--
SELECT Name, Element, Weapon, Region, [Primary Role], [Body Type], [Version Release]
FROM [dbo].[Genshin Character List]
WHERE Element = 'Dendro'
ORDER BY [Version Release], Region, Name;


--List of Electro characters in the game in order of Release--
SELECT Name, Element, Weapon, Region, [Primary Role], [Body Type], [Version Release]
FROM [dbo].[Genshin Character List]
WHERE Element = 'Electro'
ORDER BY [Version Release], Region, Name;


--List of Hydro characters in the game in order of Release--
SELECT Name, Element, Weapon, Region, [Primary Role], [Body Type], [Version Release]
FROM [dbo].[Genshin Character List]
WHERE Element = 'Hydro'
ORDER BY [Version Release], Region, Name;


--List of Pyro characters in the game in order of Release--
SELECT Name, Element, Weapon, Region, [Primary Role], [Body Type], [Version Release]
FROM [dbo].[Genshin Character List]
WHERE Element = 'Pyro'
ORDER BY [Version Release], Region, Name;


--List of Dendro characters in the game in order of Release--
SELECT Name, Element, Weapon, Region, [Primary Role], [Body Type], [Version Release]
FROM [dbo].[Genshin Character List]
WHERE Element = 'Cryo'
ORDER BY [Version Release], Region, Name;


--List of Geo characters in the game in order of Release--
SELECT Name, Element, Weapon, Region, [Primary Role], [Body Type], [Version Release]
FROM [dbo].[Genshin Character List]
WHERE Element = 'Geo'
ORDER BY [Version Release], Region, Name;


--List of Anemo characters in the game in order of Release--
SELECT Name, Element, Weapon, Region, [Primary Role], [Body Type], [Version Release]
FROM [dbo].[Genshin Character List]
WHERE Element = 'Anemo'
ORDER BY [Version Release], Region, Name;


--Number of 5-Star Characters by Region--
SELECT Region, COUNT(Name) AS 'Number of 5-Star Characters'
FROM [dbo].[Genshin Character List]
WHERE Rarity = 5 AND Region IS NOT NULL
GROUP BY Region;


--Number of 4-Star Characters by Region--
SELECT Region, COUNT(Name) AS 'Number of 4-Star Characters'
FROM [dbo].[Genshin Character List]
WHERE Rarity = 4
GROUP BY Region;


--Characters from Mondstadt Region--
SELECT Name, Element, Weapon, [Region], [Primary Role], [Body Type], [Version Release]
FROM [dbo].[Genshin Character List]
WHERE Region='Mondstadt';


--Characters from Liyue Region--
SELECT Name, Element, Weapon, [Region], [Primary Role], [Body Type], [Version Release]
FROM [dbo].[Genshin Character List]
WHERE Region='Liyue';


--Characters from Inazuma Region--
SELECT Name, Element, Weapon, [Region], [Primary Role], [Body Type], [Version Release]
FROM [dbo].[Genshin Character List]
WHERE Region='Inazuma';


--Characters from Sumeru Region--
SELECT Name, Element, Weapon, [Region], [Primary Role], [Body Type], [Version Release]
FROM [dbo].[Genshin Character List]
WHERE Region='Sumeru';


--Total count of characters by Body Type--
SELECT [Body Type], COUNT([Body Type]) AS Total
FROM [dbo].[Genshin Character List]
GROUP BY [Body Type]
ORDER BY [Body Type];


--Total count of characters by Element--
SELECT Element, COUNT(Element) AS Total
FROM [dbo].[Genshin Character List]
WHERE Element IS NOT NULL
GROUP BY Element;

--Total count of characters by Weapon--
SELECT Weapon, COUNT(Weapon) AS Total
FROM [dbo].[Genshin Character List]
GROUP BY Weapon;


--Total count of characters by their Main Role--
SELECT [Primary Role], COUNT([Primary Role]) AS Total
FROM [dbo].[Genshin Character List]
GROUP BY [Primary Role];