class PublicLiabilityItem < ActiveRecord::Base
  BUSINESS_TYPE = [ ["production", 0], ["sale", 1], ["storage", 2] ]

  # association macros
  belongs_to :specific_insurance, class_name: 'PublicLiabilityInsurance', foreign_key: 'insurance_id'
# belongs_to :insurance
  has_one :insurance_business, as: :business_owner, class_name: 'InsuranceBusiness', dependent: :destroy
  accepts_nested_attributes_for :insurance_business, update_only: true
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

  def update_with_conflict_validation(*args)
    update(*args)
  rescue ActiveRecord::StaleObjectError
    errors.add :base, "This record changed while you were editing it."
    false
  end
end
