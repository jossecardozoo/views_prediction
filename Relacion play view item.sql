SELECT
  tuvo_view_item,
  play,
  COUNT(*) AS cantidad_sesiones
FROM
  `antel-equipo4.desafio_antel.sesiones_agregadas`
GROUP BY
  tuvo_view_item,
  play
ORDER BY
  cantidad_sesiones DESC
