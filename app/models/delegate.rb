require 'permission'

class Delegate < ActiveRecord::Base

  include Permission

  validates :account_id, uniqueness: { scope: :group_id }
  validates :permission, inclusion: PERMISSIONS

  belongs_to :group
  belongs_to :account
end
