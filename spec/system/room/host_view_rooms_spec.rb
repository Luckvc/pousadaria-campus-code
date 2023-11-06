require 'rails_helper'

describe 'Host views room in inn page' do
  it 'with no room registered' do
    #Arrange
    host = User.create!(name: 'Lucas', email:'test@email.com', password:'password', host: true)
    address = Address.create!(street: 'Rua das ruas', number:'12', neighborhood:'centro', 
                              city:'São Paulo', state:'SP', cep:'15470-000')
    host.create_inn!(name:'Pousadinha', company_name:'Pousadinha SN', cnpj:'123', phone:'556618', 
                     email:'pousadinha@email.com', address:address)
    #Act
    login(host)
    click_on 'Minha Pousada'
    #Assert
    expect(page).to have_content 'Sem quartos registrados'
    expect(page).not_to have_content 'Banheiro'
    expect(page).not_to have_content 'Vaga'
  end
  it 'successfully' do
    #Arrange
    host = User.create!(name: 'Lucas', email:'test@email.com', password:'password', host: true)
    address = Address.create!(street: 'Rua das ruas', number:'12', neighborhood:'centro', 
                              city:'São Paulo', state:'SP', cep:'15470-000')
    inn = host.create_inn!(name:'Pousadinha', company_name:'Pousadinha SN', cnpj:'123', 
                           phone:'556618', email:'pousadinha@email.com', address:address)
    inn.rooms.create!(number:'101', description:'Ótimo quarto com uma cama de casal, tv, varanda com
                      vista para a praia', double_beds:1, single_beds:0, capacity:2,
                      price_cents:100_00, bathrooms:1, kitchen:false)
    #Act
    login(host)
    click_on 'Minha Pousada'
    #Assert
    expect(page).not_to have_content 'Sem quartos registrados'
    expect(page).to have_content 'Quarto - 101'
    expect(page).to have_content 'Ótimo quarto com uma cama de casal, tv, varanda com vista para a praia'
    expect(page).to have_content 'Cozinha: Não'
    expect(page).to have_content 'Banheiros: 1'
    expect(page).to have_content 'Camas: 1 de Casal '
    expect(page).to have_content 'Comporta: 2 Hóspedes'
    expect(page).to have_content 'Diária: R$ 100,00'
  end
  it 'with more than one room' do
    #Arrange
    host = User.create!(name: 'Lucas', email:'test@email.com', password:'password', host: true)
    address = Address.create!(street: 'Rua das ruas', number:'12', neighborhood:'centro', 
                              city:'São Paulo', state:'SP', cep:'15470-000')
    inn = host.create_inn!(name:'Pousadinha', company_name:'Pousadinha SN', cnpj:'123', 
                           phone:'556618', email:'pousadinha@email.com', address:address)
    inn.rooms.create!(number:'101', description:'Ótimo quarto com uma cama de casal, tv, varanda com
                      vista para a praia', double_beds:1, single_beds:0, capacity:2, 
                      price_cents:100_00, bathrooms:0, kitchen:false)
    inn.rooms.create!(number:'102', description:'Ótimo quarto com cozinha, uma cama de casal e uma
                      de solteiro, tv, varanda com vista para a praia', double_beds:1, 
                      single_beds:2, capacity:3, price_cents:150_00, bathrooms:1, kitchen:true)
    #Act
    login(host)
    click_on 'Minha Pousada'
    #Assert
    expect(page).not_to have_content 'Sem quartos registrados'
    expect(page).to have_content 'Quarto - 102'
    expect(page).to have_content 'Ótimo quarto com cozinha, uma cama de casal e uma de solteiro, tv, varanda com vista para a praia'
    expect(page).to have_content 'Cozinha: Sim'
    expect(page).to have_content 'Banheiros: Banheiro compartilhado'
    expect(page).to have_content 'Camas: 1 de Casal 2 de Solteiro'
    expect(page).to have_content 'Comporta: 3 Hóspedes'
    expect(page).to have_content 'Diária: R$ 150,00'
  end
end