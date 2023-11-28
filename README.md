# Pousadaria
---
## Introduction
Project developed as part of TreinaDev 11 at Campus Code, with a focus on Test-Driven Development using Ruby on Rails.

The application is divided into two main features: one designed for inn owners, providing tools for efficient management of their establishments. The other tailored for user clients, allowing them to search, view details about inns and their rooms, check availability, and make room reservations.


---
## API
## List of Active Inns


Method: `GET`
Endpoint: `/api/v1/inns`

Returns a list of active inns registered on the application. Optionally, you can provide a query parameter to search an inn name.

> Optional Parameters:
> 
> - ```query:``` Text to use as the inn name filter

Request:

`/api/v1/inns/?query=Safari`

Return
```
{
    "id": 2,
    "name": "Safari",
    "company_name": "Pousada Safari SN",
    "cnpj": "456",
    "phone": "223345",
    "email": "pousadona@email.com",
    "address_id": 2,
    "user_id": 2,
    "pets": false,
    "active": true,
    "policies": null,
    "check_in_time": "14:00",
    "check_out_time": "12:00",
    "pix": true,
    "credit": false,
    "debit": false,
    "cash": false
}
```

## Inn Details

Method: `GET`
Endpoint: `/api/v1/inns/:inn_id`

With an inn's id, get all the details of an inn. 

> Required Parameters:
>
> - ```inn_id:``` Inn id

Request:

`/api/v1/inns/1`

Return:

```
{
    "id": 1,
    "name": "Pousadinha",
    "phone": "556618",
    "email": "pousadinha@email.com",
    "address_id": 1,
    "user_id": 1,
    "pets": false,
    "active": true,
    "policies": null,
    "check_in_time": "14:00",
    "check_out_time": "12:00",
    "pix": true,
    "credit": true,
    "debit": true,
    "cash": true,
    "score": ""
}
```

## List of Rooms in an Inn

Method: `GET`
Endpoint: `/api/v1/inns/inn_id/rooms`

Using the inn's id, you can request a list with the available rooms.

> Required Parameters:
>
> - ```inn_id:``` Inn id

Request:

`/api/v1/inns/1/rooms`

Return:

```
{
        "id": 1,
        "number": "101",
        "description": "Ótimo quarto com uma cama de casal, tv, 
                        varanda com vista para a praia",
        "double_beds": 1,
        "single_beds": 0,
        "capacity": 2,
        "price": "100.0",
        "bathrooms": 1,
        "kitchen": false,
        "inn_id": 1,
        "active": true,
        "dimension": 0,
        "balcony": false,
        "air": false,
        "tv": false,
        "wardrobe": false,
        "safe": false,
        "accessible": false
    }
```

## Availability Check

Method: `GET`
Endpoint: `/api/v1/rooms/:room_id/available/?parameters`

By providing a room id, check-in date, check-out date, and the number of guests, it is possible to check availability for booking.

If the room is available, the reservation total will be returned along with all the reservation information. If the room is not available, an empty json will be returned.

> Required Parameters:
> 
> - ```room_id:``` id of the room to be reserved
> - ```check_in_date:``` Check-in date in yyyy-mm-dd format
> - ```check_out_date:``` Check-out date in yyyy-mm-dd format
> - ```guests:``` Number of guests for the reservation


Request:

`/api/v1/rooms/1/available/?check_in_date=2024-02-15&check_out_date=2024-02-22&guests=2`

Return:

```
{
    "check_in_date": "2024-02-15",
    "check_out_date": "2024-02-22",
    "guests": 2,
    "room_id": 1,
    "total": 700
}
```
