require 'rails_helper'

describe 'User registers an Inn' do
  it 'and it is authenticated' do
    #Arrange
    #Act
    visit new_inn_path
    #Assert
    expect(current_path).to eq new_user_session_path
  end
  it 'Sucessfully' do
    
  end
end