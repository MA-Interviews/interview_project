require 'rails_helper'

RSpec.describe Population, type: :model do
  let(:first_known_year) { Population.min_year }
  let(:first_known_population) { Population.find_by_year(Date.new(first_known_year)).population }
  let(:first_known_population_increase_per_year) { 1601632 }

  let(:last_known_year) { Population.max_year }
  let(:last_known_population) { Population.find_by_year(Date.new(last_known_year)).population }

  it "should accept a year we know and return the correct population" do
    expect(Population.get(first_known_year)).to eq(first_known_population)
    expect(Population.get(last_known_year)).to eq(last_known_population)
  end

  it "should accept a year we don't know and return an estimated population" do
    expect(Population.get(first_known_year + 2)).to eq(first_known_population + first_known_population_increase_per_year * 2)
    expect(Population.get(first_known_year + 8)).to eq(first_known_population + first_known_population_increase_per_year * 8)
  end

  it "should accept a year that is before earliest known and return zero" do
    expect(Population.get(first_known_year - 1)).to eq(0)
    expect(Population.get(0)).to eq(0)
    expect(Population.get(-1000)).to eq(0)
  end

  it "should accept a year that is after latest known and return the last known population" do
    expect(Population.get(last_known_year + 1)).to eq(last_known_population)
    expect(Population.get(last_known_year + 1000)).to eq(last_known_population)
  end

end
