class Permission
  def initialize(user)
    # as guest
    allow :sessions, [:new, :create]
    allow :registrations, [:new, :create, :cancel]
    allow :users, [:index]
    allow :stores, [:show, :tagged]
    allow :orders, [:index]
    allow [:line_items], [:index, :show]
    allow [:insurances, :accident_insurances, :public_liability_insurances, :product_liability_insurances, :employer_liability_insurances, :health_insurances], [:index, :show]
    if user
      # as user
      allow :sessions, [:destroy]
      allow :registrations, [:edit, :update, :destroy, :edit_password, :update_password]
      allow :users, [:show] do |u|
        user.id == u.id
      end
      allow :users, [:new_admin, :create_admin, :new_moderator, :create_moderator] do |u|
        user.is_admin?
      end
      allow :users, [:new_manager, :create_manager] do |u|
        user.is_admin? or user.is_moderator?
      end
      allow :users, [:new_quoter, :create_quoter, :new_park, :create_park, :new_customer, :create_customer] do |u|
        user.is_manager?
      end
      allow :users, [:edit, :update] do |u|
        user.id == u.id or
        user.is_admin? or
        user.is_moderator? && (is_manager? || u.is_quoter? || u.is_park? || u.is_customer?) or
        user.is_manager? && (u.is_quoter? || u.is_park? || u.is_customer?)
      end
      allow [:admin_profiles, :moderator_profiles, :manager_profiles, :quoter_profiles], [:new, :edit, :create, :update, :destroy] do |profile|
        user.id == profile.user.id or user.is_admin?
      end
      allow [:park_profiles, :customer_profiles], [:new, :edit, :create, :update, :destroy] do |profile|
        user.id == profile.user.id or user.is_admin?
      end
      allow [:contacts], [:index, :new, :create] do |contact|
        user.is_customer?
      end
      allow [:contacts], [:show, :edit, :update, :destroy] do |contact|
        user.profile.id == contact.customer_profile.id or user.is_admin?
      end
      # carts
      allow :carts, [:show, :destroy] do |cart|
        user.is_customer? and cart.owned_by?(user)
      end
      # companies
      allow [:companies], [:index, :show] do |company|
        user.is_admin?
      end
      allow [:companies, :insurances, :accident_insurances, :public_liability_insurances, :product_liability_insurances, :employer_liability_insurances, :health_insurances], [:new, :edit, :create, :update, :destroy] do |company|
        user.is_admin?
      end
      # orders
      allow :orders, [:new, :create] do |order|
        user.is_customer? && !user.line_items.where(order_id: nil).quoted.empty?
      end
      allow :orders, [:edit, :update] do |order|
        order.owned_by? user
      end
      allow :orders, :show do |order|
        order.owned_by?(user) or user.is_manager? or user.is_admin?
      end
      allow :orders, :destroy do |order|
        user.is_admin?
      end
      allow :orders, [:pay] do |order|
        order.may_pay? and order.owned_by?(user)
      end
      allow :orders, [:cancel] do |order|
        order.may_cancel? and order.owned_by?(user)
      end
      allow :orders, [:ship] do |order|
        order.may_ship? and user.is_quoter?
      end
      # accident_items
      allow [:accident_items, :public_liability_items, :product_liability_items, :employer_liability_items], [:show] do |item|
        item.owned_by? user
      end
      allow [:accident_items, :public_liability_items, :product_liability_items, :employer_liability_items], [:new, :edit, :create, :update, :destroy] do |item|
        user.is_customer?
      end
      allow [:accident_items, :public_liability_items, :product_liability_items, :employer_liability_items], [:add_to_cart] do |item|
        user.is_customer?
      end
      # line items
      allow :line_items, [:create] do
        user.is_customer?
      end
      allow :line_items, [:destroy] do |line_item|
        user.is_admin?
      end
      allow :line_items, [:commit] do |line_item|
        line_item.may_commit? and line_item.owned_by?(user)
      end
      allow :line_items, [:cancel] do |line_item|
        line_item.may_cancel? and line_item.owned_by?(user)
      end
      allow :line_items, [:verify] do |line_item|
        line_item.may_verify? and user.is_manager?
        true # TODO: remove this line
      end
      allow :line_items, [:quote] do |line_item|
        line_item.may_quote? and user.is_quoter?
        true # TODO: remove this line
      end
      allow :line_items, [:reject] do |line_item|
        line_item.committed? && user.is_manager? or
        line_item.verified? && user.is_quoter?
      end
      allow :line_items, [:pay] do |line_item|
        line_item.may_pay? and line_item.owned_by?(user)
      end
      allow :line_items, [:ship] do |line_item|
        line_item.may_ship? and user.is_quoter?
      end
      # as admin
      allow_all if user.is_admin?
    end
  end

  def allow?(controller, action, resource = nil)
    allowed = @allow_all || @allowed_actions[[controller.to_s, action.to_s]]
    allowed && (allowed == true || allowed.call(resource))
  # allowed && (allowed == true || resource && allowed.call(resource))
  end

  private

  def allow_all
    @allow_all = true
  end

  def allow(controllers, actions, &block)
    @allowed_actions ||= {}
    Array(controllers).each do |controller|
      Array(actions).each do |action|
        @allowed_actions[[controller.to_s, action.to_s]] = block || true
      end
    end
  end
end
