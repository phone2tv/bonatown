class Cart < ActiveRecord::Base
  # association macros
  has_many :line_items, dependent: :destroy
  belongs_to :user

  def add_insurance(line_item_params)
    line_items.build(line_item_params)
  end

# def add_insurance(line_item_params)
#   insurance_id = line_item_params[:insurance_id]
#   current_item = line_items.find_by_insurance_id(insurance_id)
#   if current_item
#     current_item.quantity += 1
#   else
#     current_item = line_items.build(line_item_params)
#   end
#   current_item
# end
end
