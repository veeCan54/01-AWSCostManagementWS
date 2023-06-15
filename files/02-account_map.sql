CREATE OR REPLACE VIEW account_map AS
 SELECT DISTINCT
     "line_item_usage_account_id" "account_id", "line_item_usage_account_id" "account_name"
 FROM
     customer_cur_data.demo_costso_999955826741;