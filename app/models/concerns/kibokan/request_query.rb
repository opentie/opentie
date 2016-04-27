module Kibokan
  module RequestQuery
    extend ActiveSupport::Concern

    def current_category
      raise Exception
    end

    module ClassMethods

      def current_namespace
        self.to_s.downcase.pluralize
      end

      # request for forms
      def get_forms(category, form_ids=nil)
        path = Form.request_path(current_namespace, category)

        form_bodies = nil
        if form_ids.nil?
          form_bodies = Kibokan::RequestAgent.new(path).get
        else
          form_bodies = Kibokan::RequestAgent.new(path).bulk({ ids: form_ids })
        end

        form_bodies.map do |form_param|
          Form.from_kibokan(form_param)
        end
      end

      def insert_form(category, params)
        path = Form.request_path(current_namespace, category)

        form_body = Kibokan::RequestAgent.new(path).post(params)
        Form.from_kibokan(form_body)
      end

      # new form
      def get_root_form(category)
        path = Entity.request_path(current_namespace, category)

        form_body = Kibokan::RequestAgent.new(path).new
        Form.from_kibokan(form_body)
      end

      # request for entities
      def get_entities(category, entity_ids=nil)
        path = Entity.request_path(current_namespace, category)

        entity_bodies = nil
        if entity_ids.nil?
          entity_bodies = Kibokan::RequestAgent.new(path).get
        else
          entity_bodies = Kibokan::RequestAgent.new(path).bulk({ ids: entity_ids })
        end

        entity_bodies.map do |entity_param|
          Entity.from_kibokan(entity_param)
        end
      end

      def insert_entity(category, params)
        path = Entity.request_path(current_namespace, category)

        entity_body = Kibokan::RequestAgent.new(path).post(params)
        Entity.from_kibokan(entity_body)
      end

      def search_entityn(category, query)
        path = Entity.request_path(current_namespace, category)

        entity_body = Kibokan::RequestAgent.new(path).search(query)
        Entity.from_kibokan(entity_body)
      end
    end

    def get_entity
      path = Entity.request_path(
        self.class.current_namespace,
        self.current_category
      )

      entity_body = Kibokan::RequestAgent.new(path).bulk({
        ids: [ self.kibokan_id ]
      }).first

      Entity.from_kibokan(entity_body)
    end

    def update_entity(params)
      path = Entity.request_path(
        self.class.current_namespace,
        current_category
      ) + "/#{self.kibokan_id}"

      entity_body = Kibokan::RequestAgent.new(path).put(params)
      Entity.from_kibokan(entity_body)
    end
  end
end
