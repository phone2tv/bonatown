class LineItem < ActiveRecord::Base
  # association macros
  belongs_to :insurance
  belongs_to :cart
  belongs_to :order

  # STATE:
  #   uncommited(init), unverified, unquoted, unpaid, unshipped, shipped, rejected
  #
  # ACTION:
  #   commit,    uncommited -> unverified
  #
  #   verify,    unverified -> unquoted
  #   reject,    unverified -> rejected
  #
  #   quote,     unquoted   -> unpaid
  #   reject,    unquoted   -> rejected
  #
  #   pay,       unpaid     -> unshipped
  #   cancel,    unpaid     -> canceled
  #
  #   ship,      unshipped  -> shipped
  #
  #   surrender, shipped    -> surrendered
  #
  include Workflow
  workflow do
    state :uncommited do
      event :commit, :transitions_to => :unverified
    end
    state :unverified do
      event :verify, :transitions_to => :unquoted
      event :reject, :transitions_to => :rejected
    end
    state :unquoted do
      event :quote, :transitions_to => :unpaid
      event :reject, :transitions_to => :rejected
    end
    state :unpaid do
      event :pay, :transitions_to => :unshipped
      event :cancel, :transitions_to => :canceled
    end
    state :unshipped do
      event :ship, :transitions_to => :shipped
    end
    state :shipped do
      event :surrender, :transitions_to => :surrendered
    end
  end

  def quote
    puts 'quote() : current state is: ' + self.workflow_state
  end
end
