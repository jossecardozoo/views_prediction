CREATE OR REPLACE TABLE `antel-equipo4.desafio_antel.tabla_desafio_sin_nulls` AS
SELECT
  *,
  (
    SELECT CAST(value.int_value AS STRING)
    FROM UNNEST(event_params) AS param
    WHERE param.key = 'ga_session_id'
    LIMIT 1
  ) AS ga_session_id,
  CONCAT(
    CAST(
      (
        SELECT value.int_value
        FROM UNNEST(event_params) AS param
        WHERE param.key = 'ga_session_id'
        LIMIT 1
      ) AS STRING
    ),
    '_',
    CAST(user_pseudo_id AS STRING)
  ) AS session_id
FROM
  `antel-equipo4.desafio_antel.tabla_desafio_sin_nulls`
