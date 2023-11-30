require 'rails_helper'

RSpec.describe Room, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'false when number is empty' do
        #Arrange
        inn = Inn.new(name:'Pousadinha', company_name:'Pousadinha SN', cnpj:'123',
                           phone:'556618', email:'pousadinha@email.com')
        room = inn.rooms.build()
        #Act
        room.valid?
        #Assert
        expect(room.errors[:number]).to include 'não pode ficar em branco'
      end
      it 'false when description is empty' do
        #Arrange
        inn = Inn.new(name:'Pousadinha', company_name:'Pousadinha SN', cnpj:'123',
                           phone:'556618', email:'pousadinha@email.com')
        room = inn.rooms.build()
        #Act
        room.valid?
        #Assert
        expect(room.errors[:description]).to include 'não pode ficar em branco'
      end
      it 'false when capacity is empty' do
        #Arrange
        inn = Inn.new(name:'Pousadinha', company_name:'Pousadinha SN', cnpj:'123',
                           phone:'556618', email:'pousadinha@email.com')
        room = inn.rooms.build()
        #Act
        room.valid?
        #Assert
        expect(room.errors[:capacity]).to include 'não pode ficar em branco'
      end
      it 'false when price is empty' do
        #Arrange
        inn = Inn.new(name:'Pousadinha', company_name:'Pousadinha SN', cnpj:'123',
                           phone:'556618', email:'pousadinha@email.com')
        room = inn.rooms.build()
        #Act
        room.valid?
        #Assert
        expect(room.errors[:price]).to include 'não pode ficar em branco'
      end
    end
  end
end
