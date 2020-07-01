require 'rails_helper'

RSpec.describe QueryLog, type: :model do
  it { is_expected.to validate_inclusion_of(:query_type).in_array(QueryLog::VALID_TYPES) }
end
