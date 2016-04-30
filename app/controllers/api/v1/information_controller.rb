module Api::V1
  class InformationController < Api::V1::BaseController

    def show
      service_name = Rails.application.config.global_config.service_name
      organization_name = Rails.application.config.global_config.organization_name
      organization_mail = Rails.application.config.global_config.organization_mail
      organization_tel = Rails.application.config.global_config.organization_tel

      render_ok({
        service_name: service_name,
        organization_name: organization_name,
        organization_mail: organization_mail,
        organization_tel: organization_tel
      })
    end
  end
end
