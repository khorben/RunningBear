PACKAGE	= python
VERSION	= 2.4.5
DESTDIR	=
PREFIX	= /usr/local
TARGETS	= Python-$(VERSION)/python
HOST	= `uname -m | tr A-Z a-z`--`uname -s | tr A-Z a-z`
CPPFLAGS= -nostdinc -isystem $(DESTDIR)$(PREFIX)/include
CFLAGS	= -ffreestanding
CXXFLAGS= -ffreestanding
LDFLAGS	= -nostdlib -Wl,-nostdlib -L$(DESTDIR)$(PREFIX)/lib -Wl,-rpath-link,$(DESTDIR)$(PREFIX)/lib -Wl,$(DESTDIR)$(PREFIX)/lib/start.o -Wl,-lc
FETCH	= wget
RM	= rm -f
TAR	= tar
TOUCH	= touch
ARCHIVE	= Python-$(VERSION).tgz
MIRROR	= http://www.python.org/ftp/$(PACKAGE)/$(VERSION)
URL	= $(MIRROR)/$(ARCHIVE)

all: $(TARGETS)

configure: .configure-done

download: .download-done

extract: .extract-done

install: $(TARGETS)
	(cd Python-$(VERSION) && $(MAKE) DESTDIR="$(DESTDIR)" $@)

patch: .patch-done

uninstall:
	(cd Python-$(VERSION) && $(MAKE) DESTDIR="$(DESTDIR)" $@)

clean:
	if [ -f Python-$(VERSION)/Makefile ]; then \
		(cd Python-$(VERSION) && $(MAKE) $@); \
	fi

distclean:
	$(RM) .configure-done .download-done .extract-done .patch-done
	$(RM) -r Python-$(VERSION)

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
	(cd Python-$(VERSION) && \
	LD_LIBRARY_PATH=$(DESTDIR)$(PREFIX)/lib ./configure \
	--prefix="$(PREFIX)" \
	--host $(HOST) \
	--enable-shared \
	--with-libc="-nostdlib" \
	--with-libm="" \
	--without-cxx \
	--without-threads \
	CPPFLAGS="$(CPPFLAGS)" \
	CFLAGS="$(CFLAGS)" \
	CXXFLAGS="$(CFLAGS)" \
	BASECFLAGS="$(CPPFLAGS) $(CFLAGS)" \
	LDFLAGS="$(LDFLAGS)")
	$(TOUCH) $@

Python-$(VERSION)/python: .configure-done
	(cd Python-$(VERSION) && LD_LIBRARY_PATH=$(DESTDIR)$(PREFIX)/lib $(MAKE))

.PHONY: all clean configure distclean download extract install patch uninstall
