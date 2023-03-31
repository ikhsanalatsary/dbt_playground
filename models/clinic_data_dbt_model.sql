{{ config(materialized='ephemeral') }}

-- Define a CTE to select the JSON data
WITH clinic_data AS (
    SELECT
    cast(
        a.e ->> 'clinic_name' AS VARCHAR
    ) AS clinic_name FROM {{ source('public', 'doctor_specialist_raw') }} AS s
   CROSS JOIN LATERAL jsonb_array_elements(s.data->'data') AS a(e)
)

select *
from clinic_data