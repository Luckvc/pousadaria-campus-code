require 'rails_helper'

describe 'Customer reservations' do
  it 'viewed from home page' do
    host = User.create!(name: 'João', email:'joao@email.com', password:'password', host: true)
    address = Address.create!(street: 'Rua das torres', number:'28', neighborhood:'centro',
                               city:'Campinas', state:'SP', cep:'15470-000')
    inn = host.create_inn!(name:'Pousadona', company_name:'Pousadona SN', cnpj:'456', phone:'223345',
                            email:'pousadona@email.com', address:address)
    room1 = inn.rooms.create!(number:'Elefante', description:'Ótimo quarto com uma cama de casal', 
                      double_beds:1, single_beds:0, capacity:2, 
                      price:100.00, bathrooms:1, kitchen:false)
    room2 =inn.rooms.create!(number:'Leão', description:'Ótimo quarto com cozinha, uma cama de casal',
                      double_beds:1, single_beds:2, capacity:3, price:150.00, bathrooms:0, kitchen:true)
    customer = Customer.create!(name:'Roberto', cpf:'123', email:'roberto@email.com', password:'123456')
    room1.reservations.create!(check_in_date: Date.tomorrow, check_out_date: 5.days.from_now,
                              guests:2, customer:customer)
    room2.reservations.create!(check_in_date: 5.months.from_now, check_out_date: 6.months.from_now,
                              guests:2, customer:customer)
    
    login_as(customer, scope: :customer)
    visit root_path
    click_on 'Minhas Reservas'

    expect(page).to have_content 'Minhas Reservas'
  end
  it 'page with no reservation' do
    customer = Customer.create!(name:'Roberto', cpf:'123', email:'roberto@email.com', password:'123456')

    login_as(customer, scope: :customer)
    visit root_path
    click_on 'Minhas Reservas'

    expect(page).to have_content 'Sem reservas registradas'
  end
  it 'details' do
    host = User.create!(name: 'João', email:'joao@email.com', password:'password', host: true)
    address = Address.create!(street: 'Rua das torres', number:'28', neighborhood:'centro',
                               city:'Campinas', state:'SP', cep:'15470-000')
    inn = host.create_inn!(name:'Safari', company_name:'Pousada Safari SN', cnpj:'456', phone:'223345',
                            email:'pousadona@email.com', address:address, pix:true)
    room = inn.rooms.create!(number:'Elefante', description:'Ótimo quarto com uma cama de casal', 
                      double_beds:1, single_beds:0, capacity:2, 
                      price:100.00, bathrooms:1, kitchen:false)
    customer = Customer.create!(name:'Roberto', cpf:'123', email:'roberto@email.com', password:'123456')
    allow(SecureRandom).to receive(:alphanumeric).and_return('ABC12345')
    res = room.reservations.create!(check_in_date: Date.tomorrow, check_out_date: 5.days.from_now,
                              guests:2, customer:customer)

    login_as(customer, scope: :customer)
    visit reservations_path
    click_on 'ABC12345'

    expect(page).to have_content 'Reserva ABC12345'
    expect(page).to have_content 'Pousada: Safari'
    expect(page).to have_content 'Quarto: Elefante'
    expect(page).to have_content 'Status da Reserva: Confirmada'
  end
  it 'can be cancelled' do
    host = User.create!(name: 'João', email:'joao@email.com', password:'password', host: true)
    address = Address.create!(street: 'Rua das torres', number:'28', neighborhood:'centro',
                               city:'Campinas', state:'SP', cep:'15470-000')
    inn = host.create_inn!(name:'Pousadona', company_name:'Pousadona SN', cnpj:'456', phone:'223345',
                            email:'pousadona@email.com', address:address)
    room = inn.rooms.create!(number:'Elefante', description:'Ótimo quarto com uma cama de casal', 
                      double_beds:1, single_beds:0, capacity:2, 
                      price:100.00, bathrooms:1, kitchen:false)
    customer = Customer.create!(name:'Roberto', cpf:'123', email:'roberto@email.com', password:'123456')
    res = room.reservations.create!(check_in_date: Date.tomorrow, check_out_date: 5.days.from_now,
                              guests:2, customer:customer)

    visit reservation_path(res)
  end
  it 'have a 8 digit unique code' do
    #TODO
  end
end