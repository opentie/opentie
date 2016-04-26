module Kibokan
  module Query
    extend ActiveSupport::Concern

    def current_category
      raise Exception
    end

    module ClassMethods

      def current_namespace
        self.downcase.pluralize
      end

      # request for forms
      def get_forms(category, form_ids=[])
        path = Kibokan::Agent.
          generate_request_path(current_namespace, category) + '/forms'

        if form_ids.empty?
          body = Kibokan::Agent.new(path).bulk({ ids: form_ids })
          body[:forms].map do |form_param|
            Form.from_kibokan(form_param)
          end
        else
          body = Kibokan::Agent.new(path).get
        end

        Form.from_kibokan(body)
      end

      def insert_form(params)
        path = Kibokan::Agent.
          generate_request_path(current_namespace, category) + '/forms'

        body = Kibokan::Agent.new(path).post(params)
        Form.from_kibokan(body)
      end

      # request for entities
      def get_entities(category, entity_ids=[])
        path = Kibokan::Agent.
          generate_request_path(current_namespace, category) + '/entities'

        if form_ids.empty?
          body = Kibokan::Agent.new(path).bulk({ ids: entity_ids })
          body[:entities].map do |entity_param|
            ENtity.from_kibokan(entity_param)
          end
        else
          body = Kibokan::Agent.new(path).get
          Entity.from_kibokan(body)
        end
      end

      def insert_entity(params)
        path = Kibokan::Agent.
          generate_request_path(current_namespace, category) + '/entities'

        body = Kibokan::Agent.new(path).post(params)
        Entity.from_kibokan(body)
      end

      def update_entity(form_id, params)
        path = Kibokan::Agent.
          generate_request_path(current_namespace, category) +
          "/entities/#{form_id}"

        body = Kibokan::Agent.new(path).put(params)
        Entity.from_kibokan(body)
      end

      def search_entityn(query)
        path = Kibokan::Agent.
          generate_request_path(current_namespace, category) + '/entities'

        body = Kibokan::Agent.new(path).search(query)
        Entity.from_kibokan(body)
      end
    end
  end
end
