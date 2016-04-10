class InvitationToken < ActiveRecord::Base
  require 'token'
  include Token

  belongs_to :division

  default_scope ->{ where(created_at: 1.hour.ago...Time.now) }

  def self.create_new_token(division, email)
    where(division: division).where(email: email).each do |token|
      token.disable
    end

    token = new(division: division, email: email)
    token.save!
    token
  end
end
