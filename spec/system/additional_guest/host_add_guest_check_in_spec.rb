require 'rails_helper'

describe 'Host adds guests to check-in' do
  it 'and sees add guest form' do
    host = User.create!(name: 'João', email:'joao@email.com', password:'password', host: true)
    address = Address.create!(street: 'Rua das torres', number:'28', neighborhood:'centro',
      city:'Campinas', state:'SP', cep:'15470-000')
    inn = host.create_inn!(name:'Safari', company_name:'Pousada Safari SN', cnpj:'456', phone:'223345',
      email:'pousadona@email.com', address:address, pix:true)
    room = inn.rooms.create!(number:'Elefante', description:'Ótimo quarto com uma cama de casal', 
      double_beds:1, single_beds:0, capacity:2, price:100.00, bathrooms:1)
    customer = Customer.create!(name:'Roberto', cpf:'123', email:'roberto@email.com', password:'123456')
    res = room.reservations.create!(check_in_date: Time.zone.now, check_out_date: 12.days.from_now,
      guests:2, customer:customer)
    
    login_as(host, scope: :user)
    visit root_path
    click_on 'Reservas'
    click_on "#{res.code}"
    click_on 'Check-in'

    expect(page).to have_content "Check-in reserva #{res.code}"
    expect(page).to have_link "Quarto: #{res.room.number}"
    expect(page).to have_content "Check-in: #{I18n.l(res.check_in_date)}"
    expect(page).to have_content "Check-out: #{I18n.l(res.check_out_date)}"
    expect(page).to have_content "Hóspedes:"
    expect(page).to have_field "Nome"
    expect(page).to have_field "Documento"
    expect(page).to have_button "Cadastrar Hóspede"
  end
  it 'and adds a guest' do
    host = User.create!(name: 'João', email:'joao@email.com', password:'password', host: true)
    address = Address.create!(street: 'Rua das torres', number:'28', neighborhood:'centro',
      city:'Campinas', state:'SP', cep:'15470-000')
    inn = host.create_inn!(name:'Safari', company_name:'Pousada Safari SN', cnpj:'456', phone:'223345',
      email:'pousadona@email.com', address:address, pix:true)
    room = inn.rooms.create!(number:'Elefante', description:'Ótimo quarto com uma cama de casal', 
      double_beds:1, single_beds:0, capacity:2, price:100.00, bathrooms:1)
    customer = Customer.create!(name:'Roberto', cpf:'123', email:'roberto@email.com', password:'123456')
    res = room.reservations.create!(check_in_date: Time.zone.now, check_out_date: 12.days.from_now,
      guests:2, customer:customer)
    
    login_as(host, scope: :user)
    visit root_path
    click_on 'Reservas'
    click_on "#{res.code}"
    click_on 'Check-in'
    fill_in 'Nome', with: 'Lucas Perez'
    fill_in 'Documento', with: '26567496322'
    click_on 'Cadastrar Hóspede'


    expect(page).to have_content "Check-in reserva #{res.code}"
    expect(page).to have_link "Quarto: #{res.room.number}"
    expect(page).to have_content "Check-in: #{I18n.l(res.check_in_date)}"
    expect(page).to have_content "Check-out: #{I18n.l(res.check_out_date)}"
    expect(page).to have_content "Hóspedes:"
    expect(page).to have_content "Nome: Lucas Perez"
    expect(page).to have_content "Documento: 26567496322"
    expect(page).to have_field "Nome"
    expect(page).to have_field "Documento"
    expect(page).to have_button "Cadastrar Hóspede"
  end
  it 'and adds another guest and hit reservation limit' do
    host = User.create!(name: 'João', email:'joao@email.com', password:'password', host: true)
    address = Address.create!(street: 'Rua das torres', number:'28', neighborhood:'centro',
      city:'Campinas', state:'SP', cep:'15470-000')
    inn = host.create_inn!(name:'Safari', company_name:'Pousada Safari SN', cnpj:'456', phone:'223345',
      email:'pousadona@email.com', address:address, pix:true)
    room = inn.rooms.create!(number:'Elefante', description:'Ótimo quarto com uma cama de casal', 
      double_beds:1, single_beds:0, capacity:2, price:100.00, bathrooms:1)
    customer = Customer.create!(name:'Roberto', cpf:'123', email:'roberto@email.com', password:'123456')
    res = room.reservations.create!(check_in_date: Time.zone.now, check_out_date: 12.days.from_now,
      guests:2, customer:customer)
    res.additional_guests.create!(name:'Luisa Rocha', document:'45826315413')
    
    login_as(host, scope: :user)
    visit root_path
    click_on 'Reservas'
    click_on "#{res.code}"
    click_on 'Check-in'
    fill_in 'Nome', with: 'Lucas Perez'
    fill_in 'Documento', with: '26567496322'
    click_on 'Cadastrar Hóspede'


    expect(page).to have_content "Check-in reserva #{res.code}"
    expect(page).to have_link "Quarto: #{res.room.number}"
    expect(page).to have_content "Check-in: #{I18n.l(res.check_in_date)}"
    expect(page).to have_content "Check-out: #{I18n.l(res.check_out_date)}"
    expect(page).to have_content "Hóspedes:"
    expect(page).to have_content "Nome: Lucas Perez"
    expect(page).to have_content "Documento: 26567496322"
    expect(page).to have_content "Nome: Luisa Rocha"
    expect(page).to have_content "Documento: 45826315413"
    expect(page).not_to have_field "Nome"
    expect(page).not_to have_field "Documento"
    expect(page).not_to have_button "Cadastrar Hóspede"
  end
end