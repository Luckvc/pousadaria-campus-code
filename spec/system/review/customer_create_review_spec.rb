require 'rails_helper' 

describe 'Customer reviews' do
  it 'available from my reservations page' do
    host = User.create!(name: 'João', email:'joao@email.com', password:'password', host: true)
    address = Address.create!(street: 'Rua das torres', number:'28', neighborhood:'centro',
      city:'Campinas', state:'SP', cep:'15470-000')
    inn = host.create_inn!(name:'Safari', company_name:'Pousada Safari SN', cnpj:'456', phone:'223345',
      email:'pousadona@email.com', address:address, pix:true, credit:true, debit:true, cash:true)
    room = inn.rooms.create!(number:'Elefante', description:'Ótimo quarto com uma cama de casal', 
      double_beds:1, single_beds:0, capacity:2, price:100.00, bathrooms:1)
    customer = Customer.create!(name:'Roberto', cpf:'123', email:'roberto@email.com', password:'123456')
    res = room.reservations.create!(check_in_date: 5.days.ago, check_out_date: Time.zone.now,
      guests:2, customer:customer, checked_in_datetime: 5.days.ago, checked_out_datetime: 1.days.ago,
      status:"completed")

    login_as(customer, scope: :customer)
    visit root_path
    click_on 'Minhas Reservas'
    click_on res.code
    click_on 'Fazer Avaliação'

    expect(page).to have_content 'Nota'
    expect(page).to have_content 'Mensagem'
  end
  it 'a reservation successfully' do
    host = User.create!(name: 'João', email:'joao@email.com', password:'password', host: true)
    address = Address.create!(street: 'Rua das torres', number:'28', neighborhood:'centro',
      city:'Campinas', state:'SP', cep:'15470-000')
    inn = host.create_inn!(name:'Safari', company_name:'Pousada Safari SN', cnpj:'456', phone:'223345',
      email:'pousadona@email.com', address:address, pix:true, credit:true, debit:true, cash:true)
    room = inn.rooms.create!(number:'Elefante', description:'Ótimo quarto com uma cama de casal', 
      double_beds:1, single_beds:0, capacity:2, price:100.00, bathrooms:1)
    customer = Customer.create!(name:'Roberto', cpf:'123', email:'roberto@email.com', password:'123456')
    res = room.reservations.create!(check_in_date: 5.days.ago, check_out_date: Time.zone.now,
      guests:2, customer:customer, checked_in_datetime: 5.days.ago, checked_out_datetime: 1.days.ago,
      status:"completed")

    login_as(customer, scope: :customer)
    visit root_path
    click_on 'Minhas Reservas'
    click_on res.code
    click_on 'Fazer Avaliação'
    fill_in 'Nota', with: '5'
    fill_in 'Mensagem', with: 'Ótima estadia'
    click_on 'Avaliar'

    expect(page).to have_content 'Avaliação registrada'
    expect(page).to have_content 'Nota: 5'
    expect(page).to have_content 'Mensagem: Ótima estadia'
  end
  it 'a reservation and sees answer' do
    host = User.create!(name: 'João', email:'joao@email.com', password:'password', host: true)
    address = Address.create!(street: 'Rua das torres', number:'28', neighborhood:'centro',
      city:'Campinas', state:'SP', cep:'15470-000')
    inn = host.create_inn!(name:'Safari', company_name:'Pousada Safari SN', cnpj:'456', phone:'223345',
      email:'pousadona@email.com', address:address, pix:true, credit:true, debit:true, cash:true)
    room = inn.rooms.create!(number:'Elefante', description:'Ótimo quarto com uma cama de casal', 
      double_beds:1, single_beds:0, capacity:2, price:100.00, bathrooms:1)
    customer = Customer.create!(name:'Roberto', cpf:'123', email:'roberto@email.com', password:'123456')
    res = room.reservations.create!(check_in_date: 5.days.ago, check_out_date: Time.zone.now,
      guests:2, customer:customer, checked_in_datetime: 5.days.ago, checked_out_datetime: 1.days.ago,
      status:"completed")
    res.create_review!(score: 5, message: 'Ótima estadia, adorei', answer:'Obrigado pela avaliação', customer:customer)

    login_as(customer, scope: :customer)
    visit root_path
    click_on 'Minhas Reservas'
    click_on res.code

    expect(page).to have_content 'Nota: 5'
    expect(page).to have_content 'Mensagem: Ótima estadia'
    expect(page).to have_content 'Resposta: Obrigado pela avaliação'
  end
end