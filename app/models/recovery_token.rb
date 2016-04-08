class RecoveryToken < ActiveRecord::Base
  belongs_to :account

  default_scope ->{ where(is_active: true) }

  def enable
    update(is_active: true)
  end

  def disable
    update(is_active: false)
  end

  private

  def self.generate_token
    SecureRandom.urlsafe_base64(50)
  end
end
