class Estado < ActiveRecord::Base
  has_many :cidades
  has_many :clients
  has_many :suppliers
  has_many :invoices

  belongs_to :capital, :class_name => 'Cidade'

  def estado_params
    params.require(:estado).permit(:nome, :sigla, :capital)
  end
end