PACKAGE	= others
VERSION	= 0.0.2
DESTDIR	=
PREFIX	= /usr/local
TARGETS	= $(PACKAGE)-$(VERSION)/.build-done
HOST	= `uname -m | tr A-Z a-z`--`uname -s | tr A-Z a-z`
CPPFLAGS= -nostdinc -I$(DESTDIR)$(PREFIX)/include
CFLAGS	= -ffreestanding
LDFLAGS	= -nostdlib -L$(DESTDIR)$(PREFIX)/lib -Wl,-rpath-link,$(DESTDIR)$(PREFIX)/lib -Wl,$(DESTDIR)$(PREFIX)/lib/start.o -lc
FETCH	= wget --continue
RM	= rm -f
TAR	= tar
TOUCH	= touch
ARCHIVE	= $(PACKAGE)-$(VERSION).tar.gz
MIRROR	= http://www.defora.org/os/download/download/3492
URL	= $(MIRROR)/$(ARCHIVE)

all: $(TARGETS)

build: $(PACKAGE)-$(VERSION)/.build-done

download: .download-done

extract: $(PACKAGE)-$(VERSION)/.extract-done

install: $(TARGETS)
	(cd $(PACKAGE)-$(VERSION) && $(MAKE) $@)

patch: $(PACKAGE)-$(VERSION)/.patch-done

uninstall:
	(cd $(PACKAGE)-$(VERSION) && $(MAKE) $@)

clean:
	if [ -f $(PACKAGE)-$(VERSION)/Makefile ]; then \
		(cd $(PACKAGE)-$(VERSION) && $(MAKE) $@); \
	fi
	$(RM) $(TARGETS)

distclean:
	$(RM) -r $(PACKAGE)-$(VERSION)

$(PACKAGE)-$(VERSION)/.extract-done: $(ARCHIVE)
	$(TAR) -xzvf $(ARCHIVE)
	$(TOUCH) $@

$(PACKAGE)-$(VERSION)/.patch-done: $(PACKAGE)-$(VERSION)/.extract-done
	for i in patches/*; do \
		[ -f "$$i" ] && (cd $(PACKAGE)-$(VERSION) && patch -p1) \
				< "$$i"; \
	done; \
	$(TOUCH) $@

$(PACKAGE)-$(VERSION)/.build-done: $(PACKAGE)-$(VERSION)/.patch-done
	(cd $(PACKAGE)-$(VERSION) && $(MAKE) CPPFLAGS="$(CPPFLAGS)" \
			CFLAGS="$(CFLAGS)" \
			LDFLAGS="$(LDFLAGS)")
	$(TOUCH) $@

$(ARCHIVE):
	$(FETCH) $(URL)

.PHONY: all build clean distclean download extract install patch uninstall
