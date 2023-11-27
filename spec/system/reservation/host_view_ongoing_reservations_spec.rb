require 'rails_helper'

describe 'Host views ongoing reservations' do
  it 'page' do
    host = User.create!(name: 'Lucas', email:'lucas@email.com', password:'password', host: true)
    host2 = User.create!(name: 'João', email:'joao@email.com', password:'password', host: true)
    address = Address.create!(street: 'Rua das torres', number:'28', neighborhood:'centro',
      city:'Campinas', state:'SP', cep:'15470-000')
    inn = host2.create_inn!(name:'Safari', company_name:'Pousada Safari SN', cnpj:'456', phone:'223345',
      email:'pousadona@email.com', address:address, pix:true)
    room = inn.rooms.create!(number:'Elefante', description:'Ótimo quarto com uma cama de casal', 
      double_beds:1, single_beds:0, capacity:2, price:100.00, bathrooms:1)
    customer = Customer.create!(name:'Roberto', cpf:'123', email:'roberto@email.com', password:'123456')
    res_one = room.reservations.create!(check_in_date: 2.days.ago, check_out_date: 12.days.from_now,
      guests:2, customer:customer, status:'ongoing')
    res_two = room.reservations.create!(check_in_date: 12.days.from_now, check_out_date: 15.days.from_now,
      guests:2, customer:customer)
    
    login_as(host2, scope: :user)
    visit root_path
    click_on 'Estadias Ativas'

    expect(page).not_to have_content "Código: #{res_two.code}"
    expect(page).to have_link "#{res_one.code}"
    expect(page).to have_content "Quarto: #{res_one.room.number}"
    expect(page).to have_content "Check-in: #{res_one.checked_in_datetime}"
    expect(page).to have_content "Check-out: #{I18n.l(res_one.check_out_date)}"
  end
end