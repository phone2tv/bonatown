class Cart < ActiveRecord::Base
  # association macros
  has_many :line_items, dependent: :nullify
  belongs_to :customer_profile
end
