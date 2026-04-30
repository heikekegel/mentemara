# MenteMara

MenteMara is a Ruby on Rails application for managing behavioral health intake submissions.

The name **MenteMara** is inspired by the Spanish phrase *“mente maravillosa”*, meaning *“marvelous mind.”*  
It reflects the purpose of the application: supporting mental well-being by providing a simple, structured way to capture and manage intake information with care and clarity.

---

## 🚀 Features

- Create new intake submissions
- View all submissions in a structured table
- View individual intake details
- Edit existing submissions
- Delete submissions dynamically without a full page reload
- Input validation for required fields
- Phone number format validation
- Model specs and request specs with RSpec
- Code quality checks with RuboCop
- Security checks with Brakeman and bundler-audit

---

## 🧱 Tech Stack

- **Ruby on Rails 8**
- **SQLite** for development and test database
- **Hotwire**
  - **Turbo** for faster navigation and form handling
  - **Stimulus** for lightweight JavaScript behavior
- **JavaScript Fetch API** for asynchronous delete requests
- **ActiveRecord** for database interaction
- **RSpec** for automated testing
- **RuboCop** for code quality and linting
- **Brakeman** for Rails security scanning
- **bundler-audit** for dependency vulnerability checks

---

## 🛠 Setup & Installation

### 1. Clone the repository

```bash
git clone https://github.com/heikekegel/mentemara.git
cd mentemara
```

### 2. Install dependencies

```bash
bundle install
```

### 3. Prepare the database

```bash
rails db:prepare
```

This creates the local SQLite database and runs migrations.

### 4. Start the Rails server

```bash
rails server
```

Open the app in your browser:

```text
http://localhost:3000
```

---

## 🧪 Running Tests

Run the full RSpec test suite:

```bash
bundle exec rspec
```

---

## 🔍 Code Quality & Security

### RuboCop

Run RuboCop:

```bash
bundle exec rubocop
```

Auto-correct safe style issues:

```bash
bundle exec rubocop -a
```

### Brakeman

Run Brakeman:

```bash
bundle exec brakeman
```

Brakeman scans Rails application code for common security vulnerabilities.

### bundler-audit

Run bundler-audit:

```bash
bundle exec bundler-audit check --update
```

bundler-audit checks Ruby gem dependencies for known vulnerabilities.

---

## 🧠 Key Concepts Used

### CRUD

CRUD stands for:

- **Create** – add a new intake
- **Read** – view existing intake submissions
- **Update** – edit an existing intake
- **Delete** – remove an intake

MenteMara supports the full CRUD flow for intake submissions.

---

### RESTful Routes

RESTful routes are a standardized way to map HTTP requests to controller actions.

In Rails, this is commonly generated with:

```ruby
resources :intakes
```

That creates routes like:

| HTTP Verb | Route             | Controller Action |
|----------|-------------------|-------------------|
| GET      | `/intakes`        | `index`           |
| GET      | `/intakes/new`    | `new`             |
| POST     | `/intakes`        | `create`          |
| GET      | `/intakes/:id`    | `show`            |
| GET      | `/intakes/:id/edit` | `edit`          |
| PATCH    | `/intakes/:id`    | `update`          |
| DELETE   | `/intakes/:id`    | `destroy`         |

---

### MVC Architecture

Rails follows the MVC pattern:

- **Model**  
  Handles data, validation, and database interaction.

- **View**  
  Displays information to the user using ERB templates.

- **Controller**  
  Receives requests, coordinates model behavior, and decides what response to return.

In MenteMara:

- `Intake` is the model.
- `IntakesController` handles the request flow.
- ERB templates render the intake pages.

---

### ActiveRecord

ActiveRecord is Rails’ ORM, or Object Relational Mapper.

It allows the app to work with database records as Ruby objects instead of writing raw SQL manually.

Example:

```ruby
Intake.create!(valid_attributes)
```

This creates and saves an intake record in the database.

---

### Strong Parameters

Strong parameters control which submitted form fields are allowed into the model.

Example:

```ruby
params.require(:intake).permit(
  :full_name,
  :email,
  :phone,
  :reason_for_visit,
  :urgency,
  :insurance_provider
)
```

This protects the app from users submitting unexpected or unsafe fields.

---

### Validations

The Intake model validates required fields and phone number format.

The phone validation uses a regular expression:

```text
\A\d{10,15}\z
```

This means:

