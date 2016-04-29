class InviteAccountService

  attr_accessor :organization

  def initialize(organization)
    @organization = organization
  end

  def execute(account_email, permission)
    account = Account.find_by(email: account_email)

    unless account
      AccountMailer.invite_organization(
        @organization.name, account_email
      ).deliver_now

      InvitationToken.create_new_token(@organization, account_email)
    else
      if organization.class == Division
        Role.create(
          division: @organization,
          account: account,
          permission: permission
        )
      else
        Delegate.create(
          group: @organization,
          account: account,
          permission: permission
        )
      end
    end
  end
end
