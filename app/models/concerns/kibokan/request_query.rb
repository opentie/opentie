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

      # request for entities
      def get_init_entity_body(category)
        path = Entity.request_path(current_namespace, category)
        Kibokan::RequestAgent.new(path).new
      end

      def get_entities(category, entity_ids=nil)
        path = Entity.request_path(current_namespace, category)

        entity_bodies = nil
        if entity_ids.nil?
          entity_bodies = Kibokan::RequestAgent.new(path).index
        else
          entity_bodies =
            Kibokan::RequestAgent.new(path).bulk({ ids: entity_ids })
        end

        entity_bodies.map do |entity_body|
          Entity.from_kibokan(entity_body)
        end
      end

      def insert_entity(category, params)
        path = Entity.request_path(current_namespace, category)

        entity_body = Kibokan::RequestAgent.new(path).create(params)
        Entity.from_kibokan(entity_body)
      end

      def search_entity(category, query)
        path = Entity.request_path(current_namespace, category)

        entity_bodies = Kibokan::RequestAgent.new(path).where(query)
        entity_bodies.map do |entity_body|
          Entity.from_kibokan(entity_body)
        end
      end
    end

    def get_entity
      path = Entity.request_path(
        self.class.current_namespace, current_category
      ) + "/#{self.kibokan_id}"

      entity_body = Kibokan::RequestAgent.new(path).show
      Entity.from_kibokan(entity_body)
    end

    def update_entity(params)
      path = Entity.request_path(
        self.class.current_namespace, current_category
      ) + "/#{self.kibokan_id}"

      entity_body = Kibokan::RequestAgent.new(path).update(params)
      Entity.from_kibokan(entity_body)
    end
  end
end
