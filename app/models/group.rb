class Group < ActiveRecord::Base
  has_many :delegates
  has_many :accounts, through: :delegates
end
