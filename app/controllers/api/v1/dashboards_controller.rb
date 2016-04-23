module Api::V1
  class AccountsController < Api::V1::BaseController

    before_action :authenticate_account!

    def show
      render_ok
    end
  end
end
