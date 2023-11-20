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
                      price:100.00, bathrooms:1, kitchen:false)
    inn.rooms.create!(number:'Leão', description:'Ótimo quarto com cozinha, uma cama de casal e uma de solteiro, tv, varanda com vista para a praia',
                      double_beds:1, single_beds:2, capacity:3, price:150.00, bathrooms:0, kitchen:true)
    visit root_path
    click_on 'Pousadona'
    click_on 'Quarto Elefante'

    expect(page).to have_content 'Quarto Elefante'
    expect(page).to have_content '2 Hóspedes'
    expect(page).to have_content 'Descrição: Ótimo quarto com uma cama de casal, tv, varanda com vista para a praia'
    expect(page).to have_content 'Banheiros: 1'
    expect(page).to have_content 'Camas: 1 de Casal'
    expect(page).to have_content 'Cozinha: Não'
    expect(page).not_to have_content 'Diária:'
  end
end