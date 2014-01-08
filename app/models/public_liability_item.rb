class PublicLiabilityItem < ActiveRecord::Base
  BUSINESS_TYPE = [ ["production", 0], ["sale", 1], ["storage", 2] ]

  # association macros
  belongs_to :specific_insurance, class_name: 'PublicLiabilityInsurance', foreign_key: 'insurance_id'
# belongs_to :insurance
  has_one :line_item, as: :insurance_item, dependent: :destroy
  accepts_nested_attributes_for :line_item, update_only: true
  has_many :elevators, dependent: :destroy
  accepts_nested_attributes_for :elevators, :reject_if => lambda { |a| a[:kind].blank? }, :allow_destroy => true

  # validation macros
  validates :insurance_id, presence: true
  validates :business_type, presence: true

  # instance methods
  def owned_by? owner
    return false unless owner.is_a? User
    line_item.user == owner
  end
end
