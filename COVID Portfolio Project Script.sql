SELECT *
FROM PortfolioProject..CovidDeaths
WHERE continent IS NOT NULL
ORDER BY 3,4

--SELECT *
--FROM PortfolioProject..CovidVaccinations
--ORDER BY 3,4


-- Looking at Total Cases vs. Total Deaths

SELECT Location, date, total_cases, new_cases, total_deaths, population
FROM PortfolioProject..CovidDeaths
ORDER BY 1,2


-- Shows the likelihood of dying if one has been infected

SELECT Location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
FROM PortfolioProject..CovidDeaths
WHERE Location like '%states'
ORDER BY 1,2


-- Looking at Total Cases vs. Population & Percentage of Population that got COVID-19

SELECT Location, date, population, total_cases, (total_cases/population)*100 as PercentInfected
FROM PortfolioProject..CovidDeaths
WHERE Location like '%states'
ORDER BY 1,2


-- Looking at Countries with Highest Infection Rate compared to Population

SELECT Location, population, MAX(total_cases) as HighestInfectionCount, MAX((total_cases/population)*100) as PercentInfected
FROM PortfolioProject..CovidDeaths
--Where Location like '%states'
GROUP BY Location, population
ORDER BY PercentInfected DESC


-- Showing Countries with Highest Death Count per Population

SELECT Location, MAX(cast(total_deaths AS int)) as TotalDeathCount
FROM PortfolioProject..CovidDeaths
--Where Location like '%states%'
WHERE continent IS NOT NULL
GROUP BY Location
ORDER BY TotalDeathCount DESC


-- Same as above, but by Continent

SELECT continent, MAX(cast(total_deaths AS int)) as TotalDeathCount
FROM PortfolioProject..CovidDeaths
--Where Location like '%states%'
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY TotalDeathCount DESC


-- Showing Continents with the Highest Death Count per Population

SELECT continent, MAX(cast(total_deaths AS int)) as TotalDeathCount
FROM PortfolioProject..CovidDeaths
--Where Location like '%states%'
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY TotalDeathCount DESC


-- Numbers for Worldwide Data

SELECT SUM(new_cases) as total_cases, SUM(cast(new_deaths AS int)) as total_deaths, SUM(cast(new_deaths AS int))/SUM(new_cases)*100 AS DeathPercentage
FROM PortfolioProject..CovidDeaths
--Where Location like '%states%'
WHERE continent IS NOT NULL
--GROUP BY date
ORDER BY 1,2


-- Looking at Total Population vs. Vaccinations

SELECT dea.continent, dea.Location, dea.date, dea.population, vac.new_vaccinations,
SUM(CONVERT(int, vac.new_vaccinations)) OVER (PARTITION BY dea.Location ORDER BY dea.Location, dea.date) as RollingPeopleVaccinated,
--(RollingPeopleVaccinated/population)*100
FROM PortfolioProject..CovidDeaths dea
JOIN PortfolioProject..CovidVaccinations vac
	ON dea.Location = vac.Location
	AND dea.date = vac.date
WHERE dea.continent IS NOT NULL
ORDER BY 2,3


-- Using CTE

WITH PopvsVac (continent, Location, date, population, new_vaccinations, RollingPeopleVaccinated) as
(
SELECT dea.continent, dea.Location, dea.date, dea.population, vac.new_vaccinations,
SUM(CONVERT(int, vac.new_vaccinations)) OVER (PARTITION BY dea.Location ORDER BY dea.Location, dea.date) as RollingPeopleVaccinated
--(RollingPeopleVaccinated/population)*100
FROM PortfolioProject..CovidDeaths dea
JOIN PortfolioProject..CovidVaccinations vac
	ON dea.Location = vac.Location
	AND dea.date = vac.date
WHERE dea.continent IS NOT NULL
--ORDER BY 2,3
)
SELECT *, (RollingPeopleVaccinated/population)*100
FROM PopvsVac


-- TEMP TABLE

DROP Table if EXISTS #PercentPopulationVaccinated
CREATE Table #PercentPopulationVaccinated

(continent nvarchar(255), Location nvarchar(255), date datetime, population numeric, new_vaccinations numeric, RollingPeopleVaccinated numeric)

Insert into #PercentPopulationVaccinated
SELECT dea.continent, dea.Location, dea.date, dea.population, vac.new_vaccinations,
SUM(CONVERT(int, vac.new_vaccinations)) OVER (PARTITION BY dea.Location ORDER BY dea.Location, dea.date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
FROM PortfolioProject..CovidDeaths dea
JOIN PortfolioProject..CovidVaccinations vac
	ON dea.Location = vac.Location
	AND dea.date = vac.date
WHERE dea.continent IS NOT NULL
--ORDER BY 2,3

SELECT*, (RollingPeopleVaccinated/population)*100
FROM #PercentPopulationVaccinated


-- Creating View to store data for later visualizations

USE PortfolioProject
GO

CREATE VIEW PercentPopulationVaccinated AS
SELECT dea.continent, dea.Location, dea.date, dea.population, vac.new_vaccinations,
SUM(CONVERT(int, vac.new_vaccinations)) OVER (PARTITION BY dea.Location ORDER BY dea.Location, dea.date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
FROM PortfolioProject..CovidDeaths dea
JOIN PortfolioProject..CovidVaccinations vac
	ON dea.Location = vac.Location
	AND dea.date = vac.date
WHERE dea.continent IS NOT NULL
--ORDER BY 2,3


SELECT *
FROM PercentPopulationVaccinated
