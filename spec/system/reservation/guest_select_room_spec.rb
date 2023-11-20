require 'rails_helper'

describe 'Guest selects room' do
  it 'and sees reservation page' do
    host = User.create!(name: 'Lucas', email:'test@email.com', password:'password', host: true)
    address = Address.create!(street: 'Rua das ruas', number:'12', neighborhood:'centro', 
                              city:'São Paulo', state:'SP', cep:'15470-000')
    inn = host.create_inn!(name:'Pousadinha', company_name:'Pousadinha SN', cnpj:'123', 
                           phone:'556618', email:'pousadinha@email.com', address:address)
    inn.rooms.create!(number:'101', description:'Ótimo quarto com uma cama de casal',
                      double_beds:1, single_beds:0, capacity:2, price:100.00, bathrooms:1,
                      kitchen:false)

    visit root_path
    click_on 'Pousadinha'
    click_on 'Quarto 101'
    click_on 'Reservar'

    expect(page).to have_content 'Quarto 101'
    expect(page).to have_content 'Camas: 1 de Casal'
    expect(page).to have_content '2 Hóspedes'
    expect(page).to have_content 'Reserva'
    expect(page).to have_content 'Data de Check-in'
    expect(page).to have_field 'Data de Check-out'
    expect(page).to have_field 'Hóspedes'
  end
  it 'and checks availibility successfully' do
    host = User.create!(name: 'Lucas', email:'test@email.com', password:'password', host: true)
    address = Address.create!(street: 'Rua das ruas', number:'12', neighborhood:'Centro', 
                              city:'São Paulo', state:'SP', cep:'15470-000')
    inn = host.create_inn!(name:'Pousadinha', company_name:'Pousadinha SN', cnpj:'123', 
                           phone:'556618', email:'pousadinha@email.com', address:address)
    room = inn.rooms.create!(number:'101', description:'Ótimo quarto com uma cama de casal',
                      double_beds:1, single_beds:0, capacity:2, price:100.00, bathrooms:1,
                      kitchen:false)

    visit new_room_pre_reservation_path(room)
    fill_in 'Data de Check-in', with: 2.days.from_now.to_date
    fill_in 'Data de Check-out', with: 5.days.from_now.to_date
    fill_in 'Hóspedes', with: '2'
    click_on 'Checar Disponibilidade'

    expect(page).to have_content 'Resumo da Reserva'
    expect(page).to have_content 'Pousada: Pousadinha'
    expect(page).to have_content 'Quarto: 101'
    expect(page).to have_content 'Endereço: Rua das ruas, 12 - Centro, São Paulo - SP'
    expect(page).to have_content "Check-in: #{I18n.l(2.days.from_now.to_date)}" 
    expect(page).to have_content "Check-out: #{I18n.l(5.days.from_now.to_date)}" 
    expect(page).to have_content "Total: R$ 300,00" 
    expect(page).to have_button 'Confirmar Reserva'
  end
  it 'and checks availibility unsuccessfully' do
    host = User.create!(name: 'Lucas', email:'test@email.com', password:'password', host: true)
    address = Address.create!(street: 'Rua das ruas', number:'12', neighborhood:'Centro', 
                              city:'São Paulo', state:'SP', cep:'15470-000')
    inn = host.create_inn!(name:'Pousadinha', company_name:'Pousadinha SN', cnpj:'123', 
                           phone:'556618', email:'pousadinha@email.com', address:address)
    room = inn.rooms.create!(number:'101', description:'Ótimo quarto com uma cama de casal',
                      double_beds:1, single_beds:0, capacity:2, price:100.00, bathrooms:1,
                      kitchen:false)  
    customer = Customer.create!(name:'nome', cpf:'123', email:'email@email.com', password:'123123')
    customer.reservations.create!(check_in_date:10.days.from_now.to_date,
                                check_out_date:20.days.from_now.to_date, guests: 2, room:room)


    visit new_room_pre_reservation_path(room)
    fill_in 'Data de Check-in', with: 5.days.from_now.to_date
    fill_in 'Data de Check-out', with: 15.days.from_now.to_date
    fill_in 'Hóspedes', with: '2'
    click_on 'Checar Disponibilidade'
    
    expect(page).to have_content 'Reserva indisponível'
  end
end