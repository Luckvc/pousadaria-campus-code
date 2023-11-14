require 'rails_helper'

RSpec.describe Inn, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'false when name is empty' do
        #Arrange
        inn = Inn.new(name:'', company_name:'', cnpj:'', phone:'', email:'')
        #Act
        inn.valid?
        #Assert
        expect(inn.errors[:name]).to include 'não pode ficar em branco'
      end
      it 'false when company name is empty' do
        #Arrange
        inn = Inn.new(name:'', company_name:'', cnpj:'', phone:'', email:'')
        #Act
        inn.valid?
        #Assert
        expect(inn.errors[:company_name]).to include 'não pode ficar em branco'
      end
      it 'false when cnpj is empty' do
        #Arrange
        inn = Inn.new(name:'', company_name:'', cnpj:'', phone:'', email:'')
        #Act
        inn.valid?
        #Assert
        expect(inn.errors[:cnpj]).to include 'não pode ficar em branco'
      end
      it 'false when phone is empty' do
        #Arrange
        inn = Inn.new(name:'', company_name:'', cnpj:'', phone:'', email:'')
        #Act
        inn.valid?
        #Assert
        expect(inn.errors[:phone]).to include 'não pode ficar em branco'
      end
      it 'false when email is empty' do
        #Arrange
        inn = Inn.new(name:'', company_name:'', cnpj:'', phone:'', email:'')
        #Act
        inn.valid?
        #Assert
        expect(inn.errors[:email]).to include 'não pode ficar em branco'
      end
    end
  end
end
