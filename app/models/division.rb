class Division < ActiveRecord::Base
  has_many :roles
  has_many :accounts, through: :roles
end
