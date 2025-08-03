-- 11. EXPIRATION ALERTS TABLE
CREATE TABLE expiration_alerts (
    alert_id SERIAL PRIMARY KEY,
    inventory_id INTEGER NOT NULL REFERENCES inventory(inventory_id),
    product_id INTEGER NOT NULL REFERENCES products(product_id),
    batch_number VARCHAR(100),
    expiration_date DATE NOT NULL,
    quantity INTEGER NOT NULL CHECK (quantity > 0),
    alert_type alert_type NOT NULL,
    alert_date DATE NOT NULL,
    is_acknowledged BOOLEAN DEFAULT FALSE,
    acknowledged_by INTEGER REFERENCES users(user_id),
    acknowledged_at TIMESTAMPTZ,
    action_taken TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW()
);
