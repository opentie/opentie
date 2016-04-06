class RecoveryToken < ActiveRecord::Base
  belongs_to :account

  def is_valid?
    # token is valid for 1 hour and one time
    (created_at > 1.hour.ago) && (! resetted_password)
  end

  private

  def self.generate_token
    SecureRandom.urlsafe_base64(50)
  end
end
