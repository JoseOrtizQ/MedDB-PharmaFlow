-- 12. STOCK MOVEMENTS TABLE
CREATE TABLE stock_movements (
    movement_id SERIAL PRIMARY KEY,
    inventory_id INTEGER NOT NULL REFERENCES inventory(inventory_id),
    product_id INTEGER NOT NULL REFERENCES products(product_id),
    movement_type movement_type NOT NULL,
    quantity_change INTEGER NOT NULL,
    quantity_before INTEGER NOT NULL CHECK (quantity_before >= 0),
    quantity_after INTEGER NOT NULL CHECK (quantity_after >= 0),
    reference_id INTEGER,
    reference_type VARCHAR(50),
    unit_cost DECIMAL(10,2) CHECK (unit_cost >= 0),
    reason TEXT,
    performed_by INTEGER REFERENCES users(user_id),
    movement_date TIMESTAMPTZ DEFAULT NOW()
);
