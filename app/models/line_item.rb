class LineItem < ActiveRecord::Base
  belongs_to :insurance
  belongs_to :cart
  belongs_to :order
end
