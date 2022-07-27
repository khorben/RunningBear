PACKAGE	= getopt
VERSION	= 2.5
DESTDIR	=
PREFIX	= /usr/local
TARGETS	= $(PACKAGE)-$(VERSION)/libgetopt.a
HOST	= `uname -m | tr A-Z a-z`--`uname -s | tr A-Z a-z`
CPPFLAGS= -nostdinc -isystem $(DESTDIR)$(PREFIX)/include
CFLAGS	= -ffreestanding
LDFLAGS	= -Xcompiler -nostdlib -L$(DESTDIR)$(PREFIX)/lib -Wl,-rpath-link,$(DESTDIR)$(PREFIX)/lib -Wl,$(DESTDIR)$(PREFIX)/lib/start.o -Wl,-lc
FETCH	= wget --continue
RM	= rm -f
TAR	= tar
TOUCH	= touch
ARCHIVE	= $(PACKAGE)-$(VERSION).tar.gz
MIRROR	= ftp://ftp.math.utah.edu/pub/$(PACKAGE)
URL	= $(MIRROR)/$(ARCHIVE)

all: $(TARGETS)

configure: .configure-done

download: .download-done

extract: .extract-done

install: $(TARGETS)
	(cd $(PACKAGE)-$(VERSION) && $(MAKE) prefix="$(DESTDIR)$(PREFIX)" $@)

patch: .patch-done

uninstall:
	(cd $(PACKAGE)-$(VERSION) && $(MAKE) prefix="$(DESTDIR)$(PREFIX)" $@)

clean:
	if [ -f $(PACKAGE)-$(VERSION)/Makefile ]; then \
		(cd $(PACKAGE)-$(VERSION) && $(MAKE) $@); \
	fi

distclean:
	$(RM) .configure-done .download-done .extract-done .patch-done
	$(RM) -r $(PACKAGE)-$(VERSION)

.download-done:
	$(FETCH) $(URL)
	$(TOUCH) $@

.extract-done: .download-done
	$(TAR) -xzvf $(ARCHIVE)
	$(TOUCH) $@

.patch-done: .extract-done
	for i in patches/*; do \
		[ -f "$$i" ] && patch -p0 < "$$i"; \
	done; \
	$(TOUCH) $@

$(PACKAGE)-$(VERSION)/config.h: .patch-done
	(cd $(PACKAGE)-$(VERSION) && \
	./configure \
	--prefix="$(PREFIX)" \
	--host $(HOST) \
	CPPFLAGS="$(CPPFLAGS)" \
	CFLAGS="$(CFLAGS)" \
	LDFLAGS="$(LDFLAGS)")

$(PACKAGE)-$(VERSION)/libgetopt.a: $(PACKAGE)-$(VERSION)/config.h
	(cd $(PACKAGE)-$(VERSION) && $(MAKE))

.PHONY: all clean configure distclean download extract install patch uninstall
