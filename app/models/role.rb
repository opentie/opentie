class Role < ActiveRecord::Base
  belongs_to :division
  belongs_to :account
end
