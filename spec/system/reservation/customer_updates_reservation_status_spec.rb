require 'rails_helper' 


describe 'Customer changes reservations status' do
  it 'to cancelled' do
    host = User.create!(name: 'João', email:'joao@email.com', password:'password', host: true)
    address = Address.create!(street: 'Rua das torres', number:'28', neighborhood:'centro',
                               city:'Campinas', state:'SP', cep:'15470-000')
    inn = host.create_inn!(name:'Safari', company_name:'Pousada Safari SN', cnpj:'456', phone:'223345',
                            email:'pousadona@email.com', address:address, pix:true)
    room = inn.rooms.create!(number:'Elefante', description:'Ótimo quarto com uma cama de casal', 
                      double_beds:1, single_beds:0, capacity:2, 
                      price:100.00, bathrooms:1, kitchen:false)
    customer = Customer.create!(name:'Roberto', cpf:'123', email:'roberto@email.com', password:'123456')
    res = room.reservations.create!(checkin_expected_date: 10.days.from_now, checkout_expected_date: 15.days.from_now,
                              guests:2, customer:customer)

    login_as(customer, scope: :customer)
    visit root_path
    click_on 'Minhas Reservas'
    click_on res.code
    click_on 'Cancelar Reserva'

    expect(page).to have_content "Reserva #{res.code}"
    expect(page).to have_content 'Pousada: Safari'
    expect(page).to have_content 'Quarto: Elefante'
    expect(page).to have_content 'Status da Reserva: Cancelada'
  end
  it 'to cancelled unsuccessfully with less than 7 days to check-in' do
    host = User.create!(name: 'João', email:'joao@email.com', password:'password', host: true)
    address = Address.create!(street: 'Rua das torres', number:'28', neighborhood:'centro',
                               city:'Campinas', state:'SP', cep:'15470-000')
    inn = host.create_inn!(name:'Safari', company_name:'Pousada Safari SN', cnpj:'456', phone:'223345',
                            email:'pousadona@email.com', address:address, pix:true)
    room = inn.rooms.create!(number:'Elefante', description:'Ótimo quarto com uma cama de casal', 
                      double_beds:1, single_beds:0, capacity:2, 
                      price:100.00, bathrooms:1, kitchen:false)
    customer = Customer.create!(name:'Roberto', cpf:'123', email:'roberto@email.com', password:'123456')
    res = room.reservations.create!(checkin_expected_date: 5.days.from_now, checkout_expected_date: 12.days.from_now,
                              guests:2, customer:customer)

    login_as(customer, scope: :customer)
    visit root_path
    click_on 'Minhas Reservas'
    click_on res.code
    click_on 'Cancelar Reserva'

    expect(page).to have_content "Reserva #{res.code}"
    expect(page).to have_content 'Pousada: Safari'
    expect(page).to have_content 'Quarto: Elefante'
    expect(page).to have_content 'Status da Reserva: Confirmada'
    expect(page).to have_content 'Reservas não podem ser canceladas com menos de 7 dias do check-in'
  end
end