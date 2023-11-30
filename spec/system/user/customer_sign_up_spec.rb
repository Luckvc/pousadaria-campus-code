require 'rails_helper'

describe 'Customer can create an account' do
  it 'sucessfully' do
    #Arrange
    #Act
    visit root_path
    click_on 'Entrar'
    click_on 'Criar Conta'
    fill_in 'Nome', with: 'João'
    fill_in 'CPF', with: '454288'
    fill_in 'E-mail', with: 'example@email.com'
    fill_in 'Senha', with: 'password'
    fill_in 'Confirme sua senha', with: 'password'
    click_on 'Criar Conta'
    #Assert
    expect(Customer.last.email).to eq 'example@email.com'
    expect(Customer.last.name).to eq 'João'
    expect(Customer.last.cpf).to eq '454288'
    expect(page).to have_content 'Você realizou seu registro com sucesso'
    expect(page).not_to have_content 'Minha Pousada'
    expect(page).to have_content 'Minhas Reservas'
    expect(page).to have_content 'Sair'
    expect(current_path).to eq root_path 
  end
  it 'insucessfully' do
    #Arrange
    #Act
    visit root_path
    click_on 'Entrar'
    click_on 'Criar Conta'
    fill_in 'Nome', with: ''
    fill_in 'E-mail', with: 'example@email.com'
    fill_in 'Senha', with: 'password'
    fill_in 'Confirme sua senha', with: 'password'
    click_on 'Criar Conta'
    #Assert
    expect(page).to have_content 'Não foi possível salvar usuário'
    expect(page).to have_content 'Nome não pode ficar em branco'
  end
  it 'and logs-in' do
    #Arrange
    user = Customer.create!(name: 'Lucas', email:'test@email.com', password:'password')
    #Act
    visit root_path
    click_on 'Entrar'
    fill_in 'E-mail', with: user.email
    fill_in 'Senha', with: user.password
    within ('div form') do
      click_on 'Entrar'
    end
    #Assert
    expect(User.last.email).to eq 'test@email.com'
    expect(page).to have_content 'Login efetuado com sucesso.'
    expect(page).to have_content 'Sair'
    expect(current_path).to eq root_path 
  end
end