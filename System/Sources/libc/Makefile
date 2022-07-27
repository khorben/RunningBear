PACKAGE	= libc
VERSION	= 0.5.2
DESTDIR	=
PREFIX	= /usr/local
TARGETS	= $(PACKAGE)-$(VERSION)/.build-done
HOST	= `uname -m | tr A-Z a-z`--`uname -s | tr A-Z a-z`
FETCH	= wget --continue
CC	= gcc
RM	= rm -f
TAR	= tar
TOUCH	= touch
ARCHIVE	= $(PACKAGE)-$(VERSION).tar.gz
MIRROR	= https://ftp.defora.org/pub/DeforaOS/System/src/libc/
URL	= $(MIRROR)/$(ARCHIVE)

all: $(TARGETS)

build: $(PACKAGE)-$(VERSION)/.build-done

download: $(ARCHIVE)

extract: $(PACKAGE)-$(VERSION)/.extract-done

install: $(TARGETS)
	(cd $(PACKAGE)-$(VERSION) && $(MAKE) CC="$(CC)" $@)

patch: $(PACKAGE)-$(VERSION)/.patch-done

uninstall:
	(cd $(PACKAGE)-$(VERSION) && $(MAKE) CC="$(CC)" $@)

clean:
	if [ -f $(PACKAGE)-$(VERSION)/Makefile ]; then \
		(cd $(PACKAGE)-$(VERSION) && $(MAKE) CC="$(CC)" $@); \
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

$(PACKAGE)-$(VERSION)/.build-done: patch
	(cd $(PACKAGE)-$(VERSION) && $(MAKE) CC="$(CC)")
	$(TOUCH) $@

$(ARCHIVE):
	$(FETCH) $(URL)

.PHONY: all build clean distclean download extract install patch uninstall
