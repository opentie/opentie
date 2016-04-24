class InviteDivisionAccountService

  attr_accessor :division

  def initialize(division)
    @division = division
  end

  def execute(account_email, permission)
    account = Account.find_by(email: account_email)

    unless account
      AccountMailer.invite_division(@division, account_email).deliver_now
      InvitationToken.create_new_token(@division, account_email)
    else
      Role.create(division: @division, account: account, permission: permission)
    end
  end
end
