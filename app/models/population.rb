class Population < ApplicationRecord
  GROWTH_RATE = 1.09.freeze
  MAX_FUTURE_YEAR = 2500.freeze

  def self.min_year
    Population.minimum(:year).year
  end

  def self.max_year
    Population.maximum(:year).year
  end

  def self.get(year)
    year = year.to_i
    population = if year < min_year
                   0
                 elsif year > max_year
                   estimated_future_population(year)
                 else
                   Population.find_by_year(Date.new(year))&.population || estimated_population(year)
                 end
    QueryLog.create(year: year, population: population)
    population
  end

  def self.estimated_population(year)
    past_pop = closest_past_population_for(year)
    future_pop = closest_future_population_for(year)
    population_increase_per_year = population_increase_per_year(past_pop, future_pop)
    years_after_past_pop = year - past_pop.year.year

    past_pop.population + population_increase_per_year * years_after_past_pop
  end

  def self.estimated_future_population(year)
    last_known_population = closest_past_population_for(year)
    time = year - last_known_population.year.year
    (last_known_population.population * GROWTH_RATE ** time).to_i
  end

  def self.closest_past_population_for(year)
    Population.where("year <= ?", Date.new(year)).order(year: :desc).limit(1).first
  end

  def self.closest_future_population_for(year)
    Population.where("year >= ?", Date.new(year)).order(:year).limit(1).first
  end

  def self.population_increase_per_year(past_pop, future_pop)
    (future_pop.population - past_pop.population) / (future_pop.year.year - past_pop.year.year)
  end
end
