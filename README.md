# Mentemara

Mentemara is a Ruby on Rails application for managing behavioral health intake submissions.

The name **Mentemara** is inspired by the Spanish phrase *“mente maravillosa”*, meaning *“marvelous mind.”*  
It reflects the purpose of the application: supporting mental well-being by providing a simple, structured way to capture and manage intake information with care and clarity.

---

## 🚀 Features

- Create new intake submissions
- View all submissions in a structured table
- Edit existing submissions
- Delete submissions dynamically (without page reload)
- Input validation for required fields and phone format

---

## 🧱 Tech Stack

- **Ruby on Rails 8**
- **SQLite** (development & test database)
- **Hotwire**
  - **Turbo** – faster navigation without full page reloads
  - **Stimulus** – lightweight JavaScript for interactivity
- **JavaScript (Fetch API)** – used for async delete requests
- **RSpec** – testing framework
- **RuboCop** – code quality and linting
- **Brakeman** – security vulnerability scanner
- **bundler-audit** – dependency vulnerability checker

---

## 🧠 Key Concepts Used

### CRUD Operations

CRUD stands for:
- **Create** – add a new intake
- **Read** – view existing intakes
- **Update** – edit an intake
- **Delete** – remove an intake

---

### RESTful Routes

Rails uses RESTful routing to map HTTP requests to controller actions:

| HTTP Verb | Route              | Action   |
|----------|--------------------|----------|
| GET      | /intakes           | index    |
| GET      | /intakes/new       | new      |
| POST     | /intakes           | create   |
| GET      | /intakes/:id       | show     |
| GET      | /intakes/:id/edit  | edit     |
| PATCH    | /intakes/:id       | update   |
| DELETE   | /intakes/:id       | destroy  |

---

### MVC Architecture

- **Model (ActiveRecord)**  
  Handles data and validations (e.g., Intake model)

- **View (ERB templates)**  
  Displays data to the user

- **Controller**  
  Processes requests and coordinates between model and view

---

### ActiveRecord

ActiveRecord is Rails’ ORM (Object Relational Mapper), which allows interaction with the database using Ruby objects instead of raw SQL.

Example:

```ruby
Intake.create!(valid_attributes)