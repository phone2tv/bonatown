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

  def get_order_sn
  # 订单统一前缀+订单业务信息（产品代码，客户代码等）+日期+流水号

    # 选择一个随机的方案
  # mt_srand((double) microtime() * 1000000);
  # return date('Ymd') . str_pad(mt_rand(1, 99999), 5, '0', STR_PAD_LEFT);

    # 选择一个随机的方案
  # mt_srand((double) microtime() * 1000000);
    # PHPALLY + 年月日 + 6位随机数
  # return 'PHPALLY' . date('Ymd') . str_pad(mt_rand(1, 999999), 6, '0', STR_PAD_LEFT);

  # 前几天做手机银联pos支付，在服务器端要对订单进行签名base64(rsa(md5(订单)))；base64跟md5在php中都有现成的函数
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
