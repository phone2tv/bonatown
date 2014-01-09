class LineItem < ActiveRecord::Base
  # the default scope first (if any)

  # association macros
  belongs_to :insurance_item, polymorphic: true
  belongs_to :user
  belongs_to :cart
  belongs_to :order

  # validation macros
  validates :aasm_state, :presence => true

  # macros from gems
  acts_as_traceable

  # instance methods
  def owned_by? owner
    return false unless owner.is_a? User
    user == owner
  end

  # STATE:
  #   uncommitted(init), cancelled, rejected, committed, verified, quoted, paid, shipped
  #
  # ACTION:
  #   customer, commit,    uncommitted -> committed
  #   customer, cancel,    uncommitted -> cancelled
  #   customer, commit,    rejected   -> committed
  #   customer, cancel,    rejected   -> cancelled
  #
  #   manager,  verify,    committed -> verified
  #   manager,  reject,    committed -> rejected
  #
  #   quoter,   quote,     verified   -> quoted
  #   quoter,   reject,    verified   -> rejected
  #
  #   customer, pay,       quoted     -> paid
  #   customer, cancel,    quoted     -> cancelled
  #
  #   quoter,   ship,      paid  -> shipped
  #
=begin
  include Workflow
  workflow do
    # customer
    state :uncommitted do
      event :commit, :transitions_to => :committed
      event :cancel, :transitions_to => :cancelled
    end
    # customer
    state :rejected do
      event :commit, :transitions_to => :committed
      event :cancel, :transitions_to => :cancelled
    end
    # manager
    state :committed do
      event :verify, :transitions_to => :verified
      event :reject, :transitions_to => :rejected
    end
    # quoter
    state :verified do
      event :quote, :transitions_to => :quoted
      event :reject, :transitions_to => :rejected
    end
    # customer
    state :quoted do
      event :pay, :transitions_to => :paid
      event :cancel, :transitions_to => :cancelled
    end
    # quoter
    state :paid do
      event :ship, :transitions_to => :shipped
    end
    state :cancelled do
    end
    state :shipped do
    end
  end
=end

  include AASM

  aasm :column => 'aasm_state' do
    state :uncommitted, :initial => true
    state :committed
    state :cancelled
    state :verified
    state :quoted
    state :rejected
    state :paid
    state :shipped

    # customer
    event :commit do
      transitions :from => [:uncommitted, :rejected], :to => :committed
    end

    # customer
    event :cancel do
      transitions :from => [:uncommitted, :rejected, :quoted], :to => :cancelled
    end

    # manager
    event :verify do
      transitions :from => :committed, :to => :verified
    end

    # quoter
    event :quote do
      transitions :from => :verified, :to => :quoted
    end

    # manager or quoter
    event :reject do
      transitions :from => [:committed, :verified], :to => :rejected
    end

    # customer
    event :pay do
      transitions :from => :quoted, :to => :paid
    end

    # quoter
    event :ship do
      transitions :from => :paid, :to => :shipped
    end
  end
end
