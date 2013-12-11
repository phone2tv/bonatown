class LineItem < ActiveRecord::Base
  # the default scope first (if any)
  scope :cancelled_count, lambda { where(workflow_state: 'cancelled').count }
  scope :uncommited_count, lambda { where(workflow_state: 'uncommitted').count }
  scope :committed_count, lambda { where(workflow_state: 'committed').count }
  scope :rejected_count, lambda { where(workflow_state: 'rejected').count }
  scope :verified_count, lambda { where(workflow_state: 'verified').count }
  scope :quoted_count, lambda { where(workflow_state: 'quoted').count }
  scope :paid_count, lambda { where(workflow_state: 'paid').count }
  scope :shipped_count, lambda { where(workflow_state: 'shipped').count }

# scope :items_in_cart, lambda { where("workflow_state = 'uncommitted' OR workflow_state = 'rejected' OR workflow_state = 'committed' OR workflow_state = 'verified' OR workflow_state = 'quoted'") }
# scope :items_in_cart, lambda { |states|
  scope :items_in_cart, lambda {
    states = ['uncommitted', 'committed', 'rejected', 'verified', 'quoted']
    conditions = []
    states.each do |state|
      conditions << "workflow_state = '#{state}'"
    end
    where(conditions.join(" or "))
  }

  scope :items_out_cart, lambda {
    states = ['cancelled', 'paid', 'shipped']
    conditions = []
    states.each do |state|
      conditions << "workflow_state = '#{state}'"
    end
    where(conditions.join(" or "))
  }


  # association macros
  belongs_to :insurance
  belongs_to :cart
  belongs_to :order

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

  aasm :column => 'workflow_state' do
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
