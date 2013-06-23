#ifndef FB_BRC_H
#define FB_BRC_H

#include <stdint.h>

typedef uint32_t brc_item_t;

extern void brc_update(const char *userid, const char *board);
extern int brc_init(const char *uname, const char *bname);
extern int brc_initialize(const char *uname, const char *bname);

extern void brc_addlist_legacy(const char *filename);
extern bool brc_unread_legacy(const char *filename);

extern void brc_mark_as_read(brc_item_t item);
extern bool brc_unread(brc_item_t item);
extern brc_item_t brc_last_read(void);
extern void brc_clear(brc_item_t item);
extern void brc_clear_all(int bid);

extern void brc_zapbuf(int *zbuf);
extern bool brc_board_unread(const char *user, const char *bname, int bid);

#endif // FB_BRC_H
