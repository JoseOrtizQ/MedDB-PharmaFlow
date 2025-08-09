-- 9. PURCHASE ORDERS TABLE
CREATE TABLE purchase_orders (
    po_id SERIAL PRIMARY KEY,
    po_number VARCHAR(100) NOT NULL UNIQUE DEFAULT ('PO' || LPAD(nextval('purchase_orders_po_id_seq')::TEXT, 8, '0')),
    supplier_id INTEGER NOT NULL REFERENCES suppliers(supplier_id),
    order_date TIMESTAMPTZ DEFAULT NOW(),
    expected_delivery_date DATE,
    actual_delivery_date DATE,
    status po_status_type DEFAULT 'pending',
    subtotal DECIMAL(10,2) CHECK (subtotal >= 0),
    tax_amount DECIMAL(10,2) DEFAULT 0.00 CHECK (tax_amount >= 0),
    shipping_cost DECIMAL(10,2) DEFAULT 0.00 CHECK (shipping_cost >= 0),
    total_amount DECIMAL(10,2) CHECK (total_amount >= 0),
    notes TEXT,
    created_by INTEGER REFERENCES users(user_id),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);
