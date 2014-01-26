module Roler
  extend ActiveSupport::Concern

  def is_admin?
    has_role? :admin
  end

  def is_moderator?
    has_role? :moderator
  end

  def is_manager?
    has_role? :manager
  end

  def is_quoter?
    has_role? :quoter
  end

  def is_park?
    has_role? :park
  end

  def is_customer?
    self.roles.size == 1 and has_role? :customer
  end
end
