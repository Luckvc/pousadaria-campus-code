require 'rails_helper'

describe 'Host checks-out guests' do
  it 'and sees check-out page' do
    host = User.create!(name: 'João', email:'joao@email.com', password:'password', host: true)
    address = Address.create!(street: 'Rua das torres', number:'28', neighborhood:'centro',
      city:'Campinas', state:'SP', cep:'15470-000')
    inn = host.create_inn!(name:'Safari', company_name:'Pousada Safari SN', cnpj:'456', phone:'223345',
      email:'pousadona@email.com', address:address, pix:true)
    room = inn.rooms.create!(number:'Elefante', description:'Ótimo quarto com uma cama de casal', 
      double_beds:1, single_beds:0, capacity:2, price:100.00, bathrooms:1)
    customer = Customer.create!(name:'Roberto', cpf:'123', email:'roberto@email.com', password:'123456')
    res = room.reservations.create!(check_in_date: 5.days.ago, check_out_date: Time.zone.now,
      guests:2, customer:customer, checked_in_datetime: 2.days.ago, status:"ongoing")
    
    login_as(host, scope: :user)
    visit root_path
    click_on 'Estadias Ativas'
    click_on "#{res.code}"
    click_on 'Check-out'

    expect(page).to have_content "Check-out reserva #{res.code}"
    expect(page).to have_link "Quarto: #{res.room.number}"
    expect(page).to have_content "Check-in: #{res.checked_in_datetime}"
    expect(page).to have_content "Hóspedes: 2"
    expect(page).to have_content "Total a pagar:"
    expect(page).to have_field "Forma de pagamento"
  end
  it 'and sees check-out page with correct total to be paid' do
    host = User.create!(name: 'João', email:'joao@email.com', password:'password', host: true)
    address = Address.create!(street: 'Rua das torres', number:'28', neighborhood:'centro',
      city:'Campinas', state:'SP', cep:'15470-000')
    inn = host.create_inn!(name:'Safari', company_name:'Pousada Safari SN', cnpj:'456', phone:'223345',
      email:'pousadona@email.com', address:address, pix:true)
    room = inn.rooms.create!(number:'Elefante', description:'Ótimo quarto com uma cama de casal', 
      double_beds:1, single_beds:0, capacity:2, price:100.00, bathrooms:1)
    customer = Customer.create!(name:'Roberto', cpf:'123', email:'roberto@email.com', password:'123456')
    res = room.reservations.create!(check_in_date: 5.days.ago, check_out_date: Time.zone.now,
      guests:2, customer:customer, checked_in_datetime: 5.days.ago, status:"ongoing")
    
    login_as(host, scope: :user)
    visit root_path
    click_on 'Estadias Ativas'
    click_on "#{res.code}"
    click_on 'Check-out'

    expect(page).to have_content "Check-out reserva #{res.code}"
    expect(page).to have_link "Quarto: #{res.room.number}"
    expect(page).to have_content "Check-in: #{res.checked_in_datetime}"
    expect(page).to have_content "Hóspedes: 2"
    expect(page).to have_content "Total a pagar: R$ 500,00"
    expect(page).to have_field "Forma de pagamento"
  end
end
