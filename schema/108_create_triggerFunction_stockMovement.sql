-- Function to automatically create stock movement records
CREATE OR REPLACE FUNCTION create_stock_movement()
RETURNS TRIGGER AS $$
BEGIN
    -- Only create movement if quantity_on_hand changed
    IF TG_OP = 'UPDATE' AND OLD.quantity_on_hand != NEW.quantity_on_hand THEN
        INSERT INTO stock_movements (
            inventory_id, 
            product_id, 
            movement_type, 
            quantity_change, 
            quantity_before, 
            quantity_after,
            unit_cost,
            reason
        ) VALUES (
            NEW.inventory_id,
            NEW.product_id,
            CASE 
                WHEN NEW.quantity_on_hand > OLD.quantity_on_hand THEN 'purchase'::movement_type
                ELSE 'sale'::movement_type
            END,
            NEW.quantity_on_hand - OLD.quantity_on_hand,
            OLD.quantity_on_hand,
            NEW.quantity_on_hand,
            NEW.unit_cost,
            'Automatic movement tracking'
        );
    END IF;
    
    RETURN COALESCE(NEW, OLD);
END;
$$ LANGUAGE plpgsql;

-- Create trigger for automatic stock movement tracking
CREATE TRIGGER inventory_movement_trigger 
    AFTER UPDATE ON inventory 
    FOR EACH ROW 
    EXECUTE FUNCTION create_stock_movement();
