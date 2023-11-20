require 'rails_helper'

describe 'Host registers an Inn' do
  it 'and it is authenticated' do
    #Arrange
    #Act
    visit new_inn_path
    #Assert
    expect(current_path).to eq new_user_session_path
  end
  it 'and sees register page' do
    #Arrange
    user = User.create!(name: 'Lucas', email:'test@email.com', password:'password', host: true)
    #Act
    login_as(user, scope: :user)
    visit root_path
    click_on 'Minha Pousada'
    #Assert
    expect(current_path).to eq new_inn_path
    expect(page).to have_content 'Cadastrar Pousada'
    expect(page).to have_content 'Dados da Empresa'
    expect(page).to have_content 'CNPJ'
    expect(page).to have_content 'Razão Social'
    expect(page).to have_content 'Nome Fantasia'
    expect(page).to have_content 'Telefone'
    expect(page).to have_content 'E-mail'
    expect(page).to have_content 'Endereço da Pousada'
    expect(page).to have_content 'Logradouro'
    expect(page).to have_content 'Cidade'
    expect(page).to have_field 'Bairro'
    expect(page).to have_content 'Número'
  end
  it 'successfully' do
    #Arrange
    user = User.create!(name: 'Lucas', email:'test@email.com', password:'password', host: true)
    #Act
    login_as(user, scope: :user)
    visit root_path
    click_on 'Minha Pousada'
    fill_in 'Nome Fantasia', with: 'Pousadinha'
    fill_in 'Razão Social', with: 'Pousadinha lta'
    fill_in 'CNPJ', with: '123456'
    fill_in 'Telefone', with: '456123'
    fill_in 'E-mail', with: 'pousadinha@gmail.com'
    fill_in 'Políticas da Pousada', with: 'Não pode ser triste'
    fill_in 'Horário de Check-in', with: '14:00'
    fill_in 'Horário de Check-out', with: '12:00'
    check 'Pets'
    check 'Pix'
    check 'Cartão de Crédito'
    check 'Cartão de Débito'
    check 'Dinheiro'
    fill_in 'Logradouro', with: 'Rua da Pousadinha'
    fill_in 'Número', with: '13'
    fill_in 'Bairro', with: 'Centro'
    fill_in 'Cidade', with: 'Palestina'
    fill_in 'Estado', with: 'SP'
    fill_in 'CEP', with: '15470-000'
    click_on 'Cadastrar'
    #Assert
    expect(page).to have_content 'Pousadinha'
    expect(page).to have_content 'CNPJ: 123456'
    expect(page).to have_content 'Telefone: 456123'
    expect(page).to have_content 'E-mail: pousadinha@gmail.com'
    expect(page).to have_content 'Endereço: Rua da Pousadinha, 13 - Centro, Palestina - SP'
    expect(page).to have_content 'CEP: 15470-000'
    expect(page).to have_content 'Horário de Check-in: 14:00'
    expect(page).to have_content 'Horário de Check-out: 12:00'
    expect(page).to have_content 'Políticas: Não pode ser triste'
    expect(page).to have_content 'Meios de Pagamento: Pix Cartão de Crédito Cartão de Débito Dinheiro'
  end
  it 'unsuccessfully' do
    #Arrange
    user = User.create!(name: 'Lucas', email:'test@email.com', password:'password', host: true)
    #Act
    login_as(user, scope: :user)
    visit root_path
    click_on 'Minha Pousada'
    fill_in 'Nome Fantasia', with: ''
    fill_in 'Razão Social', with: ''
    click_on 'Cadastrar'
    #Assert
    expect(page).to have_content 'Pousada não cadastrada'
    expect(page).to have_content 'Nome Fantasia não pode ficar em branco'
    expect(page).to have_content 'Razão Social não pode ficar em branco'
    expect(page).to have_content 'CNPJ não pode ficar em branco'
  end
end