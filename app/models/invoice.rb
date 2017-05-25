class Invoice < ActiveRecord::Base
  belongs_to :client
  belongs_to :cidade
  belongs_to :estado
      
  
  # para poder permitir a exclusão da invoice mesmo tendo itens ou não
  has_many :items, dependent: :destroy
  
  #validações
  #validates :type_invoice, :client_id, :form_receipt, :installments, presence: true
                
end
