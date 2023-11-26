require 'rails_helper'

describe 'Host views reservation' do
  it 'from homepage' do
    host = User.create!(name: 'João', email:'joao@email.com', password:'password', host: true)
    host_two = User.create!(name: 'Lucas', email:'lucas@email.com', password:'password', host: true)
    address = Address.create!(street: 'Rua das torres', number:'28', neighborhood:'centro',
      city:'Campinas', state:'SP', cep:'15470-000')
    inn = host.create_inn!(name:'Safari', company_name:'Pousada Safari SN', cnpj:'456', phone:'223345',
      email:'pousadona@email.com', address:address, pix:true)
    room_one = inn.rooms.create!(number:'Elefante', description:'Ótimo quarto com uma cama de casal', 
      double_beds:1, single_beds:0, capacity:2, price:100.00, bathrooms:1)
    room_two = inn.rooms.create!(number:'Girafa', description:'Ótimo quarto com uma cama de solteiro', 
      double_beds:0, single_beds:1, capacity:1, price:200.00, bathrooms:1)

    customer = Customer.create!(name:'Roberto', cpf:'123', email:'roberto@email.com', password:'123456')
    res_one = room_one.reservations.create!(check_in_date: 2.days.from_now, check_out_date: 12.days.from_now,
      guests:2, customer:customer)
    res_two = room_two.reservations.create!(check_in_date: 2.days.from_now, check_out_date: 5.days.from_now,
      guests:2, customer:customer)
    res_three= room_two.reservations.create!(check_in_date: 8.days.from_now, check_out_date: 12.days.from_now,
      guests:2, customer:customer)

    login_as(host, scope: :user)
    visit root_path
    click_on 'Reservas'

    expect(page).to have_content "Reservas"
    expect(page).to have_content "Código: #{res_one.code}"
    expect(page).to have_content "Código: #{res_two.code}"
    expect(page).to have_content "Código: #{res_three.code}"
    expect(page).to have_content "Quarto: #{res_one.room.number}"
    expect(page).to have_content "Quarto: #{res_two.room.number}"
    expect(page).to have_content "Quarto: #{res_three.room.number}"
    expect(page).to have_content "Check-in: #{I18n.l(res_one.check_in_date.to_date)}"
    expect(page).to have_content "Check-in: #{I18n.l(res_two.check_in_date.to_date)}"
    expect(page).to have_content "Check-in: #{I18n.l(res_three.check_in_date.to_date)}"
  end
end