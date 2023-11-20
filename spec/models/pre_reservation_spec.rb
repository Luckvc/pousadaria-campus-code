require 'rails_helper'

RSpec.describe PreReservation, type: :model do
  describe 'confirmation' do
    it 'calculate total' do
      host = User.create!(name: 'Lucas', email:'test@email.com', password:'password', host: true)
      address = Address.create!(street: 'Rua das ruas', number:'12', neighborhood:'centro',
                                city:'São Paulo', state:'SP', cep:'15470-000')
      inn = host.create_inn!(name:'Pousadinha', company_name:'Pousadinha SN', cnpj:'123',
                            phone:'556618', email:'pousadinha@email.com', address:address)
      room = inn.rooms.create!(number:'101', description:'Ótimo quarto com uma cama de casal, tv,
                              varanda com vista para a praia', double_beds:1, single_beds:0, 
                              capacity:2, price:100.00, bathrooms:1, kitchen:false)
      pr = room.pre_reservations.create!(check_in_date: 2.days.from_now.to_date, 
                              check_out_date: 12.days.from_now.to_date, guests:1)

      expect(pr.total).to eq 1000.00
    end
  end
end
