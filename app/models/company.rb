class Company < ActiveRecord::Base
  has_many :accident_insurances, dependent: :nullify
end
