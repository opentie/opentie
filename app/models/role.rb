class Role < ActiveRecord::Base

  validates :account_id, uniqueness: { scope: [:division_id] }

  belongs_to :division
  belongs_to :account
end
