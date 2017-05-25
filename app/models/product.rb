class Product < ActiveRecord::Base
  belongs_to :supplier
  has_many :items
    
  validates :name, :qnt, :cost_value, :cost_sale, :supplier_id,
  presence: true
  
 
end
