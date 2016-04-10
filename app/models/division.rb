class Division < ActiveRecord::Base
  has_many :roles
  has_many :accounts, through: :roles
  has_many :invitation_tokens
end
