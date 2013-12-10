class LineItem < ActiveRecord::Base
  # association macros
  belongs_to :insurance
  belongs_to :cart
  belongs_to :order

  # STATE:
  #   uncommited(init), cancelled, unverified, unquoted, unpaid, unshipped, shipped, rejected
  #
  # ACTION:
  #   customer, commit,    uncommited -> unverified
  #   customer, cancel,    uncommited -> cancelled
  #   customer, commit,    rejected   -> unverified
  #   customer, cancel,    rejected   -> cancelled
  #
  #   manager,  verify,    unverified -> unquoted
  #   manager,  reject,    unverified -> rejected
  #
  #   quoter,   quote,     unquoted   -> unpaid
  #   quoter,   reject,    unquoted   -> rejected
  #
  #   customer, pay,       unpaid     -> unshipped
  #   customer, cancel,    unpaid     -> cancelled
  #
  #   quoter,   ship,      unshipped  -> shipped
  #
  #
  # TODO:
  #
  # STATE:
  #   surrendered
  #
  # ACTION:
  #   surrender, shipped    -> surrendered
  #
  include Workflow
  workflow do
    # customer
    state :uncommited do
      event :commit, :transitions_to => :unverified
      event :cancel, :transitions_to => :cancelled
    end
    # customer
    state :rejected do
      event :commit, :transitions_to => :unverified
      event :cancel, :transitions_to => :cancelled
    end
    # manager
    state :unverified do
      event :verify, :transitions_to => :unquoted
      event :reject, :transitions_to => :rejected
    end
    # quoter
    state :unquoted do
      event :quote, :transitions_to => :unpaid
      event :reject, :transitions_to => :rejected
    end
    # customer
    state :unpaid do
      event :pay, :transitions_to => :unshipped
      event :cancel, :transitions_to => :cancelled
    end
    # quoter
    state :unshipped do
      event :ship, :transitions_to => :shipped
    end
    state :cancelled do
    end
    state :shipped do
    end
  end

# def quote
#   puts 'quote() : current state is: ' + self.workflow_state
# end
end
