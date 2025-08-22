# Smart POS Server

A backend server for a Smart Point-of-Sale (POS) system, built with Node.js, Express, and PostgreSQL. This server provides RESTful APIs for managing products, inventory, sales, employees, branches, customers, suppliers, and more.

## Table of Contents

- [Features](#features)
- [Tech Stack](#tech-stack)
- [Project Structure](#project-structure)
- [Database Schema](#database-schema)
- [Setup & Installation](#setup--installation)
- [Environment Variables](#environment-variables)
- [API Endpoints](#api-endpoints)
- [File Uploads](#file-uploads)
- [Authentication](#authentication)
- [Scripts](#scripts)
- [License](#license)

---

## Features

- User authentication (JWT)
- Role-based access control
- Product, category, inventory, and supplier management
- Employee and branch management
- Customer and sales history tracking
- Cart and order processing
- File/image upload support
- RESTful API design

## Tech Stack

- **Node.js** (v18+)
- **Express.js**
- **PostgreSQL**
- **JWT** for authentication
- **Multer** for file uploads
- **dotenv** for environment configuration
- **CORS** support

## Project Structure

```
smart_pos_server/
│
├── config/                # Database and app configuration
│   ├── config.js
│   └── database/
│       ├── schema.sql
│       ├── a_createTables.sql
│       └── ... (other SQL scripts)
│
├── controllers/           # Route controllers
├── middleware/            # Custom middleware (auth, upload)
├── models/                # Database models
├── public/                # Static files and images
├── routes/                # API route definitions
├── utils/                 # Utility functions
├── server.js              # Main server entry point
├── package.json
└── README.md
```

## Database Schema

- See `config/database/schema.sql` and `a_createTables.sql` for full schema.
- Includes tables for products, categories, inventory, sales, employees, branches, customers, suppliers, user roles, and more.
- Uses foreign key constraints for data integrity.

## Setup & Installation

1. **Clone the repository:**
	```sh
	git clone https://github.com/ChandiH/smart_pos_server.git
	cd smart_pos_server
	```

2. **Install dependencies:**
	```sh
	npm install
	```

3. **Configure environment variables:**
	- Create a `.env` file in the root directory with the following variables:
	  ```
	  PORT=4000
	  DATABASE_USER=your_db_user
	  DATABASE_PASSWORD=your_db_password
	  DATABASE_HOST=localhost
	  DATABASE_PORT=5432
	  DATABASE_NAME=smart_pos_db
	  SECRET_KEY=your_jwt_secret
	  ```
	- Adjust values as needed for your environment.

4. **Set up the PostgreSQL database:**
	- Run the SQL scripts in `config/database/` to create the database and tables.
	- Example:
	  ```sh
	  psql -U your_db_user -f config/database/schema.sql
	  psql -U your_db_user -d smart_pos_db -f config/database/a_createTables.sql
	  ```

5. **Start the server:**
	```sh
	npm start
	```
	- The server will run on the port specified in `.env` (default: 4000).

## Environment Variables

| Variable         | Description                  |
|------------------|-----------------------------|
| PORT             | Server port                 |
| DATABASE_USER    | PostgreSQL username         |
| DATABASE_PASSWORD| PostgreSQL password         |
| DATABASE_HOST    | Database host (e.g., localhost) |
| DATABASE_PORT    | Database port (default: 5432) |
| DATABASE_NAME    | Database name               |
| SECRET_KEY       | JWT secret key              |

## API Endpoints

All endpoints are prefixed by their resource, e.g. `/auth`, `/product`, `/customer`, etc.

### Authentication

- `POST /auth/login` — Login and receive JWT token
- `POST /auth/register` — Register a new employee
- `POST /auth/reset-password` — Reset password

### Products & Inventory

- `GET /product` — List products
- `POST /product` — Add product (supports image upload)
- `GET /inventory` — List inventory
- ...and more

### Customers & Sales

- `GET /customer` — List customers
- `POST /customer` — Add customer
- `GET /chart` — Sales analytics

### Employees & Branches

- `GET /employee` — List employees
- `POST /employee` — Add employee (supports image upload)
- `GET /branch` — List branches

### Cart & Orders

- `GET /cart` — View cart
- `POST /cart` — Add to cart
- `GET /supplier` — List suppliers

### User Roles

- `GET /user-role` — List user roles

## File Uploads

- Single file: `POST /upload` (form field: `file`)
- Multiple files: `POST /upload-multiple` (form field: `files`)
- Product images: `POST /product` (form field: `files`)
- Employee images: `POST /employee` (form field: `file`)
- Uploaded files are stored in `public/image/`

## Authentication

- JWT-based authentication.
- Protect routes using the `authJWT` middleware.
- Example usage:
  ```js
  app.use("/customer", jwt.verifyToken, customerRouter);
  ```

## Scripts

| Command         | Description                |
|-----------------|---------------------------|
| `npm start`     | Start server              |
| `npm run online`| Start server with nodemon |
| `npm test`      | Run tests (not implemented)|

## License

ISC © Somesh Chandimal

---

**For more details, see the source code and SQL schema files.**

If you have any questions or need help, please contact the author or open an issue.

