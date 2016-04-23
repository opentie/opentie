module Api::V1
  class DashboardsController < Api::V1::BaseController

    before_action :authenticate_account!

    def show
      divisions = current_account.divisions

      render_ok({ divisions: divisions })
    end
  end
end
