require 'rails_helper'

RSpec.describe Category, type: :models do

  describe 'initialize' do
    it 'success' do
      category = Category.new(namespace: 'namespace', name: 'name')
      expect(category.class).to eq(Category)
    end

    it 'failure' do
      category = Category.new(name: 'name')
      expect(category.valid?).to eq(false)

      category = Category.new(namespace: 'namespace')
      expect(category.valid?).to eq(false)
    end
  end

  describe 'instance methods' do
    it 'good payload' do
      category = Category.new(name: 'name', namespace: 'namespace')

      payload = category.payload
      expect(payload.include?(:_id)).to eq(true)
      expect(payload.include?(:_name)).to eq(true)
    end
  end

  describe 'class methods' do
    it 'all' do
      categories = Category.all('namespace')
      expect(categories.class).to eq(Array)

      category = categories.first
      expect(category.name).not_to eq(nil)
      expect(category.namespace).not_to eq(nil)
      expect(category.payload).not_to eq(nil)
    end

    it 'request_path' do
      path = Category.request_path('namespace')
      expect(path).to eq('namespaces/namespace/categories')
    end
  end
end
