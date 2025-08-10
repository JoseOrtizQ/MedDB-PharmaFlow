# MedDB-PharmaFlow
# PharmaFlow Healthcare Inventory Management System Database

A Healthcare Inventory Management System to track and manage medications, medical supplies, and equipment with automated stock alerts, expiration monitoring, and supplier management.

This repository contains the SQL schema and related scripts for the **PharmaFlow** Healthcare Inventory Management System. It includes the setup for various tables, views, and indexes to manage inventory, suppliers, customers, sales, and more.

## Project Overview

The goal of the **PharmaFlow** system is to maintain and track product inventory levels, sales, and order management. It includes functionality for:
- Managing product and supplier information.
- Tracking inventory levels, stock movements, and expiration alerts.
- Managing customer details and their purchases.
- Logging audit information for any changes in the system.

## Database Structure

### Tables
The database schema consists of the following tables:
- **Suppliers**: Stores information about the suppliers.
- **Categories**: Stores product categories.
- **Products**: Information about the products sold.
- **Inventory**: Tracks the inventory levels for each product.
- **Customers**: Stores customer details.
- **Users**: Stores information regarding system users.
- **Sales**: Stores information about the sales transactions.
- **Sales Items**: Tracks items in each sale.
- **Purchase Orders**: Manages orders placed with suppliers.
- **Purchase Order Items**: Tracks items in each purchase order.
- **Expiration Alerts**: Stores alerts for expiring products.
- **Stock Movements**: Tracks any movement (sale, purchase, etc.) of inventory.
- **Audit Log**: Logs changes made to the system for auditing purposes.

### Views
- **Current Inventory View**: A view to get aggregated inventory data, including stock levels, status (low stock, out of stock, etc.), and expiration dates.

### Indexes
Indexes are created to improve performance on frequently queried columns such as `product_id`, `category_id`, `expiration_date`, etc.

## Setup Instructions
git clone https://github.com/yourusername/MedDB-PharmaFlow.git
cd MedDB-PharmaFlow

# Connect to PostgreSQL as superuser and run initialization
psql -U postgres -f init.sql
# Important: Change the default password in init.sql before running.

### Prerequisites
- PostgreSQL version 9.6 or higher.

### Running the Setup

