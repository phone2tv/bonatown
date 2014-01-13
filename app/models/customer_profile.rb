class CustomerProfile < ActiveRecord::Base
  # attributes related macros
  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h
  mount_uploader :business_license, BusinessLicenseUploader

  # association macros
  has_one :user, as: :profile, dependent: :destroy
  accepts_nested_attributes_for :user, update_only: true
  belongs_to :park_profile
end
