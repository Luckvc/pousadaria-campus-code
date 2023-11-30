require 'rails_helper'

describe 'Host views reviews' do
  it 'page' do
    host = User.create!(name: 'João', email:'joao@email.com', password:'password', host: true)
    address = Address.create!(street: 'Rua das torres', number:'28', neighborhood:'centro',
      city:'Campinas', state:'SP', cep:'15470-000')
    inn = host.create_inn!(name:'Safari', company_name:'Pousada Safari SN', cnpj:'456', phone:'223345',
      email:'pousadona@email.com', address:address, pix:true, credit:true, debit:true, cash:true)
    room = inn.rooms.create!(number:'Elefante', description:'Ótimo quarto com uma cama de casal', 
      double_beds:1, single_beds:0, capacity:2, price:100.00, bathrooms:1)
    customer = Customer.create!(name:'Roberto', cpf:'123', email:'roberto@email.com', password:'123456')
    res = room.reservations.create!(check_in_date: 10.days.ago, check_out_date: 6.days.ago,
      guests:2, customer:customer, checked_in_datetime: 10.days.ago, checked_out_datetime: 6.days.ago,
      status:"completed")
    res2 = room.reservations.create!(check_in_date: 5.days.ago, check_out_date: Time.zone.now,
      guests:2, customer:customer, checked_in_datetime: 5.days.ago, checked_out_datetime: 1.days.ago,
      status:"completed")
    res.create_review!(score: 5, message: 'Ótima estadia, adorei', customer:customer)
    res2.create_review!(score: 3, message: 'Bom', customer:customer)


    login_as(host, scope: :user)
    visit root_path
    click_on 'Avaliações'

    expect(page).to have_content 'Avaliações da Pousada Safari'
    expect(page).to have_content 'Nota: 5'
    expect(page).to have_content 'Mensagem: Ótima estadia, adorei'
    expect(page).to have_content 'Nota: 3'
    expect(page).to have_content 'Mensagem: Bom'
  end
  it 'page with no reviews' do
    host = User.create!(name: 'João', email:'joao@email.com', password:'password', host: true)
    address = Address.create!(street: 'Rua das torres', number:'28', neighborhood:'centro',
      city:'Campinas', state:'SP', cep:'15470-000')
    inn = host.create_inn!(name:'Safari', company_name:'Pousada Safari SN', cnpj:'456', phone:'223345',
      email:'pousadona@email.com', address:address, pix:true, credit:true, debit:true, cash:true)
    room = inn.rooms.create!(number:'Elefante', description:'Ótimo quarto com uma cama de casal', 
      double_beds:1, single_beds:0, capacity:2, price:100.00, bathrooms:1)

    login_as(host, scope: :user)
    visit root_path
    click_on 'Avaliações'

    expect(page).to have_content 'Sem Avaliações'
    expect(page).not_to have_content 'Nota:'
    expect(page).not_to have_content 'Mensagem:'
    expect(page).not_to have_content 'Nota:'
  end
  it 'and answers' do
    host = User.create!(name: 'João', email:'joao@email.com', password:'password', host: true)
    address = Address.create!(street: 'Rua das torres', number:'28', neighborhood:'centro',
      city:'Campinas', state:'SP', cep:'15470-000')
    inn = host.create_inn!(name:'Safari', company_name:'Pousada Safari SN', cnpj:'456', phone:'223345',
      email:'pousadona@email.com', address:address, pix:true, credit:true, debit:true, cash:true)
    room = inn.rooms.create!(number:'Elefante', description:'Ótimo quarto com uma cama de casal', 
      double_beds:1, single_beds:0, capacity:2, price:100.00, bathrooms:1)
    customer = Customer.create!(name:'Roberto', cpf:'123', email:'roberto@email.com', password:'123456')
    res = room.reservations.create!(check_in_date: 10.days.ago, check_out_date: 6.days.ago,
      guests:2, customer:customer, checked_in_datetime: 10.days.ago, checked_out_datetime: 6.days.ago,
      status:"completed")
    res2 = room.reservations.create!(check_in_date: 5.days.ago, check_out_date: Time.zone.now,
      guests:2, customer:customer, checked_in_datetime: 5.days.ago, checked_out_datetime: 1.days.ago,
      status:"completed")
    res.create_review!(score: 5, message: 'Ótima estadia, adorei', customer:customer)


    login_as(host, scope: :user)
    visit root_path
    click_on 'Avaliações'
    fill_in 'Resposta', with: 'Obrigado pela avaliação'
    click_on 'Responder'

    expect(page).to have_content 'Nota: 5'
    expect(page).to have_content 'Mensagem: Ótima estadia, adorei'
    expect(page).to have_content 'Resposta: Obrigado pela avaliação'
  end
  it 'and do not answer' do
    host = User.create!(name: 'João', email:'joao@email.com', password:'password', host: true)
    address = Address.create!(street: 'Rua das torres', number:'28', neighborhood:'centro',
      city:'Campinas', state:'SP', cep:'15470-000')
    inn = host.create_inn!(name:'Safari', company_name:'Pousada Safari SN', cnpj:'456', phone:'223345',
      email:'pousadona@email.com', address:address, pix:true, credit:true, debit:true, cash:true)
    room = inn.rooms.create!(number:'Elefante', description:'Ótimo quarto com uma cama de casal', 
      double_beds:1, single_beds:0, capacity:2, price:100.00, bathrooms:1)
    customer = Customer.create!(name:'Roberto', cpf:'123', email:'roberto@email.com', password:'123456')
    res = room.reservations.create!(check_in_date: 10.days.ago, check_out_date: 6.days.ago,
      guests:2, customer:customer, checked_in_datetime: 10.days.ago, checked_out_datetime: 6.days.ago,
      status:"completed")
    res2 = room.reservations.create!(check_in_date: 5.days.ago, check_out_date: Time.zone.now,
      guests:2, customer:customer, checked_in_datetime: 5.days.ago, checked_out_datetime: 1.days.ago,
      status:"completed")
    res.create_review!(score: 5, message: 'Ótima estadia, adorei', customer:customer)


    login_as(host, scope: :user)
    visit root_path
    click_on 'Avaliações'
    fill_in 'Resposta', with: ''
    click_on 'Responder'

    expect(page).to have_content 'Nota: 5'
    expect(page).to have_content 'Mensagem: Ótima estadia, adorei'
    expect(page).to have_content 'Resposta inválida'
    expect(page).to have_field 'Resposta'
  end
end