require 'rails_helper'

RSpec.describe Room, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'false when number is empty' do
        #Arrange
        inn = Inn.new(name:'Pousadinha', company_name:'Pousadinha SN', cnpj:'123',
                           phone:'556618', email:'pousadinha@email.com')
        room = inn.rooms.build(number:'', description:'Ótimo quarto com uma cama de casal, tv, varanda com vista para a praia',
                        double_beds:1, single_beds:1, capacity:2, price:125.00,
                        bathrooms:1, kitchen:false)
        #Act
        result = room.valid?
        #Assert
        expect(result).to eq false
      end
      it 'false when description is empty' do
        #Arrange
        inn = Inn.new(name:'Pousadinha', company_name:'Pousadinha SN', cnpj:'123',
                           phone:'556618', email:'pousadinha@email.com')
        room = inn.rooms.build(number:'1', description:'',
                        double_beds:1, single_beds:1, capacity:2, price:125.00,
                        bathrooms:1, kitchen:false)
        #Act
        result = room.valid?
        #Assert
        expect(result).to eq false
      end
    end
  end
end
