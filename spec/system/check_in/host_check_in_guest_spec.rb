require 'rails_helper'

describe 'Host checks-in guests' do
  it 'and sees check-in page' do
    host = User.create!(name: 'João', email:'joao@email.com', password:'password', host: true)
    address = Address.create!(street: 'Rua das torres', number:'28', neighborhood:'centro',
      city:'Campinas', state:'SP', cep:'15470-000')
    inn = host.create_inn!(name:'Safari', company_name:'Pousada Safari SN', cnpj:'456', phone:'223345',
      email:'pousadona@email.com', address:address, pix:true)
    room = inn.rooms.create!(number:'Elefante', description:'Ótimo quarto com uma cama de casal', 
      double_beds:1, single_beds:0, capacity:2, price:100.00, bathrooms:1)
    customer = Customer.create!(name:'Roberto', cpf:'123', email:'roberto@email.com', password:'123456')
    res = room.reservations.create!(checkin_expected_date: 2.days.from_now, checkout_expected_date: 12.days.from_now,
      guests:2, customer:customer)
    
    login_as(host, scope: :user)
    click_on 'Reservas'
    click_on "#{res.code}"
    click_on 'Check-in'

  end
end
