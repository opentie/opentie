require 'token'

class InvitationToken < ActiveRecord::Base

  include Token

  belongs_to :division

  def self.create_new_token(division, email)
    where(division: division).where(email: email).each do |token|
      token.disable
    end

    token = new(division: division, email: email)
    token.save!
    token
  end
end
