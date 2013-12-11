class Insurance < ActiveRecord::Base
  # the default scope first (if any)
  scope :healths, lambda { where(profile_type: 'HealthInsurance') }

  # association macros
  belongs_to :company
  belongs_to :profile, polymorphic: true
  has_many :line_items, dependent: :nullify

  # validation macros
  validates :title, :presence => true, length: { in: 4..50 }
  validates :price, numericality: true
  validates :aasm_state, :presence => true
  validates :company_id, :presence => true

  before_destroy :ensure_not_referenced_by_any_line_item

  private

  # ensure that there are no line items referencing this product
  def ensure_not_referenced_by_any_line_item
    if line_items.empty?
      return true
    else
      errors.add(:base, 'Line Items present')
      return false
    end
  end

  include AASM

  aasm do
    state :online, :initial => true
    state :offline

    event :put_down do
      transitions :from => :online, :to => :offline
    end

    event :put_up do
      transitions :from => :offline, :to => :online
    end
  end
end
