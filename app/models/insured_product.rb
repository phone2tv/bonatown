class InsuredProduct < ActiveRecord::Base
  belongs_to :product_liability_item
end
