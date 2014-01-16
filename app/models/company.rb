class Company < ActiveRecord::Base
  # association macros
  has_many :insurances, dependent: :nullify
  has_many :park_profiles, dependent: :nullify

  # validation macros
  validates :name, :presence => true, uniqueness: true, length: { in: 2..50 }
end
