class Supplier < ActiveRecord::Base
  belongs_to :cidade
  belongs_to :estado
  belongs_to :product
  belongs_to :payment
  
  validates :name, :address, :neighborhood, :zipcode, :phone, :cpf_cnpj, :email, :cidade_id, :estado_id,
  presence: true
end
