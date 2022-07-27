PACKAGE	= libiconv
VERSION	= 1.12
DESTDIR	=
PREFIX	= /usr/local
TARGETS	= $(PACKAGE)-$(VERSION)/src/iconv
HOST	= `uname -m | tr A-Z a-z`--`uname -s | tr A-Z a-z`
CPPFLAGS= -nostdinc -isystem $(DESTDIR)$(PREFIX)/include
CFLAGS	= -ffreestanding
CXXFLAGS= -ffreestanding
LDFLAGS	= -Xcompiler -nostdlib -L$(DESTDIR)$(PREFIX)/lib -Wl,-rpath,$(DESTDIR)$(PREFIX)/lib -Wl,$(DESTDIR)$(PREFIX)/lib/start.o -Wl,-lc
FETCH	= wget
RM	= rm -f
TAR	= tar
TOUCH	= touch
ARCHIVE	= $(PACKAGE)-$(VERSION).tar.gz
MIRROR	= http://ftp.gnu.org/pub/gnu/$(PACKAGE)
URL	= $(MIRROR)/$(ARCHIVE)

all: $(TARGETS)

configure: .configure-done

download: .download-done

extract: .extract-done

install: $(TARGETS)
	(cd $(PACKAGE)-$(VERSION) && $(MAKE) DESTDIR="$(DESTDIR)" $@)

patch: .patch-done

uninstall:
	(cd $(PACKAGE)-$(VERSION) && $(MAKE) DESTDIR="$(DESTDIR)" $@)

clean:
	if [ -f $(PACKAGE)-$(VERSION)/Makefile ]; then \
		(cd $(PACKAGE)-$(VERSION) && $(MAKE) $@); \
	fi

distclean:
	$(RM) .configure-done .download-done .extract-done .patch-done
	$(RM) -r $(PACKAGE)-$(VERSION)

.extract-done: $(ARCHIVE)
	$(TAR) -xzvf $(ARCHIVE)
	$(TOUCH) $@

.patch-done: .extract-done
	for i in patches/*; do \
		[ -f "$$i" ] && patch -p0 < "$$i"; \
	done; \
	$(TOUCH) $@

$(ARCHIVE):
	$(FETCH) $(URL)

.configure-done: .patch-done
	(cd $(PACKAGE)-$(VERSION) && \
	./configure \
	--prefix="$(PREFIX)" \
	--host=$(HOST) \
	CPPFLAGS="$(CPPFLAGS)" \
	CFLAGS="$(CFLAGS)" \
	LDFLAGS="$(LDFLAGS)")
	$(TOUCH) $@

$(PACKAGE)-$(VERSION)/src/iconv: .configure-done
	(cd $(PACKAGE)-$(VERSION) && $(MAKE))

.PHONY: all clean configure distclean download extract install patch uninstall
