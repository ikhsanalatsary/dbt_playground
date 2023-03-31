{{
  config(
    materialized='table',
    alias='doctor_specialist',
    unique_key='id',
    strategy='upsert',
    dbt_create_missing_indexes=true
  )
}}

-- Define the dbt model
WITH doctor_specialist AS (
  SELECT
    ROW_NUMBER() OVER (ORDER BY clinic_data.clinic_name) AS id,
    'specialist' AS type,
    clinic_data.clinic_name AS description,
    FALSE AS is_ppki,
    TRUE AS is_ppkii,
    TRUE AS is_laboratory,
    TRUE AS is_farmacy,
    TRUE AS is_out_patient,
    TRUE AS is_in_patient,
    FALSE AS is_igd,
    FALSE AS is_deleted,
    0 AS provider_id,
    'SYSTEM MANUAL' AS created_by,
    CURRENT_TIMESTAMP AS created_date,
    'SYSTEM MANUAL' AS modified_by,
    CURRENT_TIMESTAMP AS modified_date,
    NULL AS parent_id
  FROM {{ ref('clinic_data_dbt_model') }} as clinic_data
)

SELECT * FROM doctor_specialist
