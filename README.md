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

## Endpoints
### URL: https://head-to-toe-be.herokuapp.com/api/v1 </br>

<hr>

#### GET `/medical_professionals`
The GET medical professionals endpoint accepts three parameters, none of which are required. Any combination of parameters is acceptable.  
Parameters:
  - `state` accepts any state, capitalized, not abbreviated. Will limit search results to specified state.  
  - `type` currently accepts: `doctor` and `mhp`. Will limit search results to doctors or mental health professionals.  
  - `vetted` boolean. Default is true. If `false` is passed will limit search results to unvetted resources.

Example response:   `/medical_professionals?state=Colorado&type=doctor` <br>
```
  {
  "data": {
    "id": null,
    "type": "vetted_professionals",
    "attributes": {
      "doctors": [
        {
          "id": 51,
          "first_name": "tiger",
          "last_name": "Gloom",
          "state": "Colorado",
          "city": "Curtland",
          "street": "958 Dave Plain",
          "unit": "Suite 526",
          "zip": "19384",
          "phone": "234-456-2244",
          "vetted": true,
          "specialties": [
            {
              "id": 13,
              "name": "stuff",
              "created_at": "2021-07-11T18:13:03.020Z",
              "updated_at": "2021-07-11T18:13:03.020Z"
            }
          ],
          "insurances": [
            {
              "id": 14,
              "name": "corrupted",
              "created_at": "2021-07-11T18:13:03.020Z",
              "updated_at": "2021-07-11T18:13:03.020Z"
            }
          ]
        },
        {
          "id": 151,
          "first_name": "mammoth",
          "last_name": "Zapdos",
          "state": "Colorado",
          "city": "New Jacinto",
          "street": "7401 Noah Points",
          "unit": "Suite 488",
          "zip": "19384",
          "phone": "234-456-2244",
          "vetted": true,
          "specialties": [
            {
              "id": 12,
              "name": "rem",
              "created_at": "2021-07-11T18:13:03.015Z",
              "updated_at": "2021-07-11T18:13:03.015Z"
            }
          ],
          "insurances": [
            {
              "id": 14,
              "name": "bad news",
              "created_at": "2021-07-11T18:13:03.020Z",
              "updated_at": "2021-07-11T18:13:03.020Z"
            }
          ]
        }
      ],
      "mhps": null
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

#### PATCH and DELETE `/medical_professionals/#id` </br> 
A successful update request will return 204 No Content </br> 
A request missing required params will return 422 Unprocessable Entity </br> 
A request missing an api key will return 401 Unauthorized </br> 

headers:
```
"api-key" : "your_api_key",
"Content-Type": "application/json"`, 
"Accept": "application/json"
```
Required params: "id", "profession"
Example body:
```
{
    "profession": "doctor"
}
```
