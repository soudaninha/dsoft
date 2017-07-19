class CadEmail < ActiveRecord::Base

validates :email, uniqueness: true
validates :email, :senha_email, presence: true

end
