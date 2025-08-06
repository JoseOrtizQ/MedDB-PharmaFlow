-- Low stock products view
CREATE VIEW low_stock_products AS
SELECT 
    p.product_id,
    p.product_code,
    p.product_name,
    p.brand_name,
    COALESCE(SUM(i.quantity_available), 0) as available_quantity,
    p.minimum_stock_level,
    p.reorder_point,
    p.minimum_stock_level - COALESCE(SUM(i.quantity_available), 0) as shortage_quantity
FROM products p
LEFT JOIN inventory i ON i.product_id = p.product_id AND i.status = 'active'
WHERE p.is_active = TRUE
GROUP BY p.product_id, p.product_code, p.product_name, p.brand_name, p.minimum_stock_level, p.reorder_point
HAVING COALESCE(SUM(i.quantity_available), 0) <= p.minimum_stock_level
ORDER BY shortage_quantity DESC;
