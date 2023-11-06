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
end
