SELECT
'#' || tag_text AS tag,
COUNT(*) AS count
FROM (
    SELECT
    DISTINCT id,
    jsonb_array_elements(tag)->>'text' AS tag_text
    FROM (
        SELECT data ->> 'id' AS id, data -> 'entities' -> 'hashtags' AS tag
        FROM tweets_jsonb
        WHERE (data -> 'entities' -> 'hashtags') @> '[{"text": "coronavirus"}]'
        UNION
        SELECT data ->> 'id' AS id, data -> 'extended_tweet' -> 'entities' -> 'hashtags' AS tag
        FROM tweets_jsonb
        WHERE (data -> 'extended_tweet' -> 'entities' -> 'hashtags') @> '[{"text": "coronavirus"}]'
        ) s
    ) t
GROUP BY tag_text
ORDER BY count DESC, tag
LIMIT 1000;
