PACKAGE	= TinyGL
VERSION	= 0.4
DESTDIR	=
PREFIX	= /usr/local
TARGETS	= $(PACKAGE)-$(VERSION)/lib/libTinyGL.a
CPPFLAGS= -nostdinc -isystem $(DESTDIR)$(PREFIX)/include
CFLAGS	= -ffreestanding
LDFLAGS	= -nostdlib
FETCH	= wget --continue
INSTALL	= install
MKDIR	= mkdir -p
MV	= mv -f
RM	= rm -f
TAR	= tar
TOUCH	= touch
ARCHIVE	= $(PACKAGE)-$(VERSION).tar.gz
MIRROR	= http://bellard.org/$(PACKAGE)/
URL	= $(MIRROR)/$(ARCHIVE)

all: $(TARGETS)

configure: $(PACKAGE)-$(VERSION)/.configure-done

download: .download-done

extract: $(PACKAGE)-$(VERSION)/.extract-done

install: $(TARGETS)
	$(MKDIR) $(DESTDIR)$(PREFIX)/lib
	$(INSTALL) -m 0644 $(PACKAGE)-$(VERSION)/src/libTinyGL.a $(DESTDIR)$(PREFIX)/lib/libTinyGL.a

patch: $(PACKAGE)-$(VERSION)/.patch-done

uninstall:
	(cd $(PACKAGE)-$(VERSION) && $(MAKE) $@)

clean:
	if [ -f $(PACKAGE)-$(VERSION)/Makefile ]; then \
		(cd $(PACKAGE)-$(VERSION) && $(MAKE) $@); \
	fi

distclean:
	$(RM) .download-done
	$(RM) -r $(PACKAGE)-$(VERSION)

.download-done:
	$(FETCH) $(URL)
	$(TOUCH) $@

$(PACKAGE)-$(VERSION)/.extract-done: .download-done
	$(TAR) -xzvf $(ARCHIVE)
	$(MV) $(PACKAGE) $(PACKAGE)-$(VERSION)
	$(TOUCH) $@

$(PACKAGE)-$(VERSION)/.patch-done: $(PACKAGE)-$(VERSION)/.extract-done
	for i in patches/*; do \
		[ -f "$$i" ] && patch -p0 < "$$i"; \
	done; \
	$(TOUCH) $@

$(PACKAGE)-$(VERSION)/.configure-done: $(PACKAGE)-$(VERSION)/.patch-done
	$(TOUCH) $@

$(PACKAGE)-$(VERSION)/lib/libTinyGL.a: $(PACKAGE)-$(VERSION)/.configure-done
	(cd $(PACKAGE)-$(VERSION)/src && $(MAKE) CC="$(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS)")

.PHONY: all clean configure distclean download extract install patch uninstall
