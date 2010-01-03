#include "libweb.h"

int bbspreupload_main(void)
{
	char *board = getparm("board");
	if (!loginok)
		return BBS_ELGNREQ;
	struct boardheader *bp = getbcache(board);
	if (bp == NULL || !haspostperm(&currentuser, bp))
		return BBS_EPST;

	char path[HOMELEN];
	snprintf(path, sizeof(path), BBSHOME"/upload/%s", bp->filename);
	if (!dashd(path))
		return BBS_ENODIR;

	xml_header("bbspreupload");
	printf("<bbspreupload><board>%s</board><user>%s</user><max>%d</max>"
			"</bbspreupload>", board, currentuser.userid, maxlen(board));
	return 0;
}
