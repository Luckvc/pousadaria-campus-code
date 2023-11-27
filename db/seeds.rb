# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

host = User.create!(name: 'Lucas', email:'test@email.com', password:'password', host: true)
address = Address.create!(street: 'Rua das ruas', number:'12', neighborhood:'centro',
                          city:'São Paulo', state:'SP', cep:'15470-000')
inn = host.create_inn!(name:'Pousadinha', company_name:'Pousadinha SN', cnpj:'123',
                       phone:'556618', email:'pousadinha@email.com', address:address, pix:true, 
                       debit:true, credit:true, cash:true)
room = inn.rooms.create!(number:'101', description:'Ótimo quarto com uma cama de casal, tv,
                         varanda com vista para a praia', double_beds:1, single_beds:0,
                         capacity:2, price:100.00, bathrooms:1, kitchen:false)
room.custom_dates.create!(begin:1.days.from_now, end:5.days.from_now, price:200.00)
room.custom_dates.create!(begin:1.month.from_now, end:2.month.from_now, price:300.00)
customer = Customer.create!(name:'José', cpf:'123', email:'jose@email.com', password:'123456')
res = room.reservations.create!(check_in_date: 8.days.from_now, check_out_date: 12.days.from_now,
  guests:2, customer:customer)

host = User.create!(name: 'João', email:'joao@email.com', password:'password', host: true)
address = Address.create!(street: 'Rua das torres', number:'28', neighborhood:'centro',
  city:'Campinas', state:'SP', cep:'15470-000')
inn = host.create_inn!(name:'Safari', company_name:'Pousada Safari SN', cnpj:'456', phone:'223345',
  email:'pousadona@email.com', address:address, pix:true)
room_one = inn.rooms.create!(number:'Elefante', description:'Ótimo quarto com uma cama de casal', 
  double_beds:1, single_beds:0, capacity:2, price:100.00, bathrooms:1)
room_two = inn.rooms.create!(number:'Girafa', description:'Ótimo quarto com uma cama de solteiro', 
  double_beds:0, single_beds:1, capacity:1, price:200.00, bathrooms:1)

customer = Customer.create!(name:'Roberto', cpf:'123', email:'roberto@email.com', password:'123456')
res_one = room_one.reservations.create!(check_in_date: 2.days.ago, check_out_date: 12.days.from_now,
  guests:2, customer:customer, checked_in_datetime: 2.days.ago, status:'ongoing')
res_two = room_two.reservations.create!(check_in_date: 2.days.from_now, check_out_date: 5.days.from_now,
  guests:2, customer:customer)
res_three= room_two.reservations.create!(check_in_date: 8.days.from_now, check_out_date: 12.days.from_now,
  guests:2, customer:customer)