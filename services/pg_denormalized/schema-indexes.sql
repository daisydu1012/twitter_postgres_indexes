CREATE INDEX ON tweets_jsonb
USING gin (
	(data -> 'entities' -> 'hashtags') jsonb_path_ops,
	(data -> 'extended_tweet' -> 'entities' -> 'hashtags') jsonb_path_ops
);

CREATE INDEX ON tweets_jsonb
USING gin (
        to_tsvector('english', (data -> 'extended_tweet'->>'full_text')),
        to_tsvector('english', (data ->> 'text'))
);
