class Patrimonio < ActiveRecord::Base
  belongs_to :ad_user
  has_many :licencas
  
  validates :numero_patrimonio, uniqueness: true
  validates :numero_patrimonio, :descricao, :ad_user_id,
  presence: true
  
end
