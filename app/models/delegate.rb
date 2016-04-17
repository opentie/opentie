class Delegate < ActiveRecord::Base

  validates :account_id, uniqueness: { scope: :group_id }

  belongs_to :group
  belongs_to :account
end
