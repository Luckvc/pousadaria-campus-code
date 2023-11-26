require 'rails_helper'

RSpec.describe Reservation, type: :model do
  describe '#valid?' do
    it 'must have a code' do
      host = User.create!(name: 'Lucas', email:'test@email.com', password:'password', host: true)
      address = Address.create!(street: 'Rua das ruas', number:'12', neighborhood:'Centro', 
                                city:'São Paulo', state:'SP', cep:'15470-000')
      inn = host.create_inn!(name:'Pousadinha', company_name:'Pousadinha SN', cnpj:'123', 
                             phone:'556618', email:'pousadinha@email.com', address:address)
      room = inn.rooms.create!(number:'101', description:'Ótimo quarto com uma cama de casal',
                        double_beds:1, single_beds:0, capacity:2, price:100.00, bathrooms:1,
                        kitchen:false)  
      customer = Customer.create!(name:'nome', cpf:'123', email:'email@email.com', password:'123123')
      reservation = customer.reservations.build(checkin_expected_date:10.days.from_now.to_date,
                                  checkout_expected_date:20.days.from_now.to_date, guests: 2, room:room)

      expect(reservation.valid?).to be true
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
      reservation = customer.reservations.build(checkin_expected_date:10.days.from_now.to_date,
                                  checkout_expected_date:20.days.from_now.to_date, guests: 2, room:room)

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
      reservation1 = customer.reservations.create!(checkin_expected_date:10.days.from_now.to_date,
                                  checkout_expected_date:20.days.from_now.to_date, guests: 2, room:room)
      reservation2 = customer.reservations.build(checkin_expected_date:25.days.from_now.to_date,
                                  checkout_expected_date:35.days.from_now.to_date, guests: 2, room:room)

      reservation2.save!

      expect(reservation2.code).not_to eq reservation1.code
    end
  end
end
