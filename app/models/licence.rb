class Licence < ActiveRecord::Base
  belongs_to :client
  
  validates :client_id, uniqueness: true
  validates :client_id, :serial_bios, :type_licence, :price,
  presence: true
  
end
