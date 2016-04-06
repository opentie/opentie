class RecoveryToken < ActiveRecord::Base
  belongs_to :account

  default_scope ->{ where(is_active: true).where(created_at: 1.hour.ago...Time.now) }

  private

  def self.generate_token
    SecureRandom.urlsafe_base64(50)
  end
end
