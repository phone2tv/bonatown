class Order < ActiveRecord::Base
  # association macros
  has_many :line_items, dependent: :nullify

  # validation macros
  validates :aasm_state, :presence => true


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
