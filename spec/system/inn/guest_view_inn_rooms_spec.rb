require 'rails_helper'


describe 'Guest views inn rooms' do
  it 'from home page' do
    host = User.create!(name: 'Lucas', email:'test@email.com', password:'password', host: true)
    address = Address.create!(street: 'Rua das ruas', number:'12', neighborhood:'centro',
                              city:'São Paulo', state:'SP', cep:'15470-000')
    host.create_inn!(name:'Pousadinha', company_name:'Pousadinha SN', cnpj:'123', phone:'556618',
                     email:'pousadinha@email.com', address:address)
    host2 = User.create!(name: 'João', email:'joao@email.com', password:'password', host: true)
    address2 = Address.create!(street: 'Rua das torres', number:'28', neighborhood:'centro',
                               city:'Campinas', state:'SP', cep:'15470-000')
    inn = host2.create_inn!(name:'Pousadona', company_name:'Pousadona SN', cnpj:'456', phone:'223345',
                            email:'pousadona@email.com', address:address2)
    inn.rooms.create!(number:'Elefante', description:'Ótimo quarto com uma cama de casal, tv, varanda com vista para a praia', 
                      double_beds:1, single_beds:0, capacity:2, 
                      price_cents:100_00, bathrooms:1, kitchen:false)
    inn.rooms.create!(number:'Leão', description:'Ótimo quarto com cozinha, uma cama de casal e uma de solteiro, tv, varanda com vista para a praia',
                      double_beds:1, single_beds:2, capacity:3, price_cents:150_00, bathrooms:0, kitchen:true)

    visit root_path
    click_on 'Pousada Pousadona'

    expect(page).to have_content 'Quarto Elefante'
    expect(page).to have_content '2 Hóspedes'
    expect(page).to have_content 'Quarto Leão'
    expect(page).to have_content '3 Hóspedes'
    expect(page).to have_content 'Descrição: Ótimo quarto com uma cama de casal, tv, varanda com vista para a praia'
    expect(page).to have_content 'Descrição: Ótimo quarto com cozinha, uma cama de casal e uma de solteiro, tv, varanda com vista para a praia'
    
  end
  it 'from search' do
    
  end
end