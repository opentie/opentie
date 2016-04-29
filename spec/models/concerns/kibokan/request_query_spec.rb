require 'rails_helper'

shared_examples_for 'request_query' do
  let(:model) { described_class }

  describe 'class methods' do
    describe '#current_namespace' do
      it 'return downcase and pluralize class name' do
        expect(model.current_namespace).to eq(model.to_s.downcase.pluralize)
      end
    end

    describe '#get_entities' do
      context 'blank entity_ids' do
        it 'return sample entities with blank entity_ids' do
          entities = model.get_entities('category')
          expect(entities.class).to eq(Array)
          expect(entities.first.class).to eq(Entity)
        end
      end

      context 'present entity_ids' do
        it 'return sample entities with blank entity_ids' do
          entities = model.get_entities('category', ['id'])
          expect(entities.class).to eq(Array)
          expect(entities.first.class).to eq(Entity)
        end
      end
    end

    describe '#insert_entity' do
      it 'return sample entity' do
        entity = model.insert_entity('category', {})
        expect(entity.class).to eq(Entity)
      end
    end

    describe '#search_entity' do
      it 'return sample entities' do
        entities = model.search_entity('category', 'query')
        expect(entities.class).to eq(Array)
        expect(entities.first.class).to eq(Entity)
      end
    end
  end

  describe 'instance methods' do
    describe '#current_category' do
      it 'return same string' do
        instance = model.first
        expect(instance.current_category.class).to eq(String)
      end
    end

    describe '#get_entity' do
      it 'return sample entity' do
        entity = model.first.get_entity
        expect(entity.class).to eq(Entity)
      end
    end

    describe '#update_entity' do
      it 'return sample entity' do
        entity = model.first.update_entity({})
        expect(entity.class).to eq(Entity)
      end
    end
  end
end

RSpec.describe Group, type: :model do
  it_behaves_like "request_query"
end

RSpec.describe Account, type: :model do
  it_behaves_like "request_query"
end
