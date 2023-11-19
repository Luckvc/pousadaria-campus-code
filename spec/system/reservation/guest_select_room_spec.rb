require 'rails_helper'

describe 'Guest selects room' do
  it 'and sees booking page' do
    host = User.create!(name: 'Lucas', email:'test@email.com', password:'password', host: true)
    address = Address.create!(street: 'Rua das ruas', number:'12', neighborhood:'centro', 
                              city:'São Paulo', state:'SP', cep:'15470-000')
    inn = host.create_inn!(name:'Pousadinha', company_name:'Pousadinha SN', cnpj:'123', 
                           phone:'556618', email:'pousadinha@email.com', address:address)
    inn.rooms.create!(number:'101', description:'Ótimo quarto com uma cama de casal',
                      double_beds:1, single_beds:0, capacity:2, price_cents:100_00, bathrooms:1,
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
end