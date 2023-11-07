require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'false when name is empty' do
        #Arrange
        user = User.new(name: '', email:'test@email.com', password:'password', host: true)
        #Act
        result = user.valid?
        #Assert
        expect(result).to eq false
      end
    end
  end
end
