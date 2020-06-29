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
      Population.find_by(year: Date.new(max_year))&.population
    else
      Population.where('year <= ?', Date.new(year))
                .order(year: :desc)
                .limit(1)
                .first&.population
    end
  end
end
