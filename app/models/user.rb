class User < ActiveRecord::Base
#acts_as_paranoid
#belongs_to :admin
validates :name, uniqueness: true,:presence => { :message => " cannot be blank" }
validates :password, length: { in: 6..20 }, confirmation: true, :presence => { :message => " cannot be blank" }
validates :password_confirmation,length: { in: 6..20 }, :presence => { :message => " cannot be blank" }
validates :role, :presence => true
validates :name, :password, :password_confirmation, presence: true
end

