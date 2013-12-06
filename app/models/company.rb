class Company < ActiveRecord::Base
  has_many :accident_insurances, dependent: :nullify
  has_many :insurances, dependent: :nullify
end
