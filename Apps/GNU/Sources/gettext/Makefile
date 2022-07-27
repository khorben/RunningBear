PACKAGE	= gettext
VERSION	= 0.14.6
DESTDIR	=
PREFIX	= /usr/local
TARGETS	= $(PACKAGE)-$(VERSION)/gettext-runtime/src/gettext
HOST	= `uname -m | tr A-Z a-z`--`uname -s | tr A-Z a-z`
CPPFLAGS= -nostdinc -isystem $(DESTDIR)$(PREFIX)/include
CFLAGS	= -ffreestanding
LDFLAGS	= -Xcompiler -nostdlib -L$(DESTDIR)$(PREFIX)/lib -Wl,-rpath,$(DESTDIR)$(PREFIX)/lib -Wl,$(DESTDIR)$(PREFIX)/lib/start.o -Wl,-lc -Wl,-lgetopt
FETCH	= wget --continue
RM	= rm -f
TAR	= tar
TOUCH	= touch
ARCHIVE	= $(PACKAGE)-$(VERSION).tar.gz
MIRROR	= ftp://ftp.gnu.org/pub/gnu/$(PACKAGE)
URL	= $(MIRROR)/$(ARCHIVE)

all: $(TARGETS)

configure: .configure-done

download: .download-done

install: $(TARGETS)
	(cd $(PACKAGE)-$(VERSION)/gettext-runtime && $(MAKE) prefix="$(PREFIX)" $@)

extract: $(PACKAGE)-$(VERSION)/.extract-done

patch: .patch-done

uninstall:
	(cd $(PACKAGE)-$(VERSION)/gettext-runtime && $(MAKE) prefix="$(PREFIX)" $@)

clean:
	if [ -f $(PACKAGE)-$(VERSION)/gettext-runtime/Makefile ]; then \
		(cd $(PACKAGE)-$(VERSION)/gettext-runtime && \
		 $(MAKE) $@); \
	fi

distclean:
	$(RM) .configure-done .download-done .patch-done
	$(RM) -r $(PACKAGE)-$(VERSION)

.download-done:
	$(FETCH) $(URL)
	$(TOUCH) $@

$(PACKAGE)-$(VERSION)/.extract-done: download
	$(TAR) -xzvf $(ARCHIVE)
	$(TOUCH) $@

.patch-done: extract
	for i in patches/*; do \
		[ -f "$$i" ] && patch -p0 < "$$i"; \
	done; \
	$(TOUCH) $@

$(PACKAGE)-$(VERSION)/gettext-runtime/config.h: patch
	(cd $(PACKAGE)-$(VERSION) && \
	./configure \
	--prefix="$(PREFIX)" \
	--disable-csharp \
	--disable-libasprintf \
	--disable-nls \
	--host $(HOST) \
	CPPFLAGS="$(CPPFLAGS)" \
	CFLAGS="$(CFLAGS)" \
	LDFLAGS="$(LDFLAGS)")

$(PACKAGE)-$(VERSION)/gettext-runtime/src/gettext: $(PACKAGE)-$(VERSION)/gettext-runtime/config.h $(PACKAGE)-$(VERSION)/gettext-runtime/intl/libintl.a $(PACKAGE)-$(VERSION)/gettext-runtime/lib/libgrt.a
	(cd $(PACKAGE)-$(VERSION)/gettext-runtime/src && $(MAKE))

$(PACKAGE)-$(VERSION)/gettext-runtime/intl/libintl.a: $(PACKAGE)-$(VERSION)/gettext-runtime/config.h
	(cd $(PACKAGE)-$(VERSION)/gettext-runtime/intl && $(MAKE))

$(PACKAGE)-$(VERSION)/gettext-runtime/lib/libgrt.a: $(PACKAGE)-$(VERSION)/gettext-runtime/config.h
	(cd $(PACKAGE)-$(VERSION)/gettext-runtime/lib && $(MAKE))

.PHONY: all clean configure distclean download extract install patch uninstall
