require 'rails_helper'

describe 'Inn show review' do
  it 'medium score on Inn page' do
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
    res3 = room.reservations.create!(check_in_date: 5.days.ago, check_out_date: Time.zone.now,
      guests:2, customer:customer, checked_in_datetime: 5.days.ago, checked_out_datetime: 1.days.ago,
      status:"completed")
    res.create_review!(score: 5, message: 'Ótima estadia, adorei', customer:customer)
    res2.create_review!(score: 3, message: 'Bom', customer:customer)
    res3.create_review!(score: 4, message: 'Ótimo', customer:customer)

    visit root_path
    click_on 'Safari'

    expect(page).to have_content 'Avaliações: 4'
  end
  it 'with no reviews' do
    host = User.create!(name: 'João', email:'joao@email.com', password:'password', host: true)
    address = Address.create!(street: 'Rua das torres', number:'28', neighborhood:'centro',
      city:'Campinas', state:'SP', cep:'15470-000')
    inn = host.create_inn!(name:'Safari', company_name:'Pousada Safari SN', cnpj:'456', phone:'223345',
      email:'pousadona@email.com', address:address, pix:true, credit:true, debit:true, cash:true)

    visit root_path
    click_on 'Safari'

    expect(page).to have_content 'Avaliações:'
    expect(page).to have_content 'Sem avaliações registradas'
  end
  it 'only the last 3' do
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
    res3 = room.reservations.create!(check_in_date: 5.days.ago, check_out_date: Time.zone.now,
      guests:2, customer:customer, checked_in_datetime: 5.days.ago, checked_out_datetime: 1.days.ago,
      status:"completed")
    res4 = room.reservations.create!(check_in_date: 5.days.ago, check_out_date: Time.zone.now,
      guests:2, customer:customer, checked_in_datetime: 5.days.ago, checked_out_datetime: 1.days.ago,
      status:"completed")
    res.create_review!(score: 5, message: 'Ótima estadia, adorei', customer:customer)
    res2.create_review!(score: 3, message: 'Bom', customer:customer)
    res3.create_review!(score: 4, message: 'Ótimo', customer:customer)
    res4.create_review!(score: 5, message: 'Maravilhoso', customer:customer)

    visit root_path
    click_on 'Safari'

    expect(page).to have_content 'Nota: 5'
    expect(page).to have_content 'Nota: 4'
    expect(page).to have_content 'Nota: 3'
    expect(page).to have_content 'Mensagem: Maravilhoso'
    expect(page).to have_content 'Mensagem: Ótimo'
    expect(page).to have_content 'Mensagem: Bom'
    expect(page).not_to have_content 'Mensagem: Ótima estadia, adorei'
  end
end