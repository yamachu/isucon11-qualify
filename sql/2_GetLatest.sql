INSERT INTO latest_isu_condition(`id`, `jia_isu_uuid`, `timestamp`, `is_sitting`, `condition`, `message`, `created_at`)
SELECT ic1.*
FROM isu_condition AS ic1
JOIN
  (SELECT id,
          max(TIMESTAMP) AS latestAt,
          jia_isu_uuid
   FROM isu_condition
   GROUP BY jia_isu_uuid) AS ic2 ON ic2.jia_isu_uuid = ic1.jia_isu_uuid
AND ic2.latestAt = ic1.timestamp;