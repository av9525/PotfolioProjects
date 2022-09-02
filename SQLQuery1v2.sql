select * from PortfolioProject.dbo.CovidDeaths
Where continent is not null
order by 1,2


select location, date, total_cases, new_cases, total_deaths, population
from PortfolioProject.dbo.CovidDeaths
Where continent is not null
order by 1,2 

---Looking at total cases vs total deaths 

Select Location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
From PortfolioProject.dbo.CovidDeaths
Where Location like '%India%' and continent is not null
order by 1,2 

----Looking at the total cases vs the population
----Shows what percentage of population got Covid
Select Location, date, population,  total_cases,(total_cases/population)*100 as PercentagePopulation
From PortfolioProject.dbo.CovidDeaths
Where Location like '%India%' and continent is not null
order by 1,2 

----Looking at countries with highest infection rate compared to population
Select Location, population,  max(total_cases) as HighestInfectionCount, max((total_cases/population))*100 as PercentagePopulation
From PortfolioProject.dbo.CovidDeaths
Where continent is not null
Group By Location, population
order by PercentagePopulation desc


---- Showing Countries with Highest Death count per population

Select location, max(CAST(total_deaths as int)) as TotalDeathCount
From PortfolioProject.dbo.CovidDeaths
Where continent is not null
Group By Location
order by TotalDeathCount desc


----- Breaking down by Continent

Select Continent, max(CAST(total_deaths as int)) as TotalDeathCount
From PortfolioProject.dbo.CovidDeaths
Where continent is not null
Group By Continent
order by TotalDeathCount desc

------ Global Numbers 

Select date, Sum(new_cases) as total_cases, Sum(cast(new_deaths as int)) as total_deaths, Sum(cast(new_deaths as int))/Sum(new_cases)*100 as DeathPercentage ---total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
From PortfolioProject.dbo.CovidDeaths
----Where Location like '%India%' and 
where continent is not null
group by date 
order by 1,2 

----Looking at population vs vaccination

Select d.continent,d.location,d.date,d.population,v.new_vaccinations, Sum(Case when (convert(int,v.new_vaccinations)) is null then 0 else 1 end) Over(partition by d.location order by d.location, d.date) as rollingpeoplevaccinated
from PortfolioProject.dbo.CovidDeaths D
Join PortfolioProject.dbo.CovidVaccinations V
on D.location = v.location
and d.date = v.date
where d.continent is not null
order by 2,3


