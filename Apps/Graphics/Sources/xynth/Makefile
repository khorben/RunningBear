PACKAGE	= xynth
VERSION	= 0.8.90
DESTDIR	=
PREFIX	= /usr/local
TARGETS	= $(PACKAGE)-$(VERSION)/.build-done
HOST	= `uname -m | tr A-Z a-z`--`uname -s | tr A-Z a-z`
CPPFLAGS= -nostdinc -isystem $(DESTDIR)$(PREFIX)/include
CFLAGS	= -ffreestanding
LDFLAGS	= -nostdlib -fPIC -L$(DESTDIR)$(PREFIX)/lib -Wl,-rpath-link,$(DESTDIR)$(PREFIX)/lib -Wl,-lc -Wl,-lm -Wl,-lpthread -Wl,-lsocket -Wl,-lgetopt -Wl,-lgcc -Wl,$(DESTDIR)$(PREFIX)/lib/start.o
FETCH	= wget --continue
RM	= rm -f
TAR	= tar
TOUCH	= touch
ARCHIVE	= $(PACKAGE)-$(VERSION).tar.bz2
MIRROR	= http://sourceforge.net/projects/$(PACKAGE)/files/$(PACKAGE)-$(VERSION)
URL	= $(MIRROR)/$(ARCHIVE)/download

all: $(TARGETS)

configure: $(PACKAGE)-$(VERSION)/.configure-done

download: .download-done

extract: $(PACKAGE)-$(VERSION)/.extract-done

install: $(TARGETS)
	(cd $(PACKAGE)-$(VERSION) && $(MAKE) V=1 CC="$(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS)" _INSTALLDIR="$(PREFIX)")
	(cd $(PACKAGE)-$(VERSION) && $(MAKE) V=1 _INSTALLDIR="$(DESTDIR)$(PREFIX)" $@)

patch: $(PACKAGE)-$(VERSION)/.patch-done

uninstall:
	(cd $(PACKAGE)-$(VERSION) && $(MAKE) $@)

clean:
	if [ -f $(PACKAGE)-$(VERSION)/Makefile ]; then \
		(cd $(PACKAGE)-$(VERSION) && $(MAKE) $@); \
	fi
	$(RM) $(TARGETS)

distclean:
	$(RM) .download-done
	$(RM) -r $(PACKAGE)-$(VERSION)

.download-done:
	$(FETCH) -O $(ARCHIVE) $(URL)
	$(TOUCH) $@

$(PACKAGE)-$(VERSION)/.extract-done: .download-done
	$(TAR) -xjvf $(ARCHIVE)
	$(TOUCH) $@

$(PACKAGE)-$(VERSION)/.patch-done: $(PACKAGE)-$(VERSION)/.extract-done
	for i in patches/*; do \
		[ -f "$$i" ] && patch -p0 < "$$i"; \
	done; \
	$(TOUCH) $@

$(PACKAGE)-$(VERSION)/.configure-done: $(PACKAGE)-$(VERSION)/.patch-done
	$(TOUCH) $@

$(PACKAGE)-$(VERSION)/.build-done: $(PACKAGE)-$(VERSION)/.configure-done
	(cd $(PACKAGE)-$(VERSION) && $(MAKE) V=1 CC="$(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS)" _INSTALLDIR="$(PREFIX)")
	$(TOUCH) $@

.PHONY: all clean configure distclean download extract install patch uninstall
