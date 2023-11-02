require 'rails_helper'

describe 'User can create an account' do
  it 'sucessfully' do
    #Arrange
    #Act
    visit root_path
    click_on 'Entrar'
    click_on 'Criar Conta'
    fill_in 'E-mail', with: 'example@email.com'
    fill_in 'Senha', with: 'password'
    fill_in 'Confirme sua senha', with: 'password'
    click_on 'Criar Conta'
    #Assert
    expect(User.last.email).to eq 'example@email.com'
    expect(page).to have_content 'Você realizou seu registro com sucesso'
    expect(page).to have_content 'Sair'
    expect(current_path).to eq root_path 
  end
  it 'and logs-in' do
    #Arrange
    User.create!(name: 'Lucas', email:'test@email.com', password:'password')
    #Act
    visit root_path
    click_on 'Entrar'
    within ('form') do
      fill_in 'E-mail', with: 'test@email.com'
      fill_in 'Senha', with: 'password'
      click_on 'Entrar'
    end
    #Assert
    expect(User.last.email).to eq 'test@email.com'
    expect(page).to have_content 'Login efetuado com sucesso.'
    expect(page).to have_content 'Sair'
    expect(current_path).to eq root_path 
  end
end