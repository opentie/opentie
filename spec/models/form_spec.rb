require 'rails_helper'

RSpec.describe Form, type: :models do

  describe 'initialize' do
    it 'success' do
      form = Form.new(payload: {})
      expect(form.class).to eq(Form)
    end
  end

  describe 'class methods' do
    it 'from_kibokan' do
      params = { foo: 'bar'}
      form = Form.from_kibokan(params)
      expect(form.payload).not_to eq(nil)
    end

    it 'request_path' do
      path = Form.request_path('namespace', 'category')
      expect(path).to eq('namespaces/namespace/categories/category/forms')
    end
  end
end
