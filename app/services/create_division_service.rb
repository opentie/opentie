class CreateDivisionService

  attr_accessor :proposer

  def initialize(account_email)
    @account = Account.find_by(email: account_email)
  end

  def execute(params)
    division = @account.divisions.create(params)

    role = @account.roles.find_by(division: division)
    role.set_permission(:super)
    role.save

    division
  end
end
