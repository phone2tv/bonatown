class Order < ActiveRecord::Base
  # association macros
  has_many :line_items, dependent: :nullify
end
