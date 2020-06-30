require 'rails_helper'

RSpec.describe "Get population by year", type: :system do
  it "User is presented with an input form" do
    visit populations_path
    assert_selector "input[name=year]"
    assert_selector "button[type=submit]"
  end

  context "When user enters a valid year" do
    let(:valid_year) { 1900 }

    subject do
      visit populations_path
      fill_in 'year', with: valid_year
      click_button 'Submit'
    end

    before do
      subject
    end

    it "redirects to a results page" do
      expect(page).to have_current_path(populations_by_year_path(year: valid_year))
    end

    it "shows a population figure" do
      expect(page).to have_text(/Population: \d/)
    end

    it "has another form for additional queries" do
      assert_selector "input[name=year]"
      assert_selector "button[type=submit]"
    end
  end
end
