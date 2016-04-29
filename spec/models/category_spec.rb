require 'rails_helper'

RSpec.describe Category, type: :models do

  describe 'initializer' do
    context 'valid params' do
      it 'valid' do
        category = Category.new(namespace: 'namespace', name: 'name')
        expect(category.valid?).to eq(true)
      end
    end

    context 'invalid params' do
      it 'be invalid' do
        category = Category.new(name: 'name')
        expect(category.valid?).to eq(false)

        category = Category.new(namespace: 'namespace')
        expect(category.valid?).to eq(false)
      end
    end

    it 'has payload' do
      category = Category.new(namespace: 'namespace', name: 'name')
      expect(category.payload).not_to eq(nil)
    end
  end

  describe 'instance methods' do
    before do
      @category = Category.new(namespace: 'namespace', name: 'name')
    end

    describe '#update' do
      it 'return sample form' do
        category = @category.update({})
        expect(category.class).to eq(Category)
      end
    end

    describe '#create_form' do
      it 'return sample form' do
        form = @category.create_form({})
        expect(form.class).to eq(Form)
      end
    end

    describe '#get_form' do
      it 'return sample form' do
        form = @category.get_form('id')
        expect(form.class).to eq(Form)
      end
    end

    describe '#get_forms' do
      context 'with blank form_ids' do
        it 'return sample forms' do
          forms = @category.get_forms
          expect(forms.class).to eq(Array)
          expect(forms.first.class).to eq(Form)
        end
      end
      context 'with blank form_ids' do
        it 'return sample forms' do
          forms = @category.get_forms(['id'])
          expect(forms.class).to eq(Array)
          expect(forms.first.class).to eq(Form)
        end
      end
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

    it 'create' do
      category = Category.create('namespace', {})
      expect(category.class).to eq(Category)
    end
  end
end
