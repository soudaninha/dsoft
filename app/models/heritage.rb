class Heritage < ActiveRecord::Base
  belongs_to :client

  validates :description, :type_contract, :client_id,
  presence: true
end
