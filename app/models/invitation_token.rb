require 'token'

class InvitationToken < ActiveRecord::Base

  include Token

  belongs_to :organization, polymorphic: true

  def self.create_new_token(organization, email)
    where(organization: organization).where(email: email).each do |token|
      token.disable
    end

    token = new(organization: organization, email: email)
    token.save!
    token
  end
end
