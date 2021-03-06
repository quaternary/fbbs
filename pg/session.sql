BEGIN;

DROP TABLE IF EXISTS sessions;

CREATE TABLE sessions (
	id BIGSERIAL,
	session_key TEXT,
	token TEXT,
	active BOOLEAN DEFAULT TRUE,
	user_id INTEGER,
	user_name TEXT,
	pid INTEGER DEFAULT 0,
	visible BOOLEAN DEFAULT TRUE,
	ip_addr TEXT,
	web BOOLEAN,
	secure BOOLEAN,
	stamp TIMESTAMPTZ,
	expire TIMESTAMPTZ
);

COMMIT;
