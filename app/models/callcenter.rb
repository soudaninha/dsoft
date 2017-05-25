class Callcenter < ActiveRecord::Base
  belongs_to :client
  
  validates :client_id, :employee, :problem, :solution, :department, :status, presence: true
end
