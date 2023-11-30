require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe '#valid?' do
  context 'presence' do
    it 'false when name is empty' do
      #Arrange
      cutomer = Customer.new()
      #Act
      cutomer.valid?
      #Assert
      expect(cutomer.errors[:name]).to include 'não pode ficar em branco'
    end
    it 'false when cpf is empty' do
      #Arrange
      cutomer = Customer.new()
      #Act
      cutomer.valid?
      #Assert
      expect(cutomer.errors[:cpf]).to include 'não pode ficar em branco'
    end
  end
end
end
