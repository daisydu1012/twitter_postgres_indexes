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
        WHERE (
    to_tsvector('english', (data -> 'extended_tweet'->>'full_text'))@@to_tsquery('english', 'coronavirus')
    OR
    to_tsvector('english', (data ->> 'text'))@@to_tsquery('english', 'coronavirus')
)
AND (data ->> 'lang') = 'en'
        UNION
        SELECT data ->> 'id' AS id, data -> 'extended_tweet' -> 'entities' -> 'hashtags' AS tag
        FROM tweets_jsonb
        WHERE (
    to_tsvector('english', (data -> 'extended_tweet'->>'full_text'))@@to_tsquery('english', 'coronavirus')
    OR
    to_tsvector('english', (data ->> 'text'))@@to_tsquery('english', 'coronavirus')
)
AND (data ->> 'lang') = 'en'
        ) s
    ) t
GROUP BY tag_text
ORDER BY count DESC, tag
LIMIT 1000;
