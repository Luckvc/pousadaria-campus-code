require 'rails_helper'

describe 'Host registers consumable' do
  it 'from ongoing reservations page' do
    host = User.create!(name: 'Lucas', email:'lucas@email.com', password:'password', host: true)
    address = Address.create!(street: 'Rua das torres', number:'28', neighborhood:'centro',
      city:'Campinas', state:'SP', cep:'15470-000')
    inn = host.create_inn!(name:'Safari', company_name:'Pousada Safari SN', cnpj:'456', phone:'223345',
      email:'pousadona@email.com', address:address, pix:true)
    room = inn.rooms.create!(number:'Elefante', description:'Ótimo quarto com uma cama de casal', 
      double_beds:1, single_beds:0, capacity:2, price:100.00, bathrooms:1)
    customer = Customer.create!(name:'Roberto', cpf:'123', email:'roberto@email.com', password:'123456')
    res_one = room.reservations.create!(check_in_date: 2.days.ago, check_out_date: 12.days.from_now,
      guests:2, customer:customer, status:'ongoing')

    login_as(host, scope: :user) 
    visit root_path
    click_on 'Estadias Ativas'
    click_on res_one.code
    click_on 'Adicionar Consumível'

    expect(page).to have_field 'Preço'
    expect(page).to have_content 'Descrição'
  end
  it 'successfully' do
    host = User.create!(name: 'Lucas', email:'lucas@email.com', password:'password', host: true)
    address = Address.create!(street: 'Rua das torres', number:'28', neighborhood:'centro',
      city:'Campinas', state:'SP', cep:'15470-000')
    inn = host.create_inn!(name:'Safari', company_name:'Pousada Safari SN', cnpj:'456', phone:'223345',
      email:'pousadona@email.com', address:address, pix:true)
    room = inn.rooms.create!(number:'Elefante', description:'Ótimo quarto com uma cama de casal', 
      double_beds:1, single_beds:0, capacity:2, price:100.00, bathrooms:1)
    customer = Customer.create!(name:'Roberto', cpf:'123', email:'roberto@email.com', password:'123456')
    res_one = room.reservations.create!(check_in_date: 2.days.ago, check_out_date: 12.days.from_now,
      guests:2, customer:customer, status:'ongoing')

    login_as(host, scope: :user) 
    visit root_path
    click_on 'Estadias Ativas'
    click_on res_one.code
    click_on 'Adicionar Consumível'
    fill_in 'Descrição', with: 'Barra de chocolate'
    fill_in 'Preço', with: '15'
    click_on 'Cadastrar Consumível'

    expect(page).to have_content 'Consumo cadastrado com sucesso'
    expect(page).to have_content 'Consumo:'
    expect(page).to have_content 'Barra de chocolate - R$ 15,00'
  end
  it 'successfully with other consumables registered' do
    host = User.create!(name: 'Lucas', email:'lucas@email.com', password:'password', host: true)
    address = Address.create!(street: 'Rua das torres', number:'28', neighborhood:'centro',
      city:'Campinas', state:'SP', cep:'15470-000')
    inn = host.create_inn!(name:'Safari', company_name:'Pousada Safari SN', cnpj:'456', phone:'223345',
      email:'pousadona@email.com', address:address, pix:true)
    room = inn.rooms.create!(number:'Elefante', description:'Ótimo quarto com uma cama de casal', 
      double_beds:1, single_beds:0, capacity:2, price:100.00, bathrooms:1)
    customer = Customer.create!(name:'Roberto', cpf:'123', email:'roberto@email.com', password:'123456')
    res_one = room.reservations.create!(check_in_date: 2.days.ago, check_out_date: 12.days.from_now,
      guests:2, customer:customer, status:'ongoing')
    res_one.consumables.create!(description:'Água de Côco', price:8.5)
    res_one.consumables.create!(description:'Coca-cola', price:6.25)
    res_one.consumables.create!(description:'Energético', price:18)

    login_as(host, scope: :user) 
    visit root_path
    click_on 'Estadias Ativas'
    click_on res_one.code
    click_on 'Adicionar Consumível'
    fill_in 'Descrição', with: 'Barra de chocolate'
    fill_in 'Preço', with: '15'
    click_on 'Cadastrar Consumível'

    expect(page).to have_content 'Consumo cadastrado com sucesso'
    expect(page).to have_content 'Consumo:'
    expect(page).to have_content 'Barra de chocolate - R$ 15,00'
    expect(page).to have_content 'Energético - R$ 18,00'
    expect(page).to have_content 'Coca-cola - R$ 6,25'
    expect(page).to have_content 'Água de Côco - R$ 8,50'
  end
  it 'unsuccessfully' do
    host = User.create!(name: 'Lucas', email:'lucas@email.com', password:'password', host: true)
    address = Address.create!(street: 'Rua das torres', number:'28', neighborhood:'centro',
      city:'Campinas', state:'SP', cep:'15470-000')
    inn = host.create_inn!(name:'Safari', company_name:'Pousada Safari SN', cnpj:'456', phone:'223345',
      email:'pousadona@email.com', address:address, pix:true)
    room = inn.rooms.create!(number:'Elefante', description:'Ótimo quarto com uma cama de casal', 
      double_beds:1, single_beds:0, capacity:2, price:100.00, bathrooms:1)
    customer = Customer.create!(name:'Roberto', cpf:'123', email:'roberto@email.com', password:'123456')
    res_one = room.reservations.create!(check_in_date: 2.days.ago, check_out_date: 12.days.from_now,
      guests:2, customer:customer, status:'ongoing')

    login_as(host, scope: :user) 
    visit root_path
    click_on 'Estadias Ativas'
    click_on res_one.code
    click_on 'Adicionar Consumível'
    fill_in 'Descrição', with: 'Barra de chocolate'
    fill_in 'Preço', with: ''
    click_on 'Cadastrar Consumível'

    expect(page).to have_content 'Não foi possível cadastrar consumo'
  end
end