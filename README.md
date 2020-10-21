# Adopt Don't Shop
## BE Mod 2 Weeks 2 & 3 Paired Project
### Turing School Project [Background and Instructions](https://github.com/turingschool-examples/adopt_dont_shop_paired)
#### Includes:
- Learning goals
- Requirements
- User stories
- Rubric

## Table of Contents

- [Introduction](#introduction)
- [Demo](#demo)
- [Features](#features)
- [Team Members](#team-members)
- [Adherence to Learning Goals](#adherence-to-learning-goals)
- [Schema](#schema)

### Introduction

__Adopt Don't Shop__ was the project assigned to the 2008 Back End cohort during [Module 2](https://backend.turing.io/module2/). Students were put into pairs and tasked with creating a fictitious pet adoption platform.

The adoption platform is designed to house and manipulate data for pets, shelters, users, applications, and reviews. Visitors can apply to _adopt multiple pets_ and _write reviews_ for shelters. The site provided functionality for an _admin user_ to _approve_ or _reject_ individual pets on a user's application, which results in _acceptance_ or _rejection_ of the application.

Statistics were another aspect of the platform and included the _average rating_ of all a user's reviews, _count of pets_ at an individual shelter, along with the _average review rating_ for a shelter and _number of applications_ for a shelter.

#### Demo
The app is deployed to Heroku [here](https://hidden-journey-13910.herokuapp.com/).

### Features
- Ruby 2.5.3
- Rails 5.2.4.3
- PostgreSQL
- Heroku
- ActiveRecord
- Gems
    - [`rspec-rails`](https://github.com/rspec/rspec-rails): testing suite
    - [`capybara`](https://github.com/teamcapybara/capybara): gives tools for feature testing
    - [`launchy`](http://www.launchy.net/): allows for `save_open_page` to see live version of browser
    - [`simplecov`](https://github.com/simplecov-ruby/simplecov): tracks test coverage
    - [`shoulda-matchers`](https://github.com/thoughtbot/shoulda-matchers): simplifies testing syntax

### Team Members

Jesse Mellinger - [Github](https://github.com/JesseMellinger)

Kiera Allen - [Github](https://github.com/KieraAllen)

### Adherence to Learning Goals

#### Rails

We used the **MVC design pattern** to organize our code, working to include appropriate logic within models, views, and controllers.
- **Models** - our models were structures to house all our raw data logic, such as calculations and filtering or manipulating data without altering it.
- **Views** - our views presented the data without much logic, using instance variables from our controllers along with methods from our models and the occasional conditional statement.
- **Controllers** - after completing the user stories, we reviewed our controllers to confirm that there was little data manipulation, making changes and creating model instance methods as needed.
     
The following is an example of a change we implemented to adhere to MVC:

Controller BEFORE
```
class ApplicationsController < ApplicationController

  def show
    @application = Application.find(params[:id])

    if !params[:search].nil?
      @search_results = Pet.where('lower(name) like ?', "%#{params[:search].downcase}%")
    else
      @search_results = Pet.where(name: params[:search])
    end
  end
end
```
Controller AFTER
```
class ApplicationsController < ApplicationController

  def show
    @application = Application.find_application(params[:id])
    @search_results = Pet.find_all_pets_by_name(params[:search])
  end
end
```
- We moved the conditional block from the controller and created a class method in our Pet model using a ternary operator (a one-line `if` statement).

Model AFTER
```
class Pet < ApplicationRecord
  def self.find_all_pets_by_name(name)
    name ? Pet.where('lower(name) like ?', "%#{name.downcase}%" : Array.new
  end
end
```
As requested by specific user stories, we used **flash messages** to alert a user to an error or missing information.

#### ActiveRecord

When creating queries that manipulated data in our models (e.g., calculating, selecting, filter, and ordering), we utilized **ActiveRecord** methods, first creating SQL queries to help us form the final ActiveRecord query structure.

#### Databases
Our database relationships are as follows:
- Shelter class:
    - `has_many :pets`
    - `has_many :reviews`

- User class:
    - `has_many :reviews`
    - `has_many :applications`

- Review class:
    - `belongs_to :shelter`
    - `belongs_to :user`

- Pet class:
    - `belongs_to :shelter`
    - `has_many :pet_applications`
    - `has_many :applications, through: :pet_applications`

- Application class:
    - `belongs_to :user`
    - `has_many :pet_applications`
    - `has_many :pets, through: :pet_applications`
    
- PetApplication class:
    - `belongs_to :pet`
    - `belongs_to :application`

#### Testing and Debugging

We started by writing integrative **feature tests** utilizing **sad path** testing, subsequently creating unit tests when we decided we needed a model _class_ or _instance_ method. We wrote additional **model tests** for validations and relationships.

_Test Coverage_

![adopt-dont-shop-coverage](https://user-images.githubusercontent.com/46658858/96789889-2a055b80-13b3-11eb-91ac-f88471ee4937.png)

#### Web Applications

Throughout our construction of the app, we implemented proper **Representational State Transfer** style by confirming our routes contained the appropriate HTTP verbs, paths, and controllers/actions. There were only a couple examples of non-ReSTful routes that were created before we started this project.

### Schema
![Adopt Don't Shop Schema](https://user-images.githubusercontent.com/46658858/96787905-cc234480-13af-11eb-9821-672cff59e689.png)
