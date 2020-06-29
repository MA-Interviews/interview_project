class Population < ApplicationRecord

  def self.min_year
    Population.minimum(:year).year
  end

  def self.max_year
    Population.maximum(:year).year
  end

  def self.get(year)
    year = year.to_i

    if year < min_year
      0
    elsif year > max_year
      closest_past_population_for(year).population
    else
      Population.find_by_year(Date.new(year))&.population || estimated_population(year)
    end
  end

  def self.estimated_population(year)
    past_pop = closest_past_population_for(year)
    future_pop = closest_future_population_for(year)
    population_increase_per_year = population_increase_per_year(past_pop, future_pop)
    years_after_past_pop = year - past_pop.year.year

    past_pop.population + population_increase_per_year * years_after_past_pop
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
