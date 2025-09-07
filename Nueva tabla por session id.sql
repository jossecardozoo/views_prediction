CREATE OR REPLACE TABLE `antel-equipo4.desafio_antel.sesiones_agregadas` AS
SELECT
  session_id,

  COUNTIF(event_name = 'screen_view') AS screen_view_count,
  IF(COUNTIF(event_name = 'view_item') > 0, 1, 0) AS tuvo_view_item,
  IF(COUNTIF(event_name = 'play') > 0, 1, 0) AS play,
  COUNTIF(event_name = 'user_engagement') AS user_engagement_count,

  EXTRACT(HOUR FROM TIMESTAMP_MICROS(MIN(event_timestamp))) AS primera_hora,

  CASE
    WHEN EXTRACT(HOUR FROM TIMESTAMP_MICROS(MIN(event_timestamp))) BETWEEN 5 AND 11 THEN 'mañana'
    WHEN EXTRACT(HOUR FROM TIMESTAMP_MICROS(MIN(event_timestamp))) BETWEEN 12 AND 13 THEN 'mediodía'
    WHEN EXTRACT(HOUR FROM TIMESTAMP_MICROS(MIN(event_timestamp))) BETWEEN 14 AND 18 THEN 'tarde'
    WHEN EXTRACT(HOUR FROM TIMESTAMP_MICROS(MIN(event_timestamp))) BETWEEN 19 AND 23 THEN 'noche'
    ELSE 'madrugada'
  END AS horario_del_dia,

  ANY_VALUE(platform) AS plataforma_usada,

  SAFE_DIVIDE(MAX(event_timestamp) - MIN(event_timestamp), 1000000) AS duracion_sesion_segundos,

  COUNT(*) AS total_eventos_sesion,

  COUNT(DISTINCT event_name) AS eventos_unicos_sesion,

  COUNTIF(event_name = 'engaged_session_event') AS engaged_session_event_count,

  IF(COUNTIF(event_name = 'purchase') > 0, 1, 0) AS hubo_compra

FROM
  `antel-equipo4.desafio_antel.tabla_desafio_sin_nulls`

GROUP BY
  session_id;
