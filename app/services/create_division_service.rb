class CreateDivisionService

  attr_accessor :proposer

  def initialize(default_account_id)
    @account = Account.find(default_account_id)
  end

  def execute(params)
    division = @account.divisions.create(params)

    role = @account.roles.find_by(division: division)
    role.set_permission(:super)
    role.save

    division
  end
end
