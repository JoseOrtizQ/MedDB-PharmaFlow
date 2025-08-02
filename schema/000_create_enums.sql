-- Create ENUM types first
CREATE TYPE payment_method_type AS ENUM ('cash', 'card', 'insurance', 'check', 'digital');
CREATE TYPE payment_status_type AS ENUM ('pending', 'completed', 'refunded', 'partial');
CREATE TYPE inventory_status_type AS ENUM ('active', 'expired', 'damaged', 'recalled');
CREATE TYPE po_status_type AS ENUM ('pending', 'ordered', 'partially_received', 'received', 'cancelled');
CREATE TYPE po_item_status_type AS ENUM ('pending', 'partially_received', 'received');
CREATE TYPE alert_type AS ENUM ('30_days', '60_days', '90_days', 'expired');
CREATE TYPE movement_type AS ENUM ('purchase', 'sale', 'adjustment', 'return', 'expired', 'damaged', 'transfer');
CREATE TYPE user_role_type AS ENUM ('admin', 'pharmacist', 'technician', 'cashier', 'manager');
CREATE TYPE audit_action_type AS ENUM ('INSERT', 'UPDATE', 'DELETE');
