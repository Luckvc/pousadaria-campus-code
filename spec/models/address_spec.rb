require 'rails_helper'

RSpec.describe Address, type: :model do
  describe '#full_address' do
    it 'shows full address' do
      address = Address.create!(street: 'Rua das ruas', number:'12', neighborhood:'Centro', city:'São Paulo', 
      state:'SP', cep:'15470-000')

      result = address.full_address()

      expect(result).to eq('Rua das ruas, 12 - Centro, São Paulo - SP')
    end
  end
  describe '#valid?' do
    context 'presence' do
      it 'false when street is empty' do
        #Arrange
        address = Address.new(street: '', number:'12', neighborhood:'centro',
                              city:'São Paulo', state:'SP', cep:'15470-000')
        #Act
        result = address.valid?
        #Assert
        expect(result).to eq false
      end
      it 'false when number is empty' do
        #Arrange
        address = Address.new(street: 'Rua das ruas', number:'', neighborhood:'centro',
                              city:'São Paulo', state:'SP', cep:'15470-000')
        #Act
        result = address.valid?
        #Assert
        expect(result).to eq false
      end
      it 'false when neighborhood is empty' do
        #Arrange
        address = Address.new(street: 'Rua das ruas', number:'12', neighborhood:'',
                              city:'São Paulo', state:'SP', cep:'15470-000')
        #Act
        result = address.valid?
        #Assert
        expect(result).to eq false
      end
      it 'false when city is empty' do
        #Arrange
        address = Address.new(street: 'Rua das ruas', number:'12', neighborhood:'centro',
                              city:'', state:'SP', cep:'15470-000')
        #Act
        result = address.valid?
        #Assert
        expect(result).to eq false
      end
      it 'false when state is empty' do
        #Arrange
        address = Address.new(street: 'Rua das ruas', number:'12', neighborhood:'centro',
                              city:'São Paulo', state:'', cep:'15470-000')
        #Act
        result = address.valid?
        #Assert
        expect(result).to eq false
      end
      it 'false when cep is empty' do
        #Arrange
        address = Address.new(street: 'Rua das ruas', number:'12', neighborhood:'centro',
                              city:'São Paulo', state:'SP', cep:'')
        #Act
        result = address.valid?
        #Assert
        expect(result).to eq false
      end
    end
  end
end
