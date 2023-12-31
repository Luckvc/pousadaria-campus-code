require 'rails_helper'

describe 'User can create a host account' do
  it 'sucessfully' do
    #Arrange
    #Act
    visit root_path
    click_on 'Login Dono de Pousada'
    click_on 'Criar Conta'
    fill_in 'Nome', with: 'João'
    fill_in 'E-mail', with: 'example@email.com'
    fill_in 'Senha', with: 'password'
    fill_in 'Confirme sua senha', with: 'password'
    click_on 'Criar Conta'
    #Assert
    expect(User.last.email).to eq 'example@email.com'
    expect(User.last.host).to eq true
    expect(User.last.name).to eq 'João'
    expect(page).to have_content 'Cadastrar Pousada'
    expect(page).to have_content 'Minha Pousada'
    expect(page).not_to have_content 'Minhas Reservas'
    expect(page).to have_content 'Sair'
  end
  it 'and logs-in' do
    #Arrange
    user = User.create!(name: 'Lucas', email:'test@email.com', password:'password', host: true)
    #Act
    visit root_path
    click_on 'Login Dono de Pousada'
    fill_in 'E-mail', with: user.email
    fill_in 'Senha', with: user.password
    click_on 'Entrar'
    #Assert
    expect(User.last.email).to eq 'test@email.com'
    expect(page).to have_content 'Cadastrar Pousada'
    expect(page).to have_content 'Sair'
    expect(User.last.host).to eq true
  end
  it 'and is locked to new Inn page' do
    #Arrange
    user = User.create!(name: 'Lucas', email:'test@email.com', password:'password', host: true)
    #Act
    login_as(user, scope: :user)

    visit root_path

    #Assert
    expect(current_path).to eq new_inn_path
  end
end