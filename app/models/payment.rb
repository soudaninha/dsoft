class Payment < ActiveRecord::Base
  belongs_to :supplier
  
  #validates :doc_number, uniqueness: true
  
  validates :description, :due_date, :installments, :value_doc, :supplier_id, :status,
  presence: true
    
end
