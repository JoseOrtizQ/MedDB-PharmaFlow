-- Expiring products view (next 90 days)
CREATE VIEW expiring_products AS
SELECT 
    i.inventory_id,
    p.product_id,
    p.product_code,
    p.product_name,
    i.batch_number,
    i.quantity_on_hand,
    i.expiration_date,
    (i.expiration_date - CURRENT_DATE) as days_to_expiry,
    CASE 
        WHEN i.expiration_date < CURRENT_DATE THEN 'Expired'
        WHEN (i.expiration_date - CURRENT_DATE) <= 30 THEN 'Critical'
        WHEN (i.expiration_date - CURRENT_DATE) <= 60 THEN 'Warning'
        ELSE 'Watch'
    END as urgency_level,
    (i.quantity_on_hand * p.unit_cost) as value_at_risk
FROM inventory i
JOIN products p ON i.product_id = p.product_id
WHERE i.status = 'active' 
    AND i.expiration_date <= CURRENT_DATE + INTERVAL '90 days'
    AND i.quantity_on_hand > 0
ORDER BY i.expiration_date ASC;
