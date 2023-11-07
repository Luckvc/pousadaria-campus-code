require 'rails_helper'

RSpec.describe CustomDate, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'false when begin date is empty' do
        #Arrange
        room = Room.new(number:'1', description:'Ó',
                        double_beds:1, single_beds:1, capacity:2, price_cents:125_00,
                        bathrooms:1, kitchen:false)
        cd = room.custom_dates.build(begin:'', end:'2024-01-30', price_cents:300_00)
        #Act
        result = cd.valid?
        #Assert
        expect(result).to eq false
      end
      it 'false when end date is empty' do
        #Arrange
        room = Room.new(number:'1', description:'Ó',
                        double_beds:1, single_beds:1, capacity:2, price_cents:125_00,
                        bathrooms:1, kitchen:false)
        cd = room.custom_dates.build(begin:'2024-01-30', end:'', price_cents:300_00)
        #Act
        result = cd.valid?
        #Assert
        expect(result).to eq false
      end
      it 'false when price is empty' do
        #Arrange
        room = Room.new(number:'1', description:'Ó',
                        double_beds:1, single_beds:1, capacity:2, price_cents:125_00,
                        bathrooms:1, kitchen:false)
        cd = room.custom_dates.build(begin:'2024-01-30', end:'2024-01-30', price_cents:'')
        #Act
        result = cd.valid?
        #Assert
        expect(result).to eq false
      end
    end
  end
end
