require 'permission'

class Role < ActiveRecord::Base

  include Permission

  validates :account_id, uniqueness: { scope: :division_id }
  validates :permission, inclusion: PERMISSIONS

  belongs_to :division
  belongs_to :account
end
