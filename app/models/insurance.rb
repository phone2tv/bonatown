class Insurance < ActiveRecord::Base
  belongs_to :company
  belongs_to :profile, polymorphic: true
end
