class Order < ActiveRecord::Base
  # association macros
  has_many :line_items, dependent: :nullify
  belongs_to :user

  # validation macros
  validates :aasm_state, :presence => true

  # instance methods
  def owned_by? owner
    return false unless owner.is_a? User
    user == owner
  end


  include AASM

  aasm :column => 'aasm_state' do
    state :unpaid, :initial => true
    state :paid
    state :shipped
    state :cancelled

    event :pay do
      transitions :from => :unpaid, :to => :paid
    end

    event :ship do
      transitions :from => :paid, :to => :shipped
    end

    event :cancel do
      transitions :from => :unpaid, :to => :cancelled
    end
  end
end
