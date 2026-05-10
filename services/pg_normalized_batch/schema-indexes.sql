CREATE INDEX IF NOT EXISTS tweets_text_coronavirus_en_idx
ON tweets USING gin (to_tsvector('english', text))
WHERE lang = 'en';

CREATE INDEX IF NOT EXISTS tweet_tags_id_tweets_tag_idx
ON tweet_tags (id_tweets, tag);

CREATE INDEX IF NOT EXISTS tweet_tags_tag_id_tweets_idx
ON tweet_tags (tag, id_tweets);
