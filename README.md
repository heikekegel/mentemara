# MenteMara

Mentemara is a Ruby on Rails application for managing behavioral health intake submissions.

The name **MenteMara** is inspired by the Spanish phrase *“mente maravillosa”*, meaning *“marvelous mind.”*  
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

- Ruby on Rails 8
- SQLite
- Hotwire (Turbo + Stimulus)
- JavaScript Fetch API
- RSpec
- RuboCop
- Brakeman
- bundler-audit

---

## 🛠 Setup & Installation

### Clone the repo

git clone https://github.com/heikekegel/mentemara.git
cd mentemara

### Install dependencies

bundle install

### Setup database

rails db:prepare

### Run server

rails server

Open:
http://localhost:3000

---

## 🧪 Run Tests

bundle exec rspec

---

## 🔍 Code Quality & Security

RuboCop:
bundle exec rubocop

Brakeman:
bundle exec brakeman

Bundler Audit:
bundle exec bundler-audit check --update

---

## 🧠 Concepts

CRUD = Create, Read, Update, Delete

RESTful Routes map HTTP requests to controller actions.

MVC:
- Model → data & validation
- View → UI
- Controller → logic

ActiveRecord lets you interact with DB via Ruby.

---

## 🔁 Delete Flow

Click Delete → Stimulus → fetch DELETE → Rails destroy → JSON → row removed

---

## 👩‍💻 Author

Heike Kegel
