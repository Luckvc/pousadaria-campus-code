require 'rails_helper'

describe 'Customer views his reservations' do
  it 'from home page' do
    host = User.create!(name: 'João', email:'joao@email.com', password:'password', host: true)
    address = Address.create!(street: 'Rua das torres', number:'28', neighborhood:'centro',
                               city:'Campinas', state:'SP', cep:'15470-000')
    inn = host.create_inn!(name:'Pousadona', company_name:'Pousadona SN', cnpj:'456', phone:'223345',
                            email:'pousadona@email.com', address:address2)
    room1 = inn.rooms.create!(number:'Elefante', description:'Ótimo quarto com uma cama de casal', 
                      double_beds:1, single_beds:0, capacity:2, 
                      price_cents:100_00, bathrooms:1, kitchen:false)
    room2 =inn.rooms.create!(number:'Leão', description:'Ótimo quarto com cozinha, uma cama de casal',
                      double_beds:1, single_beds:2, capacity:3, price_cents:150_00, bathrooms:0, kitchen:true)
    customer = Customer.create!(name:'Roberto', cpf:'123', email:'roberto@email.com', password:'123456')
    room1.reservations.create!(check_in_date: Date.tomorrow, check_out_date: 5.days.from_now.to_date,
                              guests:2, customer:customer)
    room2.reservations.create!(check_in_date: 5.months.from_now.to_date, check_out_date: 6.months.from_now.to_date,
                              guests:2, customer:customer)
    
    visit root_path
    click_on 'Minhas Reservas'

    expect(page).to have_content 'Minhas Reservas'


  end
end