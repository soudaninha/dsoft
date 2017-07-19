class AdUser < ActiveRecord::Base
  
  has_many :patrimonios
  
  validates :colaborador, uniqueness: true
  validates :colaborador, presence: true
end
