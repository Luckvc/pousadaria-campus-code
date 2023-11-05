require 'rails_helper'

describe 'User views room' do
  it 'with no room registered' do
    #Arrange
    host = User.create!(name: 'Lucas', email:'test@email.com', password:'password', host: true)
    address = Address.create!(street: 'Rua das ruas', number:'12', neighborhood:'centro', city:'São Paulo', state:'SP',
                              cep:'15470-000')
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
    address = Address.create!(street: 'Rua das ruas', number:'12', neighborhood:'centro', city:'São Paulo', state:'SP',
                              cep:'15470-000')
    inn = host.create_inn!(name:'Pousadinha', company_name:'Pousadinha SN', cnpj:'123', phone:'556618', 
                           email:'pousadinha@email.com', address:address)
    room = inn.rooms.create!(number:'101', description:'Ótimo quarto com cozinha, uma cama de casal, tv, varanda com vista para a praia', 
                            double_beds:1, single_beds:0, capacity:2, price_cents:100_00, bathrooms:1, kitchen:false)
    #Act
    login(host)
    click_on 'Minha Pousada'
    #Assert
    expect(page).not_to have_content 'Sem quartos registrados'
    expect(page).to have_content 'Quarto - 101'
    expect(page).to have_content 'Ótimo quarto com cozinha, uma cama de casal, tv, varanda com vista para a praia'
    expect(page).to have_content 'Cozinha: Não'
    expect(page).to have_content 'Banheiros: 1'
    expect(page).to have_content 'Camas: 1 de Casal '
    expect(page).to have_content 'Comporta: 2 Hóspedes'
  end

end