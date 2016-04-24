module Api
  class V1::BaseController < Api::BaseController

    include AuthLogic

    def account_signed_in?
      !current_account.nil? && current_account.confirmed_email_first_time?
    end

    def account_signed_in_with_not_included_confirm?
      !current_account.nil?
    end

    def authenticate_account!
      render_unauthorized unless account_signed_in?
    end

    def authenticate_admin!
      render_unauthorized unless account_signed_in?
      render_unauthorized unless account.admin?
    end
  end
end
