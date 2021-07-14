# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions </br>


* ...

## Endpoints
### URL: https://head-to-toe-be.herokuapp.com/api/v1 </br>

<hr>

#### GET `/medical_professionals?type=doctor&state=South Dakota`   
The medical professionals endpoint current has two required parameters: type, and state.  
The type parameter accepts two values: doctors and mhp ( mental health professionals ).  
Currently the state parameter only accepts capitalized spelled out states.  

Example response:   
```
  {
    "data": {
        "id": null,
        "type": "doctor",
        "attributes": {
            "list": [
                {
                    "id": 80,
                    "first_name": "gnat",
                    "last_name": "Slowpoke",
                    "state": "South Dakota",
                    "city": "Daphnechester",
                    "street": "4493 Marvin Extension",
                    "unit": "Suite 249",
                    "zip": "19384",
                    "phone": "234-456-2244",
                    "vetted": true,
                    "specialties": [
                        {
                            "id": 2,
                            "name": "Orc"
                        },
                        {
                            "id": 4,
                            "name": "Sylvan"
                        },
                        {
                            "id": 1,
                            "name": "Undercommon"
                        }
                    ],
                    "insurances": [
                        {
                            "id": 14,
                            "company": "Schinner, Kreiger and Stokes"
                        },
                        {
                            "id": 4,
                            "company": "Yundt-Cronin"
                        },
                        {
                            "id": 5,
                            "company": "Herman-Bogan"
                        }
                    ]
                },
                {
                    "id": 92,
                    "first_name": "reindeer",
                    "last_name": "Psyduck",
                    "state": "South Dakota",
                    "city": "Lake Nickychester",
                    "street": "612 Edmundo Burg",
                    "unit": "Suite 461",
                    "zip": "19384",
                    "phone": "234-456-2244",
                    "vetted": true,
                    "specialties": [
                        {
                            "id": 8,
                            "name": "Deep Speech"
                        },
                        {
                            "id": 1,
                            "name": "Undercommon"
                        }
                    ],
                    "insurances": [
                        {
                            "id": 10,
                            "company": "Stamm-Renner"
                        },
                        {
                            "id": 11,
                            "company": "Reichel Group"
                        }
                    ]
                }
            ]
        }
    }
}
```

<hr>

#### GET `/medical_professionals?type=mhp&state=Massachusetts`   

Example response:   
```
{
    "data": {
        "id": null,
        "type": "mhp",
        "attributes": {
            "list": [
                {
                    "id": 62,
                    "first_name": "panda",
                    "last_name": "Dodrio",
                    "state": "Massachusetts",
                    "city": "Hamillside",
                    "street": "32521 Green Freeway",
                    "unit": "Apt. 942",
                    "zip": "10385",
                    "phone": "234-456-2244",
                    "vetted": true,
                    "cost": "$123-150",
                    "specialties": [
                        {
                            "id": 3,
                            "name": "Celestial"
                        }
                    ],
                    "insurances": [
                        {
                            "id": 8,
                            "company": "O'Keefe-Price"
                        },
                        {
                            "id": 9,
                            "company": "Conn-Erdman"
                        }
                    ]
                },
                {
                    "id": 141,
                    "first_name": "beaver",
                    "last_name": "Nidoqueen",
                    "state": "Massachusetts",
                    "city": "North Nolan",
                    "street": "95980 Vandervort Keys",
                    "unit": "Suite 347",
                    "zip": "10385",
                    "phone": "234-456-2244",
                    "vetted": true,
                    "cost": "$123-150",
                    "specialties": [
                        {
                            "id": 2,
                            "name": "Orc"
                        },
                        {
                            "id": 11,
                            "name": "Abyssal"
                        }
                    ],
                    "insurances": [
                        {
                            "id": 5,
                            "company": "Herman-Bogan"
                        }
                    ]
                }
            ]
        }
    }
}
```

<hr>

#### POST `/medical_professionals` </br> 
A successful create request will return 201 Created </br> 
A request missing required params will return 422 Unprocessable Entity </br> 
A request missing an api key will return 401 Unauthorized </br> 

headers:
```
"api-key" : "your_api_key",
"Content-Type": "application/json"`, 
"Accept": "application/json"
```
Required params: "first_name", "last_name", "profession", and "insurance"
Example body: ( To add a doctor change the `profession` value to `doctor` and omit the `cost` field )
```
{
    first_name: "FirstName",
    last_name: "LastName",
    street: "123 Street",
    unit: "123 Unit",
    city: "Denver",
    state: "Colorado",
    zip: "12345",
    phone: "1234567890",
    cost: "$100-120",
    profession: "mhp",
    insurance: ["BigMoney", "OtherBigMoney"],
    specialties: ["Stuff", "Things", "Problems"]
}
```

<hr>

#### PATCH `/medical_professionals/#id` </br> 
A successful update request will return 204 No Content </br> 
A request missing required params will return 422 Unprocessable Entity </br> 
A request missing an api key will return 401 Unauthorized </br> 

headers:
```
"api-key" : "your_api_key",
"Content-Type": "application/json"`, 
"Accept": "application/json"
```
Required params: "id", "first_name", and "last_name"
Example body:
```
{
    "id": "1",
    "first_name": "cicada",
    "last_name": "Charizard"
}
```