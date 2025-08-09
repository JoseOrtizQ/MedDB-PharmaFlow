-- 7. SALES TRANSACTIONS TABLE
CREATE TABLE sales (
    sale_id SERIAL PRIMARY KEY,
    sale_number VARCHAR(100) NOT NULL UNIQUE DEFAULT ('SALE' || LPAD(nextval('sales_sale_id_seq')::TEXT, 8, '0')),
    customer_id INTEGER REFERENCES customers(customer_id),
    cashier_id INTEGER REFERENCES users(user_id),
    sale_date TIMESTAMPTZ DEFAULT NOW(),
    subtotal DECIMAL(10,2) NOT NULL CHECK (subtotal >= 0),
    tax_amount DECIMAL(10,2) DEFAULT 0.00 CHECK (tax_amount >= 0),
    discount_amount DECIMAL(10,2) DEFAULT 0.00 CHECK (discount_amount >= 0),
    total_amount DECIMAL(10,2) NOT NULL CHECK (total_amount >= 0),
    payment_method payment_method_type NOT NULL,
    payment_status payment_status_type DEFAULT 'completed',
    prescription_number VARCHAR(100),
    doctor_name VARCHAR(255),
    insurance_claim_amount DECIMAL(10,2) DEFAULT 0.00 CHECK (insurance_claim_amount >= 0),
    customer_payment_amount DECIMAL(10,2) DEFAULT 0.00 CHECK (customer_payment_amount >= 0),
    notes TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW(),
    CONSTRAINT chk_payment_amounts CHECK (insurance_claim_amount + customer_payment_amount = total_amount)
);
