require 'rails_helper'

RSpec.describe Reservation, type: :model do
  describe '#valid?' do
    context 'presence' do 
      it 'false when check_in_date is empty' do
        #Arrange
        host = User.create!(name: 'Lucas', email:'test@email.com', password:'password', host: true)
        address = Address.create!(street: 'Rua das ruas', number:'12', neighborhood:'centro',
                                  city:'São Paulo', state:'SP', cep:'15470-000')
        inn = host.create_inn!(name:'Pousadinha', company_name:'Pousadinha SN', cnpj:'123',
                              phone:'556618', email:'pousadinha@email.com', address:address)
        room = inn.rooms.create!(number:'101', description:'Ótimo quarto com uma cama de casal, tv,
                                varanda com vista para a praia', double_beds:1, single_beds:0, 
                                capacity:2, price:100.00, bathrooms:1, kitchen:false)
        pr = room.reservations.new()
        #Act
        pr.valid?
        #Assert
        expect(pr.errors[:check_in_date]).to include 'não pode ficar em branco'
      end
      it 'false when check_out_date is empty' do
        #Arrange
        host = User.create!(name: 'Lucas', email:'test@email.com', password:'password', host: true)
        address = Address.create!(street: 'Rua das ruas', number:'12', neighborhood:'centro',
                                  city:'São Paulo', state:'SP', cep:'15470-000')
        inn = host.create_inn!(name:'Pousadinha', company_name:'Pousadinha SN', cnpj:'123',
                              phone:'556618', email:'pousadinha@email.com', address:address)
        room = inn.rooms.create!(number:'101', description:'Ótimo quarto com uma cama de casal, tv,
                                varanda com vista para a praia', double_beds:1, single_beds:0, 
                                capacity:2, price:100.00, bathrooms:1, kitchen:false)
        pr = room.reservations.new()
        #Act
        pr.valid?
        #Assert
        expect(pr.errors[:check_out_date]).to include 'não pode ficar em branco'
      end
      it 'false when guests is empty' do
        #Arrange
        host = User.create!(name: 'Lucas', email:'test@email.com', password:'password', host: true)
        address = Address.create!(street: 'Rua das ruas', number:'12', neighborhood:'centro',
                                  city:'São Paulo', state:'SP', cep:'15470-000')
        inn = host.create_inn!(name:'Pousadinha', company_name:'Pousadinha SN', cnpj:'123',
                              phone:'556618', email:'pousadinha@email.com', address:address)
        room = inn.rooms.create!(number:'101', description:'Ótimo quarto com uma cama de casal, tv,
                                varanda com vista para a praia', double_beds:1, single_beds:0, 
                                capacity:2, price:100.00, bathrooms:1, kitchen:false)
        pr = room.reservations.new()
        #Act
        pr.valid?
        #Assert
        expect(pr.errors[:guests]).to include 'não pode ficar em branco'
      end
    end
  end
  describe 'Creates a random code' do
    it 'on reservation creation' do
      host = User.create!(name: 'Lucas', email:'test@email.com', password:'password', host: true)
      address = Address.create!(street: 'Rua das ruas', number:'12', neighborhood:'Centro', 
                                city:'São Paulo', state:'SP', cep:'15470-000')
      inn = host.create_inn!(name:'Pousadinha', company_name:'Pousadinha SN', cnpj:'123', 
                            phone:'556618', email:'pousadinha@email.com', address:address)
      room = inn.rooms.create!(number:'101', description:'Ótimo quarto com uma cama de casal',
                        double_beds:1, single_beds:0, capacity:2, price:100.00, bathrooms:1,
                        kitchen:false)  
      customer = Customer.create!(name:'nome', cpf:'123', email:'email@email.com', password:'123123')
      reservation = customer.reservations.build(check_in_date:10.days.from_now,
                                  check_out_date:20.days.from_now, guests: 2, room:room)

      reservation.save!

      expect(reservation.code).not_to be_empty
      expect(reservation.code.length).to eq 8
    end
    it 'and code is unique' do
      host = User.create!(name: 'Lucas', email:'test@email.com', password:'password', host: true)
      address = Address.create!(street: 'Rua das ruas', number:'12', neighborhood:'Centro', 
                                city:'São Paulo', state:'SP', cep:'15470-000')
      inn = host.create_inn!(name:'Pousadinha', company_name:'Pousadinha SN', cnpj:'123', 
                            phone:'556618', email:'pousadinha@email.com', address:address)
      room = inn.rooms.create!(number:'101', description:'Ótimo quarto com uma cama de casal',
                        double_beds:1, single_beds:0, capacity:2, price:100.00, bathrooms:1,
                        kitchen:false)  
      customer = Customer.create!(name:'nome', cpf:'123', email:'email@email.com', password:'123123')
      reservation1 = customer.reservations.create!(check_in_date:10.days.from_now,
                                  check_out_date:20.days.from_now, guests: 2, room:room)
      reservation2 = customer.reservations.build(check_in_date:25.days.from_now,
                                  check_out_date:35.days.from_now, guests: 2, room:room)

      reservation2.save!

      expect(reservation2.code).not_to eq reservation1.code
    end
  end
end
