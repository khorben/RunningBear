PACKAGE	= glib
VERSION	= 2.18.1
DESTDIR	=
PREFIX	= /usr/local
TARGETS	= $(PACKAGE)-$(VERSION)/glib/.libs/libglib-2.0.so
HOST	= `uname -m | tr A-Z a-z`--`uname -s | tr A-Z a-z`
CPPFLAGS= -nostdinc -isystem $(DESTDIR)$(PREFIX)/include
CFLAGS	= -ffreestanding
CXXFLAGS= -ffreestanding
LDFLAGS	= -nostdlib -Wl,-nostdlib -L$(DESTDIR)$(PREFIX)/lib -Wl,-rpath-link,$(DESTDIR)$(PREFIX)/lib -Wl,$(DESTDIR)$(PREFIX)/lib/start.o -Wl,-lc -Wl,-lsocket
LIBTOOL_LDFLAGS= -inst-prefix-dir $(DESTDIR)
FETCH	= wget
INSTALL	= install
RM	= rm -f
TAR	= tar
TOUCH	= touch
ARCHIVE	= $(PACKAGE)-$(VERSION).tar.gz
MIRROR	= http://ftp.gnome.org/pub/gnome/sources/$(PACKAGE)/2.18
URL	= $(MIRROR)/$(ARCHIVE)

all: $(TARGETS)

configure: .configure-done

download: .download-done

extract: .extract-done

install: $(TARGETS)
	(cd $(PACKAGE)-$(VERSION) && $(MAKE) DESTDIR="$(DESTDIR)" LDFLAGS="$(LIBTOOL_LDFLAGS) $(LDFLAGS)" $@)

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
	--host="$(HOST)" \
	--prefix="$(PREFIX)" \
	--with-libiconv="gnu" \
	--with-threads="none" \
	--disable-selinux \
	--disable-fam \
	CPPFLAGS="$(CPPFLAGS)" \
	CFLAGS="$(CFLAGS)" \
	LDFLAGS="$(LDFLAGS)" \
	ac_cv_func_posix_getpwuid_r=no \
	ac_cv_func_posix_getgrgid_r=no \
	glib_cv_stack_grows=no \
	glib_cv_uscore=no)
	$(TOUCH) $@

$(TARGETS): .configure-done
	#hack for NetBSD/i386 at least
	[ -f "/usr/lib/libgcc_pic.a" ] && $(INSTALL) -m 644 "/usr/lib/libgcc_pic.a" "$(DESTDIR)$(PREFIX)/lib/libgcc_pic.a"
	(cd $(PACKAGE)-$(VERSION) && $(MAKE) LDFLAGS="$(LIBTOOL_LDFLAGS) $(LDFLAGS)")

.PHONY: all clean configure distclean download extract install patch uninstall
