<!-- PROJECT SHIELDS -->
[![Contributors][contributors-shield]][contributors-url]
[![Issues][issues-shield]][issues-url]
<!-- PROJECT LOGO -->
<br/>

<p align="center">
  <a href="https://github.com/Head-To-Toe/headToToe-be">
    <img src="https://github.com/Head-To-Toe/headToToe-be/blob/main/docs/head_to_toe_official.png">
  </a>
  <p align="center">
    <a href="https://github.com/Head-To-Toe/headToToe-be/issues">Report Bug</a>
  </p>
</p>

<!-- TABLE OF CONTENTS -->
<details open="open">
  <summary>Table of Contents</summary>
  
  <ol>
    <li><a href="#about-the-project">About The Project</a></li>
    <li><a href="#getting-started">Getting Started</a></li>
    <li><a href="#endpoints">Endpoints</a></li>
    <li><a href="#roadmap">Roadmap</a></li>
    <li><a href="#contributing">Contributing</a></li>
    <li><a href="#contributors">Contributors</a></li>
  </ol>
  
</details>
<!-- ABOUT THE PROJECT -->

## About The Project
Head to Toe is a publically sourced LGBTQ+ health professional referral application. Find peer-acknowledged doctor and mental health professionals care across the U.S. Or, submit a resource for review and help others find care near them.
<br> 
<br>
The Head to Toe backend is an API that aggregates doctor and mental health professional data to its partner frontend application. The frontend repo is located [here](https://github.com/Head-To-Toe/headToToe).

### Built With
* Core: [RubyOnRails](https://rubyonrails.org/), [CircleCI](https://circleci.com/), [Fast JSON API](https://github.com/Netflix/fast_jsonapi), and [Rack Throttle](https://github.com/dryruby/rack-throttle)
* Testing: [RSpec](https://rspec.info/), [Simplecov](https://github.com/simplecov-ruby/simplecov), [Capybara](https://github.com/teamcapybara/capybara), [Shoulda-Matchers](https://github.com/thoughtbot/shoulda-matchers), [Factory Bot](https://github.com/thoughtbot/factory_bot), and [Faker](https://github.com/faker-ruby/faker)

## Getting Started
1. Fork this repo
2. Clone down your fork
   ```sh
   git clone git@github.com:your-username/headToToe-be.git
   ```
3. Install dependencies
   ```sh
   bundle install
   ```
4. Create PostgreSQL database
   ```sh
   rake db:{create,migrate,seed}
   ```
5. Initialize rails server
   ```sh
   rails s
   ```
<!-- Endpoints -->
## Endpoints
*Utilize [Postman](https://www.postman.com/) or localhost:3000 to call endpoints:*

  ### Public URL: https://head-to-toe-be.herokuapp.com/api/v1 </br>

<hr>

#### GET `/medical_professionals`
The GET medical professionals endpoint accepts three parameters, none of which are required. Any combination of parameters is acceptable. The public endpoint is limited to 60 GET requests a minute. <br>
Parameters:
  - `state` accepts any state, capitalized, not abbreviated. Will limit search results to specified state.  
  - `type` currently accepts: `doctor` and `mhp`. Will limit search results to doctors or mental health professionals.  
  - `vetted` boolean. Default is true. If `false` is passed will limit search results to unvetted resources.

You can experiment with this endpoint with Postman here: <br>
[![Run in Postman](https://run.pstmn.io/button.svg)](https://god.gw.postman.com/run-collection/15450986-511ccaee-abcb-414e-b9b9-462c63b8b49d?action=collection%2Ffork&collection-url=entityId%3D15450986-511ccaee-abcb-414e-b9b9-462c63b8b49d%26entityType%3Dcollection%26workspaceId%3Dcf4ab17c-554f-431e-b408-3b64b807b76e) <br>

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
The POST medical professionals endpoint accepts 11-12 possible parameters. The public endpoint is limited to 6 POST requests a minute.
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
The PATCH & DELETE medical professionals endpoints require 2 parameters; profession and id. The public endpoint is limited to 10 PATCH and 30 DELETE requests a minute. <br>
A successful update request will return 204 No Content </br> 
A request missing required params will return 422 Unprocessable Entity </br> 
A request missing an api key will return 401 Unauthorized </br> 

headers:
```
"api-key" : "your_api_key",
"Content-Type": "application/json"`, 
"Accept": "application/json"
```
Required params: "profession" and /id <br>
Example body:
```
{
    "profession": "doctor"
}
```
## Roadmap
The team utilized a [github project board](https://github.com/orgs/Head-To-Toe/projects/1) to organize project issues and coordinate workflow across 5 members and 2 repositories over a 3 week stretch.
See the [open issues](https://github.com/Head-To-Toe/headToToe-be/issues) for a list of proposed features (and known issues).

<!-- CONTRIBUTING -->
## Contributing
Contributions are what make the open source community such an amazing place to be learn, inspire, and create. Any contributions you make are **greatly appreciated**. We hope that users provide input to improve their experience and that of others.

###### Versions
- Ruby 3.0.0
- Rails 6.1.4
  
###### Making a Contribution
1. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
2. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
3. Push to the Branch (`git push origin feature/AmazingFeature`)
4. Open a Pull Request from your fork to this main repo

<!-- CONTRIBUTORS -->
### Contributors
##### Backend Team
Austin Andrade [![Github][github-shield]][austin-github-url] [![LinkedIn][linkedin-shield]][austin-linkedin-url] [![Email][email-shield]][austin-email-url] <br>
Aidan McGuire [![Github][github-shield]][aidan-github-url] [![LinkedIn][linkedin-shield]][aidan-linkedin-url] [![Email][email-shield]][aidan-email-url] <br>
##### Frontend Team
Angela Battillo [![Github][github-shield]][angie-github-url] [![LinkedIn][linkedin-shield]][angie-linkedin-url] [![Email][email-shield]][angie-email-url] <br>
Marceline Ball [![Github][github-shield]][marceline-github-url] [![LinkedIn][linkedin-shield]][marceline-linkedin-url] [![Email][email-shield]][marceline-email-url] <br>
Riley Martin [![Github][github-shield]][riley-github-url] [![LinkedIn][linkedin-shield]][riley-linkedin-url] [![Email][email-shield]][riley-email-url] <br>
<!-- CONTACT -->

<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/Head-To-Toe/headToToe-be.svg?style=for-the-badge
[contributors-url]: https://github.com/Head-To-Toe/headToToe-be/graphs/contributors
[stars-url]: https://github.com/Head-To-Toe/headToToe-be/stargazers
[issues-shield]: https://img.shields.io/github/issues/Head-To-Toe/headToToe-be?style=for-the-badge
[issues-url]: https://github.com/Head-To-Toe/headToToe-be/issues

<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=555
[github-shield]: https://img.shields.io/badge/-Github-black.svg?style=for-the-badge&logo=github&colorB=555
[email-shield]: https://img.shields.io/badge/-Email-black.svg?style=for-the-badge&logo=gmail&colorB=555

[austin-github-url]: https://github.com/austinandrade/
[aidan-github-url]: https://github.com/A-McGuire
[angie-github-url]: https://github.com/battan40
[marceline-github-url]: https://github.com/MarcelineBall
[riley-github-url]: https://github.com/RMartin0717


[austin-email-url]: mailto:austinmandrade@gmail.com?subject=Hello%20Austin
[aidan-email-url]: mailto:aidanmcguire211@gmail.com?subject=Hello%20Aidan
[angie-email-url]: mailto:angela.battillo@gmail.com?subject=Hello%20Angie
[marceline-email-url]: mailto:marcelineball@gmail.com?subject=Hello%20Marceline
[riley-email-url]: mailto:riley.willow@gmail.com?subject=Hello%20Riley


[austin-linkedin-url]: https://www.linkedin.com/in/austinandrade/
[aidan-linkedin-url]: https://www.linkedin.com/in/aidanmcguire/
[angie-linkedin-url]: https://www.linkedin.com/in/angela-battillo/
[marceline-linkedin-url]: https://www.linkedin.com/in/marceline-ball/
[riley-linkedin-url]: https://www.linkedin.com/in/rmartin0717/
