module Token
  extend ActiveSupport::Concern

  included do
    before_validation :generate_token
    default_scope ->{ where(is_active: true) }
  end

  def enable
    update(is_active: true)
  end

  def disable
    update(is_active: false)
  end

  private

  def generate_token
    self.token = SecureRandom.urlsafe_base64(50)
  end
end
