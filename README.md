
# Cash Register Web App

This is a simple Cash Register web application built with Ruby on Rails. The app provides a shopping cart interface where users can add or remove products, view their cart, and proceed to checkout. Designed as an educational project, it demonstrates fundamental Rails concepts, including session management, form handling, and a basic cart system.

## Table of Contents

- [Features](#features)
- [Getting Started](#getting-started)
  - [Prerequisites](#prerequisites)
  - [Installation](#installation)
  - [Database Setup](#database-setup)
  - [Starting the Server](#starting-the-server)
- [Usage](#usage)
  - [Adding and Removing Items](#adding-and-removing-items)
  - [Checkout Process](#checkout-process)
- [Testing](#testing)
- [Contributing](#contributing)
- [License](#license)

## Features

- **Product Management**: Add and remove products from a predefined list.
- **Shopping Cart**: View items in the cart with quantity and total price calculation.
- **Session Management**: Cart persists across user sessions until checkout.
- **Checkout Flow**: Displays a "Thank you for shopping" message upon successful checkout and provides an option to continue shopping.

## Getting Started

Follow these steps to get a local copy of the project up and running.

### Prerequisites

Ensure you have the following software installed:

- **Ruby** (version 2.7 or higher recommended)
- **Rails** (version 6.1 or higher)
- **SQLite3** (or another preferred database)

### Installation

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/your-username/cash-register-webapp.git
   cd cash-register-webapp
   ```

2. **Install Dependencies**:
   ```bash
   bundle install
   ```

### Database Setup

1. Set up the database and populate it with sample products:
   ```bash
   rails db:migrate
   rails db:seed
   ```

### Starting the Server

Start the Rails server:

```bash
rails server
```

Visit `http://localhost:3000` in your browser to access the app.

## Usage

### Adding and Removing Items

1. On the **Main Menu** page, use the form to add items to your cart by entering the product code.
2. The cart, displayed on the top right, shows a list of added items with quantities and total price.
3. To remove an item, enter its product code in the remove form.

### Checkout Process

1. Once items are added to the cart, click the **Checkout** button.
2. If the cart is empty, you will see an error message prompting you to add items.
3. On successful checkout, you’ll be taken to a confirmation page with a thank-you message and a link to continue shopping.

## Testing

Run tests to verify that everything is working as expected:

```bash
rails test
```

This will run the application's test suite, where tests are located in the `test` directory.

## Contributing

1. Fork the repository.
2. Create a new feature branch (`git checkout -b feature-branch`).
3. Commit your changes (`git commit -m 'Add a new feature'`).
4. Push to the branch (`git push origin feature-branch`).
5. Open a pull request.

We welcome contributions to improve this application!

## License

This project is licensed under the MIT License.
