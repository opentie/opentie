module Permission
  extend ActiveSupport::Concern

  PERMISSIONS = ['super', 'normal', 'observer']

  def super?
    self.permission == 'super'
  end

  def normal?
    self.permission == 'normal'
  end

  def observer?
    self.permission == 'observer'
  end

  def set_permission(to)
    false if super?
    self.update(permission: to.to_s)
  end

  def can_invite?
    super?
  end

  def can_read_personal_info?
    super? || normal?
  end
end
