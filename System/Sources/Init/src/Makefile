TARGETS	= Init
PREFIX	= /usr/local
DESTDIR	= 
BINDIR	= $(PREFIX)/bin
CC	= cc
CPPFLAGSF=
CPPFLAGS= -nostdinc -isystem $(DESTDIR)$(PREFIX)/include
CFLAGSF	= -W -Wall
CFLAGS	= -g -O2
LDFLAGSF=
LDFLAGS	= -nostdlib -L $(DESTDIR)$(PREFIX)/lib -Wl,-rpath-link,$(DESTDIR)$(PREFIX)/lib -Wl,-rpath,$(PREFIX)/lib -Wl,--export-dynamic -lSystem -lc $(DESTDIR)$(PREFIX)/lib/start.o
RM	= rm -f
MKDIR	= mkdir -m 755 -p
INSTALL	= install


all: $(TARGETS)

Init_OBJS = init.o main.o service.o session.o
Init_CFLAGS = $(CPPFLAGSF) $(CPPFLAGS) $(CFLAGSF) $(CFLAGS)

Init: $(Init_OBJS)
	$(CC) -o Init $(Init_OBJS) $(LDFLAGSF) $(LDFLAGS)

init.o: init.c session.h init.h
	$(CC) $(Init_CFLAGS) -c init.c

main.o: main.c init.h session.h ../config.h
	$(CC) $(Init_CFLAGS) -c main.c

service.o: service.c common.h service.h
	$(CC) $(Init_CFLAGS) -c service.c

session.o: session.c
	$(CC) $(Init_CFLAGS) -c session.c

clean:
	$(RM) $(Init_OBJS)

distclean: clean
	$(RM) $(TARGETS)

install: all
	$(MKDIR) $(DESTDIR)$(BINDIR)
	$(INSTALL) -m 0755 Init $(DESTDIR)$(BINDIR)/Init

uninstall:
	$(RM) $(DESTDIR)$(BINDIR)/Init

.PHONY: all clean distclean install uninstall
