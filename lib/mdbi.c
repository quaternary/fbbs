#include <stdarg.h>

#include "fbbs/fbbs.h"
#include "fbbs/mdbi.h"

int mdb_connect_unix(const char *path)
{
	env.m->c = redisConnectUnix(path);
	if (!env.m->c || env.m->c->err)
		return -1;
	return 0;
}

static char *smart_vsnprintf(char *buf, size_t size,
		const char *fmt, va_list ap)
{
	va_list aq;
	va_copy(aq, ap);

	char *s = buf;
	size_t len = vsnprintf(buf, size, fmt, ap);
	if (len >= size) {
		s = malloc(len + 1);
		vsnprintf(s, len + 1, fmt, aq);
	}

	va_end(aq);
	return s;
}

static mdb_res_t *mdb_vcmd(const char *cmd, va_list ap)
{
	char *buf = env.m->buf;
	char *s = smart_vsnprintf(buf, sizeof(env.m->buf), cmd, ap);

	mdb_res_t *res = redisCommand(env.m->c, s);

	if (s != buf)
		free(s);

	if (!res || res->type == MDB_RES_ERROR) {
		mdb_clear(res);
		return NULL;
	}
	return res;
}

mdb_res_t *mdb_cmd(const char *cmd, ...)
{
	va_list ap;
	va_start(ap, cmd);
	mdb_res_t *res = mdb_vcmd(cmd, ap);
	va_end(ap);
	return res;
}

long long mdb_get_integer(long long invalid, const char *cmd, ...)
{
	va_list ap;
	va_start(ap, cmd);
	mdb_res_t *res = mdb_vcmd(cmd, ap);
	va_end(ap);

	if (!res)
		return invalid;

	long long i;
	if (res->type == MDB_RES_INTEGER)
		i = res->integer;
	else if (res->type == MDB_RES_STRING)
		i = strtoll(res->str, NULL, 10);
	else
		i = invalid;

	mdb_clear(res);
	return i;
}
