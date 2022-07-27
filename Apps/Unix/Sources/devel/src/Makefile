TARGETS	= ar
PREFIX	= /usr/local
DESTDIR	= 
BINDIR	= $(PREFIX)/bin
CC	= cc
CPPFLAGSF= -I ../include
CPPFLAGS=
CFLAGSF	= -W
CFLAGS	= -ffreestanding -nostdinc -I $(DESTDIR)$(PREFIX)/include -Wall -g -O2
LDFLAGSF=
LDFLAGS	= -nostdlib -L $(DESTDIR)$(PREFIX)/lib -Wl,-rpath $(PREFIX)/lib -lc $(DESTDIR)$(PREFIX)/lib/start.o
RM	= rm -f
MKDIR	= mkdir -m 755 -p
INSTALL	= install


all: $(TARGETS)

ar_OBJS = ar.o
ar_CFLAGS = $(CPPFLAGSF) $(CPPFLAGS) $(CFLAGSF) $(CFLAGS)

ar: $(ar_OBJS)
	$(CC) -o ar $(ar_OBJS) $(LDFLAGSF) $(LDFLAGS)

ar.o: ar.c
	$(CC) $(ar_CFLAGS) -c ar.c

clean:
	$(RM) $(ar_OBJS)

distclean: clean
	$(RM) $(TARGETS)

install: all
	$(MKDIR) $(DESTDIR)$(BINDIR)
	$(INSTALL) -m 0755 ar $(DESTDIR)$(BINDIR)/ar

uninstall:
	$(RM) $(DESTDIR)$(BINDIR)/ar

.PHONY: all clean distclean install uninstall