- the value must start at the beginning of the string
- contain only digits
- be between 10 and 15 digits long
- end after those digits

---

### Turbo

Turbo is part of Hotwire and improves Rails page navigation and form handling by reducing full page reloads.

For standard Rails form and navigation behavior, Turbo can handle much of the interaction automatically.

---

### Stimulus

Stimulus is a lightweight JavaScript framework designed to work well with Rails.

It connects HTML to JavaScript behavior using data attributes.

Example:

```html
<button data-action="click->intake#delete">Delete</button>
```

This means:

```text
click event
→ intake Stimulus controller
→ delete method
```

In MenteMara, Stimulus is used to delete a row dynamically without reloading the page.

---

## 🔁 Application Flow: CRUD

### Create Flow

```text
User opens new intake form
→ GET /intakes/new
→ IntakesController#new
→ @intake = Intake.new
→ app/views/intakes/new.html.erb renders the form
```

When the user submits:

```text
User submits form
→ POST /intakes
→ IntakesController#create
→ Intake.new(intake_params)
→ validations run
→ record saves to database
→ redirect_to @intake
→ browser makes GET /intakes/:id
→ IntakesController#show
→ show page displays the saved intake
```

This follows the Post / Redirect / Get pattern.

---

### Read Flow: All Intakes

```text
User visits /intakes
→ GET /intakes
→ IntakesController#index
→ @intakes = Intake.order(created_at: :desc)
→ app/views/intakes/index.html.erb renders table of submissions
```

---

### Read Flow: Single Intake

```text
User clicks an intake name
→ GET /intakes/:id
→ IntakesController#show
→ @intake = Intake.find(params[:id])
→ app/views/intakes/show.html.erb displays details
```

---

### Update Flow

```text
User clicks Edit
→ GET /intakes/:id/edit
→ IntakesController#edit
→ @intake = Intake.find(params[:id])
→ app/views/intakes/edit.html.erb renders form with existing values
```

When the user submits:

```text
User submits edit form
→ PATCH /intakes/:id
→ IntakesController#update
→ @intake.update(intake_params)
→ validations run
→ record updates in database
→ redirect_to @intake
→ show page displays updated details
```

---

### Delete Flow

```text
User clicks Delete
→ Stimulus controller handles click
→ JavaScript confirm dialog appears
→ fetch sends DELETE /intakes/:id
→ IntakesController#destroy
→ record is deleted from database
→ Rails returns JSON response
→ JavaScript removes the table row from the DOM
→ page updates without a full reload
```

This flow uses Rails, Stimulus, JavaScript fetch, JSON, and DOM manipulation.

---

## 🧪 Testing

### Model Specs

Located in:

```text
spec/models
```

Model specs test:

- required fields
- phone validation
- optional fields
- business rules

Example:

```ruby
expect(intake).to be_valid
```

---

### Request Specs

Located in:

```text
spec/requests
```

Request specs test the full HTTP request lifecycle:

```text
request
→ route
→ controller
→ model/database
→ response
```

Examples include:

- `GET /intakes`
- `POST /intakes`
- `DELETE /intakes/:id`

---

## 🛠 Debugging Tools

### Rails Logs

Rails logs show incoming requests, controller actions, SQL queries, redirects, and errors.

### Chrome DevTools

Chrome DevTools is useful for frontend troubleshooting.

It can be used to:

- inspect JavaScript console errors
- confirm whether Stimulus controllers are loading
- inspect network requests
- verify whether DELETE requests are sent
- inspect JSON responses
- confirm DOM updates

Example debugging story:

```text
The delete button stopped working.
Rails logs showed no DELETE request.
Chrome DevTools showed JavaScript import errors.
That confirmed the issue was frontend / Stimulus loading, not the Rails controller.
```

### Pry

Pry can be used to pause Ruby code during execution and inspect values.

Example:

```ruby
binding.pry
```

This is useful for inspecting:

- `params`
- model objects
- controller state

---

## 📌 Interview Talking Points

A natural way to describe this project:

```text
I built a Rails intake-management app with full CRUD functionality.
I used RESTful routes and ActiveRecord for the core backend flow.
For the frontend, I used Turbo for standard Rails interactions and Stimulus with fetch for a dynamic delete action that removes a row without a full page reload.
I also added model and request specs with RSpec, and I integrated RuboCop, Brakeman, and bundler-audit for code quality and security checks.
```

---

## 👩‍💻 Author

Heike Kegel
