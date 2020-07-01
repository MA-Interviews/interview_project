class QueryLog < ApplicationRecord
  EXACT_TYPE = 'Exact'.freeze
  CALCULATED_TYPE = 'Calculated'.freeze
  VALID_TYPES = [EXACT_TYPE, CALCULATED_TYPE].freeze
  validates_inclusion_of :query_type, in: VALID_TYPES
end
