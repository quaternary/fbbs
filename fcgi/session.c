#include "libweb.h"
#include "fbbs/mdbi.h"
#include "fbbs/session.h"
#include "fbbs/string.h"
#include "fbbs/user.h"
#include "fbbs/web.h"

extern int do_web_login(const char *uname, const char *pw, bool api);

static bool activate_session(session_id_t session_id, const char *user_name,
		const char *session_key, user_id_t user_id)
{
	bool ok = false;
	db_res_t *res = db_query("UPDATE sessions SET active = TRUE, stamp = %t"
			" WHERE id = %"DBIdSID" RETURNING token", fb_time(), session_id);
	if (res && db_res_rows(res) == 1) {
		if (!do_web_login(user_name, NULL, false)) {
			const char *token = db_get_value(res, 0, 0);
			session_web_cache_set(user_id, session_key, token, session_id,
					true);
			ok = true;
		}
	}
	db_clear(res);
	return ok;
}

static bool session_check_web_cache(const char *user_name,
		const char *session_key, const char *token)
{
	user_id_t user_id = get_user_id(user_name);
	if (user_id <= 0)
		return false;

	char value[SESSION_WEB_CACHE_VALUE_LEN] = "";
	session_web_cache_get(user_id, session_key, value, sizeof(value));
	session_id_t session_id = strtol(value, NULL, 10);
	char *ptr = strchr(value, '-');

	bool ok = false;
	if (session_id > 0 && ptr && ptr + 3 < value + sizeof(value)) {
		bool active = ptr[1] == '1';
		if (!token || streq(token, ptr + 3)) {
			if (active) {
				ok = true;
			} else {
				ok = activate_session(session_id, user_name,
						session_key, user_id);
			}
		}
	}

	if (ok) {
		session_set_id(session_id);
		session_set_user_id(user_id);
		session_set_idle_cached();
	}
	return ok;
}

bool session_validate(void)
{
	memset(&currentuser, 0, sizeof(currentuser));
	session_clear();

	const char *user_name = web_get_param(WEB_COOKIE_USER);
	const char *key = web_get_param(WEB_COOKIE_KEY);
	const char *token = NULL;
	if (web_request_type(API) && !web_request_method(GET)) {
		web_parse_post_data();
		token = web_get_param("token");
	}

	bool ok = session_check_web_cache(user_name, key, token);
	if (ok)
		getuserec(user_name, &currentuser);

	return ok;
}
