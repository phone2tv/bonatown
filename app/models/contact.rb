class Contact < ActiveRecord::Base
  # constants
  CARD_TYPE = [ "idcard", "armcard", "passport", "driving_license", "simplified_chinese", "other" ]

  # association macros
  belongs_to :customer_profile
end
