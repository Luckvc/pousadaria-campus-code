require 'rails_helper'

describe 'Guest selects available room' do
  it 'and has to be authenticated' do
    host = User.create!(name: 'Lucas', email:'test@email.com', password:'password', host: true)
    address = Address.create!(street: 'Rua das ruas', number:'12', neighborhood:'Centro', 
                              city:'São Paulo', state:'SP', cep:'15470-000')
    inn = host.create_inn!(name:'Pomar', company_name:'Pousadinha SN', cnpj:'123', 
                           phone:'556618', email:'pousadinha@email.com', address:address,
                           pix:true, credit:true, debit:true, cash:true)
    room = inn.rooms.create!(number:'Amora', description:'Ótimo quarto com uma cama de casal',
                      double_beds:1, single_beds:0, capacity:2, price:100.00, bathrooms:1,
                      kitchen:false)

    allow(SecureRandom).to receive(:alphanumeric).and_return('ABC12345')
    visit new_room_pre_reservation_path(room)
    fill_in 'Data de Check-in', with: 2.days.from_now.to_date
    fill_in 'Data de Check-out', with: 5.days.from_now.to_date
    fill_in 'Hóspedes', with: '2'
    click_on 'Checar Disponibilidade'
    click_on 'Confirmar Reserva'
    click_on 'Criar Conta'
    fill_in 'CPF', with: '222'
    fill_in 'Nome', with: 'Roberto'
    fill_in 'E-mail', with: 'roberto@email.com'
    fill_in 'Senha', with: 'password'
    fill_in 'Confirme sua senha', with: 'password'
    within ('div form') do
      click_on 'Criar Conta'
    end
    click_on 'Confirmar Reserva'

    expect(page).to have_content 'Reserva ABC12345'
    expect(page).to have_content 'Reserva confirmada'
    expect(page).to have_content 'Pousada: Pomar'
    expect(page).to have_content 'Quarto: Amora'
    expect(page).to have_content 'Endereço: Rua das ruas, 12 - Centro, São Paulo - SP'
    expect(page).to have_content "Check-in: #{I18n.l(2.days.from_now.to_date)} - 14:00" 
    expect(page).to have_content "Check-out: #{I18n.l(5.days.from_now.to_date)} - 12:00" 
    expect(page).to have_content "Total: R$ 300,00" 
    expect(page).to have_content "Meios de Pagamento: Pix Cartão de Crédito Cartão de Débito Dinheiro" 
  end
  it 'a total is caculated correctly with seasonal price' do
    host = User.create!(name: 'Lucas', email:'test@email.com', password:'password', host: true)
    address = Address.create!(street: 'Rua das ruas', number:'12', neighborhood:'Centro', 
                              city:'São Paulo', state:'SP', cep:'15470-000')
    inn = host.create_inn!(name:'Pousadinha', company_name:'Pousadinha SN', cnpj:'123', 
                           phone:'556618', email:'pousadinha@email.com', address:address)
    room = inn.rooms.create!(number:'101', description:'Ótimo quarto com uma cama de casal',
                      double_beds:1, single_beds:0, capacity:2, price:100.00, bathrooms:1,
                      kitchen:false)
    room.custom_dates.create!(begin:10.days.from_now.to_date, end:20.days.from_now.to_date, price:200.00)
    customer = Customer.create!(name:'nome', cpf:'123', email:'email@email.com', password:'123123')

    login_as(customer, scope: :customer)
    visit new_room_pre_reservation_path(room)
    fill_in 'Data de Check-in', with: 5.days.from_now.to_date
    fill_in 'Data de Check-out', with: 15.days.from_now.to_date
    fill_in 'Hóspedes', with: '2'
    click_on 'Checar Disponibilidade'
    click_on 'Confirmar Reserva'

    expect(page).to have_content 'Total: R$ 1.500,00'
  end
end