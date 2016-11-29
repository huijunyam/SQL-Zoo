# == Schema Information
#
# Table name: countries
#
#  name        :string       not null, primary key
#  continent   :string
#  area        :integer
#  population  :integer
#  gdp         :integer

require_relative './sqlzoo.rb'

# BONUS QUESTIONS: These problems require knowledge of aggregate
# functions. Attempt them after completing section 05.

def highest_gdp
  # Which countries have a GDP greater than every country in Europe? (Give the
  # name only. Some countries may have NULL gdp values)
  execute(<<-SQL)
    SELECT
      countries.name
    FROM
      countries
    WHERE gdp > (
      SELECT
        MAX(gdp)
      FROM
        countries
      WHERE
        continent = 'Europe'
    )
  SQL
end

def largest_in_continent
  # Find the largest country (by area) in each continent. Show the continent,
  # name, and area.
  execute(<<-SQL)
    SELECT
      a1.continent, a1.name, a1.area
    FROM
      countries a1
    WHERE
      a1.area = (
        SELECT
          MAX(a2.area)
        FROM
          countries a2
        WHERE
          a1.continent = a2.continent
      )

  SQL
end

def large_neighbors
  # Some countries have populations more than three times that of any of their
  # neighbors (in the same continent). Give the countries and continents.
  execute(<<-SQL)
    SELECT
      a1.name, a1.continent
    FROM
      countries a1
    WHERE
      a1.population > 3 * (
        SELECT
          MAX(a2.population)
        FROM
          countries a2
        WHERE
          a1.continent = a2.continent AND a2.population != a1.population
      )
  SQL
end
