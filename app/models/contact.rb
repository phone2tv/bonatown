class Contact < ActiveRecord::Base
  # constants
  CARD_TYPE = [ 'idcard', 'armcard', 'passport', 'driving_license', 'simplified_chinese', 'other' ]
  GENDER = [ ['secrecy', 's'], ['man', 'm'], ['woman', 'w'] ]

  # association macros
  belongs_to :customer_profile

  # validation macros
  validates :gender, presence: true, length: { is: 1 }
end
