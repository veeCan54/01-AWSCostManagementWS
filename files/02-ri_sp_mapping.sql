CREATE OR REPLACE VIEW "ri_sp_mapping" AS 
   SELECT DISTINCT
   "bill_billing_period_start_date" "billing_period_mapping"
  , "bill_payer_account_id" "payer_account_id_mapping"
  , CASE 
     WHEN ("savings_plan_savings_plan_a_r_n" <> '') THEN "savings_plan_savings_plan_a_r_n" 
     WHEN ("reservation_reservation_a_r_n" <> '') THEN "reservation_reservation_a_r_n"ELSE '' END "ri_sp_arn_mapping"
  , CASE 
     WHEN ("savings_plan_savings_plan_a_r_n" <> '') THEN CAST(from_iso8601_timestamp("savings_plan_end_time") AS timestamp)
     WHEN ("reservation_reservation_a_r_n" <> '' AND "reservation_end_time" <> '') THEN CAST(from_iso8601_timestamp("reservation_end_time") AS timestamp) ELSE NULL END "ri_sp_end_date"
  , CASE 
     WHEN ("savings_plan_savings_plan_a_r_n" <> '') THEN "savings_plan_purchase_term" 
  WHEN ("reservation_reservation_a_r_n" <> '') THEN "pricing_lease_contract_length"ELSE '' END "ri_sp_term"
  , CASE 
     WHEN ("savings_plan_savings_plan_a_r_n" <> '') THEN "savings_plan_offering_type" 
     WHEN ("reservation_reservation_a_r_n" <> '') THEN "pricing_offering_class" ELSE '' END "ri_sp_offering"
  , CASE 
     WHEN ("savings_plan_savings_plan_a_r_n" <> '') THEN "savings_plan_payment_option" 
     WHEN ("reservation_reservation_a_r_n" <> '') THEN "pricing_purchase_option"	ELSE '' END "ri_sp_payment"			
     FROM
       customer_cur_data.demo_costso_999955826741
     WHERE (("line_item_line_item_type" = 'RIFee') OR ("line_item_line_item_type" = 'SavingsPlanRecurringFee'))
