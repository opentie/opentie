require 'rails_helper'

RSpec.describe Entity, type: :models do

  describe 'initialize' do
    it 'success' do
      entity = Entity.new(name: 'name', id: 'string', payload: {})
      expect(entity.class).to eq(Entity)
    end
  end

  describe 'class methods' do
    it 'from_kibokan' do
      params = {
        _name: 'name',
        _id: 'id'
      }

      entity = Entity.from_kibokan(params)
      expect(entity.name).not_to eq(nil)
      expect(entity.id).not_to eq(nil)
      expect(entity.payload).not_to eq(nil)
    end

    it 'request_path' do
      path = Entity.request_path('namespace', 'category')
      expect(path).to eq('namespaces/namespace/categories/category/entities')
    end
  end
end
