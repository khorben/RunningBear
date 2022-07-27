PACKAGE	= openssl
VERSION	= 0.9.8zf
DESTDIR	=
PREFIX	= /usr/local
TARGETS	= $(PACKAGE)-$(VERSION)/config.h
HOST	= `uname -m | tr A-Z a-z`--`uname -s | tr A-Z a-z`
CPPFLAGS= -nostdinc -I$(DESTDIR)$(PREFIX)/include -DNO_SYS_PARAM_H -DTERMIOS
CFLAGS	= -ffreestanding
LDFLAGS	= -nostdlib -L$(DESTDIR)$(PREFIX)/lib -Wl,-rpath-link,$(DESTDIR)$(PREFIX)/lib -Wl,$(DESTDIR)$(PREFIX)/lib/start.o -lc -lsocket
FETCH	= wget
RM	= rm -f
TAR	= tar
TOUCH	= touch
ARCHIVE	= $(PACKAGE)-$(VERSION).tar.gz
MIRROR	= http://www.openssl.org/source
URL	= $(MIRROR)/$(ARCHIVE)

all: $(TARGETS)

configure: $(PACKAGE)-$(VERSION)/.configure-done

download: .download-done

extract: $(PACKAGE)-$(VERSION)/.extract-done

install: $(TARGETS)
	(cd $(PACKAGE)-$(VERSION) && $(MAKE) INSTALL_PREFIX="$(DESTDIR)" install_sw)

patch: $(PACKAGE)-$(VERSION)/.patch-done

uninstall:
	(cd $(PACKAGE)-$(VERSION) && $(MAKE) DESTDIR="$(DESTDIR)" $@)

clean:
	if [ -f $(PACKAGE)-$(VERSION)/Makefile ]; then \
		(cd $(PACKAGE)-$(VERSION) && $(MAKE) $@); \
	fi

distclean:
	$(RM) -r $(PACKAGE)-$(VERSION)

$(PACKAGE)-$(VERSION)/.extract-done: $(ARCHIVE)
	$(RM) -r $(PACKAGE)-$(VERSION)
	$(TAR) -xzvf $(ARCHIVE)
	$(TOUCH) $@

$(PACKAGE)-$(VERSION)/.patch-done: $(PACKAGE)-$(VERSION)/.extract-done
	for i in patches/*; do \
		[ -f "$$i" ] && (cd $(PACKAGE)-$(VERSION) && patch -p1) \
				< "$$i"; \
	done; \
	$(TOUCH) $@

.download-done: $(ARCHIVE)
	$(TOUCH) $@

$(ARCHIVE):
	$(FETCH) $(URL)

$(PACKAGE)-$(VERSION)/.configure-done: $(PACKAGE)-$(VERSION)/.patch-done
	(cd $(PACKAGE)-$(VERSION) && \
	./Configure \
	--prefix="$(PREFIX)" \
	no-asm \
	$(CPPFLAGS) \
	$(CFLAGS) \
	$(LDFLAGS) \
	shared linux-elf)
	$(TOUCH) $@

$(PACKAGE)-$(VERSION)/config.h: $(PACKAGE)-$(VERSION)/.configure-done
	(cd $(PACKAGE)-$(VERSION) && $(MAKE))

.PHONY: all clean configure distclean download extract install patch uninstall
