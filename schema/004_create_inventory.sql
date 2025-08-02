-- 4. INVENTORY TABLE
CREATE TABLE inventory (
    inventory_id SERIAL PRIMARY KEY,
    product_id INTEGER NOT NULL REFERENCES products(product_id),
    supplier_id INTEGER REFERENCES suppliers(supplier_id),
    batch_number VARCHAR(100),
    lot_number VARCHAR(100),
    quantity_on_hand INTEGER NOT NULL DEFAULT 0 CHECK (quantity_on_hand >= 0),
    quantity_reserved INTEGER DEFAULT 0 CHECK (quantity_reserved >= 0),
    quantity_available INTEGER GENERATED ALWAYS AS (quantity_on_hand - quantity_reserved) STORED,
    unit_cost DECIMAL(10,2) CHECK (unit_cost >= 0),
    manufacturing_date DATE,
    expiration_date DATE,
    received_date TIMESTAMPTZ DEFAULT NOW(),
    location VARCHAR(100),
    status inventory_status_type DEFAULT 'active',
    notes TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW(),
    CONSTRAINT chk_dates CHECK (manufacturing_date IS NULL OR expiration_date IS NULL OR manufacturing_date <= expiration_date),
    CONSTRAINT chk_reserved_quantity CHECK (quantity_reserved <= quantity_on_hand)
);
