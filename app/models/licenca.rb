class Licenca < ActiveRecord::Base
  belongs_to :patrimonio
  
  validates :produto, :serial, :patrimonio_id, :descricao,
  presence: true
end
