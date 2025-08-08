-- Function to create expiration alerts
CREATE OR REPLACE FUNCTION check_expiration_alerts()
RETURNS TRIGGER AS $$
BEGIN
    -- Create alerts for products expiring in 30, 60, and 90 days
    IF NEW.expiration_date IS NOT NULL AND NEW.status = 'active' AND NEW.quantity_on_hand > 0 THEN
        -- 30 days alert
        IF NEW.expiration_date <= CURRENT_DATE + INTERVAL '30 days' AND 
           NEW.expiration_date > CURRENT_DATE + INTERVAL '29 days' THEN
            INSERT INTO expiration_alerts (inventory_id, product_id, batch_number, expiration_date, quantity, alert_type, alert_date)
            VALUES (NEW.inventory_id, NEW.product_id, NEW.batch_number, NEW.expiration_date, NEW.quantity_on_hand, '30_days', CURRENT_DATE);
        END IF;
        
        -- 60 days alert
        IF NEW.expiration_date <= CURRENT_DATE + INTERVAL '60 days' AND 
           NEW.expiration_date > CURRENT_DATE + INTERVAL '59 days' THEN
            INSERT INTO expiration_alerts (inventory_id, product_id, batch_number, expiration_date, quantity, alert_type, alert_date)
            VALUES (NEW.inventory_id, NEW.product_id, NEW.batch_number, NEW.expiration_date, NEW.quantity_on_hand, '60_days', CURRENT_DATE);
        END IF;
        
        -- 90 days alert
        IF NEW.expiration_date <= CURRENT_DATE + INTERVAL '90 days' AND 
           NEW.expiration_date > CURRENT_DATE + INTERVAL '89 days' THEN
            INSERT INTO expiration_alerts (inventory_id, product_id, batch_number, expiration_date, quantity, alert_type, alert_date)
            VALUES (NEW.inventory_id, NEW.product_id, NEW.batch_number, NEW.expiration_date, NEW.quantity_on_hand, '90_days', CURRENT_DATE);
        END IF;
        
        -- Expired alert
        IF NEW.expiration_date < CURRENT_DATE THEN
            INSERT INTO expiration_alerts (inventory_id, product_id, batch_number, expiration_date, quantity, alert_type, alert_date)
            VALUES (NEW.inventory_id, NEW.product_id, NEW.batch_number, NEW.expiration_date, NEW.quantity_on_hand, 'expired', CURRENT_DATE);
        END IF;
    END IF;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Create trigger for expiration alerts
CREATE TRIGGER expiration_alert_trigger 
    AFTER INSERT OR UPDATE ON inventory 
    FOR EACH ROW 
    EXECUTE FUNCTION check_expiration_alerts();
