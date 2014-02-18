class InsuranceBusiness < ActiveRecord::Base
  # association macros
  belongs_to :business_owner, polymorphic: true
end
