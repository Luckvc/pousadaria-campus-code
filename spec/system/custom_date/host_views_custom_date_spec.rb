require 'rails_helper'

describe 'host views custom dates' do
  it 'with no custom dates registered' do
    #Arrange
    host = User.create!(name: 'Lucas', email:'test@email.com', password:'password', host: true)
    address = Address.create!(street: 'Rua das ruas', number:'12', neighborhood:'centro', city:'São Paulo', state:'SP',
                              cep:'15470-000')
    inn = host.create_inn!(name:'Pousadinha', company_name:'Pousadinha SN', cnpj:'123', phone:'556618', 
                           email:'pousadinha@email.com', address:address)
    room = inn.rooms.create!(number:'101', description:'Ótimo quarto com uma cama de casal, tv, varanda com vista para a praia', 
                            double_beds:1, single_beds:0, capacity:2, price_cents:100_00, bathrooms:1, kitchen:false)
    #Act
    login(host)
    click_on 'Minha Pousada'
    #Assert
    expect(page).to have_content 'Sem períodos de alteração de preço adicionados'
    #expect(page).to have_css("custom_dates", :text => 'Diária')
  end
  it 'from my_inn' do
    host = User.create!(name: 'Lucas', email:'test@email.com', password:'password', host: true)
    address = Address.create!(street: 'Rua das ruas', number:'12', neighborhood:'centro', city:'São Paulo', state:'SP',
                              cep:'15470-000')
    inn = host.create_inn!(name:'Pousadinha', company_name:'Pousadinha SN', cnpj:'123', phone:'556618', 
                           email:'pousadinha@email.com', address:address)
    room = inn.rooms.create!(number:'101', description:'Ótimo quarto com uma cama de casal, tv, varanda com vista para a praia', 
                            double_beds:1, single_beds:0, capacity:2, price_cents:100_00, bathrooms:1, kitchen:false)
    room.custom_dates.create!(begin:'2023-11-05', end:'2023-12-05', price_cents:200_00)
    room.custom_dates.create!(begin:'2023-12-06', end:'2024-01-30', price_cents:300_00)

    login(host)
    click_on 'Minha Pousada'

    expect(page).to have_content 'Períodos de alteração de preço'
    expect(page).to have_content 'De 05/11/2023 até 05/12/2023'
    expect(page).to have_content 'De 06/12/2023 até 30/01/2024'
    expect(page).to have_content 'Diária: R$ 200,00'
    expect(page).to have_content 'Diária: R$ 300,00'  
  end
end