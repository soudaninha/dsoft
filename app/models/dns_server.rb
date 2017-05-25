class DnsServer < ActiveRecord::Base
  belongs_to :client
  
  validates :email, :password, :dns, :client_id,
  presence: true
end
