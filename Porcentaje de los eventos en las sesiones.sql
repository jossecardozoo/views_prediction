SELECT
  event_name,
  COUNTIF(play = 1) AS en_sesiones_con_play,
  COUNTIF(play = 0) AS en_sesiones_sin_play,
  SAFE_DIVIDE(COUNTIF(play = 1), COUNTIF(play = 1) + COUNTIF(play = 0)) AS porcentaje_en_sesiones_con_play
FROM (
  SELECT
    session_id,
    event_name,
    IF(COUNTIF(event_name = 'play') OVER (PARTITION BY session_id) > 0, 1, 0) AS play
  FROM `antel-equipo4.desafio_antel.tabla_desafio_sin_nulls`
  GROUP BY session_id, event_name
)
GROUP BY event_name
ORDER BY porcentaje_en_sesiones_con_play DESC
