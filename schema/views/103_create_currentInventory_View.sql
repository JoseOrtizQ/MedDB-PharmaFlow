-- Current inventory levels view
CREATE VIEW current_inventory AS
SELECT 
    p.product_id,
    p.product_code,
    p.product_name,
    p.brand_name,
    c.category_name,
    COALESCE(SUM(i.quantity_on_hand), 0) as total_quantity,
    COALESCE(SUM(i.quantity_reserved), 0) as total_reserved,
    COALESCE(SUM(i.quantity_available), 0) as total_available,
    MIN(CASE WHEN i.status = 'active' AND i.quantity_on_hand > 0 THEN i.expiration_date END) as nearest_expiration,
    p.minimum_stock_level,
    p.reorder_point,
    CASE 
        WHEN COALESCE(SUM(i.quantity_available), 0) <= 0 THEN 'Out of Stock'
        WHEN COALESCE(SUM(i.quantity_available), 0) <= p.minimum_stock_level THEN 'Low Stock'
        WHEN COALESCE(SUM(i.quantity_available), 0) <= p.reorder_point THEN 'Reorder'
        ELSE 'Normal'
    END as stock_status,
    COUNT(DISTINCT i.inventory_id) FILTER (WHERE i.status = 'active' AND i.quantity_on_hand > 0) as active_batches
FROM products p
LEFT JOIN inventory i ON i.product_id = p.product_id AND i.status = 'active'
LEFT JOIN categories c ON p.category_id = c.category_id
WHERE p.is_active = TRUE
GROUP BY p.product_id, p.product_code, p.product_name, p.brand_name, c.category_name, p.minimum_stock_level, p.reorder_point;
